package neonpixel;

import java.awt.AWTException;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Graphics2D;
import java.awt.GridBagLayout;
import java.awt.GridLayout;
import java.awt.MouseInfo;
import java.awt.Rectangle;
import java.awt.Robot;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.Timer;
import java.util.TimerTask;

import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTabbedPane;
import javax.swing.JTextArea;
import javax.swing.SwingUtilities;

import slit_tests.Dithering;

public class NeonPixelControl extends JTabbedPane implements MouseListener{
	private static final int DOT_WIDTH = 24;
	private static final int DOT_HEIGHT = 16;
	private static final int DOT_SIZE = 7;
	private static final int DOT_SPACING = 4;
	private static final int DOT_UPSCALE = 16;

	private static boolean cursorSet = false;
	private static boolean cursorClear = false;
	private static Dot[][] dotMatrix = new Dot[DOT_WIDTH][DOT_HEIGHT];
	
	private JTextArea outputTextArea;
	private Socket socket;
	private OutputStream outputStream;
	private Robot robot;
	private static int[] pixList = new int[DOT_HEIGHT * DOT_WIDTH];
	private int frameCount = 0;
	
	public NeonPixelControl() throws UnknownHostException, IOException {
		SwingUtilities.invokeLater(new Runnable() {
			@Override
			public void run() {
				buildGUI();
			}
		});
		
		socket = new Socket("192.168.1.40", 81);
		outputStream = socket.getOutputStream();
		
		try {
			robot = new Robot();
		} catch (AWTException e) {
			e.printStackTrace();
		}
		
		
		
		Timer t = new Timer();
		t.scheduleAtFixedRate(new CaptureTaskDither(), 15, 30);
		t.scheduleAtFixedRate(new UpdateOutput(), 1000, 30);
	}

	private void buildGUI() {
		setPreferredSize(new Dimension(30+DOT_WIDTH*(DOT_SIZE+DOT_SPACING), 50+DOT_HEIGHT*(DOT_SIZE+DOT_SPACING)));
		
		JPanel dotMatrixPanel = new JPanel(new GridLayout(DOT_HEIGHT, DOT_WIDTH, DOT_SPACING, DOT_SPACING)); 
		dotMatrixPanel.setPreferredSize(new Dimension(DOT_WIDTH*(DOT_SIZE+DOT_SPACING), DOT_HEIGHT*(DOT_SIZE+DOT_SPACING)));
		dotMatrixPanel.setBackground(Color.GRAY);
		dotMatrixPanel.addMouseListener(this);
		for (int i = 0; i < (DOT_HEIGHT); i++) {
			for (int j = 0; j < DOT_WIDTH; j++) {
				Dot dot = new Dot(j+i*DOT_HEIGHT);
				dotMatrixPanel.add(dot);
				dotMatrix[j][i] = dot;
			}
		}
		JPanel mainDotPanel = new JPanel(new FlowLayout());
		mainDotPanel.add(dotMatrixPanel, BorderLayout.WEST);
		
		addTab("Dot Matrix", mainDotPanel);

		JPanel controlPanel = new JPanel(new GridBagLayout());
		addTab("Controls", controlPanel);

		JPanel outputPanel = new JPanel(new BorderLayout());
		outputTextArea = new JTextArea("to init");
		outputTextArea.setLineWrap(true);
		outputPanel.add(outputTextArea, BorderLayout.CENTER);
		addTab("Output", outputPanel);
	}

	@Override
	public void mouseClicked(MouseEvent e) {}

	@Override
	public void mousePressed(MouseEvent e) {
		if ( e.getButton() == 1 ) cursorSet = true;
		else if (e.getButton() == 3) cursorClear = true;
		else {
			cursorSet = false;
			cursorClear = false;
		}
	}

	@Override
	public void mouseReleased(MouseEvent e) {
		cursorSet = false;
		cursorClear = false;
	}

	@Override
	public void mouseEntered(MouseEvent e) {}
	
	@Override
	public void mouseExited(MouseEvent e) {}

	public static void main(String[] args) throws UnknownHostException, IOException {

		JFrame frame = new JFrame("Flip-Dot Simulator");
		frame.setLayout(new BorderLayout());
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		NeonPixelControl main = new NeonPixelControl();
		frame.add(main, BorderLayout.CENTER );
		frame.setBackground(Color.WHITE);
		frame.pack();
		frame.setVisible(true);
	}
	
	private class UpdateOutput extends TimerTask {

		@Override
		public void run() {
			byte[] frame = new byte[(int) (DOT_HEIGHT*DOT_WIDTH)];
			int count = 0;
			int x, y;
			for (int lane = (int) (DOT_HEIGHT/8.0)-1; lane >= 0 ; lane--) {
				for (int col = DOT_WIDTH-1; col >= 0; col--) {
					for (int i=7; i>=0; i--){
						x = col;
						y = lane*8 +i;
						frame[count] = (byte) (pixList[ y*DOT_WIDTH +x  ] );
						count++;
					}
				}
			}
			
//			for (int i = 0; i < (DOT_HEIGHT*DOT_WIDTH); i++) {
//				frame[i] = (byte) (pixList[i] / 8);
//			}
			
			try {
				outputStream.write(frame);
				outputStream.flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			
			System.out.println(frameCount++);
		}
		
	}
	
	
	private class CaptureTaskDither extends TimerTask {

		@Override
		public void run() {
			Rectangle screenRectangle = new Rectangle(
					MouseInfo.getPointerInfo().getLocation().x - (DOT_WIDTH*DOT_UPSCALE/2), MouseInfo.getPointerInfo().getLocation().y - (DOT_HEIGHT*DOT_UPSCALE/2),
					DOT_WIDTH*DOT_UPSCALE, DOT_HEIGHT*DOT_UPSCALE);
			final BufferedImage sourceImage = robot.createScreenCapture(screenRectangle);
			final BufferedImage monoImage = new BufferedImage(DOT_WIDTH, DOT_HEIGHT, BufferedImage.TYPE_BYTE_GRAY); 
			
			Graphics2D g2d = monoImage.createGraphics();
			g2d.drawImage(sourceImage,0, 0, DOT_WIDTH, DOT_HEIGHT, null); 
			g2d.dispose();
			
			monoImage.getData().getPixels(0, 0, DOT_WIDTH, DOT_HEIGHT, pixList);
			
			
//			pixList = Dithering.expandHistogram(pixList);
			
			pixList = Dithering.gammaCorrection(pixList, 0.3);
			for (int i = 0; i < pixList.length; i++) {
				pixList[i] = pixList[i] / 4;
				pixList[i] = 0x7F & pixList[i];
			}
			
			for (int y = 0; y < DOT_HEIGHT; y++) {
				for (int x = 0; x < DOT_WIDTH; x++) {
					dotMatrix[x][y].set(pixList[x+y*DOT_WIDTH]);
				}
			}
			
		}
	}

	private class Dot extends JLabel implements MouseListener {
		private int index = 0;
		private boolean state = false;

		public Dot(int index) {
			this.index = index;
			addMouseListener(this);
			setSize(DOT_SIZE, DOT_SIZE);
			setOpaque(true);
			setBackground(Color.BLACK);
		}

		public boolean isSet(){
			return state;
		}
		
		private void set(final int color){
			SwingUtilities.invokeLater(new Runnable() {
				@Override
				public void run() {
					setBackground(new Color(color*2, color/2, 0));
					state = color>1;
				}
			});
		}

		private void set(){
			SwingUtilities.invokeLater(new Runnable() {
				@Override
				public void run() {
					setBackground(Color.YELLOW);
					state = true;
				}
			});
		}

		private void clear(){
			SwingUtilities.invokeLater(new Runnable() {
				@Override
				public void run() {
					setBackground(Color.BLACK);
					state = false;
				}
			});
		}

		@Override
		public void mouseClicked(MouseEvent e) {

		}

		@Override
		public void mousePressed(MouseEvent e) {
			if ( e.getButton() == 1 ) cursorSet = true;
			else if (e.getButton() == 3) cursorClear = true;
			else {
				cursorSet = false;
				cursorClear = false;
			}
			if(cursorSet) set();
			if(cursorClear) clear();
		}

		@Override
		public void mouseReleased(MouseEvent e) {
			cursorSet = false;
			cursorClear = false;
		}

		@Override
		public void mouseEntered(MouseEvent e) {
			if(cursorSet) set();
			if(cursorClear) clear();
		}

		@Override
		public void mouseExited(MouseEvent e) {

		}

	}
	
	final static char[] hexArray = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
//	final static String[] asciiStringArray = {"0x30", "0x31", "0x32", "0x33", "0x34", "0x35", "0x36", "0x37", "0x38", "0x39", "0x41", "0x42", "0x43", "0x44", "0x45", "0x46"};
	final static byte[] asciiBytesArray = {0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46};

	public static byte[] byteToasciiByte(byte aByte){
		byte[] converted = new byte[2];
		int v = aByte & 0xFF;
		converted[0] = asciiBytesArray[v >>> 4];
		converted[1] = asciiBytesArray[v & 0x0F];
		return converted;
	}
	
	public static String bytesToHex(byte[] bytes) {
		char[] hexChars = new char[bytes.length * 5];
		int v;
		for ( int j = 0; j < bytes.length; j++ ) {
			v = bytes[j] & 0xFF;
			hexChars[j * 5 + 0] = '0';
			hexChars[j * 5 + 1] = 'x';
			hexChars[j * 5 + 2] = hexArray[v >>> 4];
			hexChars[j * 5 + 3] = hexArray[v & 0x0F];
			hexChars[j * 5 + 4] = ' ';
		}
		return new String(hexChars);
	}

	public static String byteToHex(byte aByte) {
		int v = aByte & 0xFF;
		return new String ( new char[] {'0', 'x', hexArray[v >>> 4], hexArray[v & 0x0F]} );
	}

	public static byte reverseBitOrder(byte b) {
		int converted = 0x00;
		converted ^= (b & 0b1000_0000) >> 7;
		converted ^= (b & 0b0100_0000) >> 5;
		converted ^= (b & 0b0010_0000) >> 3;
		converted ^= (b & 0b0001_0000) >> 1;
		converted ^= (b & 0b0000_1000) << 1;
		converted ^= (b & 0b0000_0100) << 3;
		converted ^= (b & 0b0000_0010) << 5;
		converted ^= (b & 0b0000_0001) << 7;

		return (byte) (converted & 0xFF);
	}

}
