#include <Arduino.h>
#include <SPI.h>
#include <WiFi.h>

#define DATAPIN    26
#define CLOCKPIN   27

const char* ssid = "xxx";
const char* password = "xxx";

static const int spiClk = 400000; 

SPIClass * hspi = NULL; //uninitalised pointers to SPI object

uint8_t *displayBuffer;

WiFiServer wifiServer(81);

void WiFiEvent(WiFiEvent_t event, WiFiEventInfo_t info) {
    switch (event) {

        case SYSTEM_EVENT_STA_START:
            WiFi.setHostname("FipDots");
            break;
        case SYSTEM_EVENT_STA_CONNECTED:
            Serial.println("STA connected");
            break;
        case SYSTEM_EVENT_STA_GOT_IP:
            Serial.println("STA got IP");
            Serial.print("STA SSID: ");
            Serial.println(WiFi.SSID());
            Serial.print("STA IPv4: ");
            Serial.println(WiFi.localIP());
            Serial.print("MAC address: ");
            Serial.println(WiFi.macAddress());

            wifiServer.begin();
            
            break;
        case SYSTEM_EVENT_STA_DISCONNECTED:
            Serial.print("STA Disconnected. ");
            Serial.println(info.disconnected.reason);
            WiFi.persistent(false);
            WiFi.disconnect(true);
            ESP.restart();
            break;
        default:
            break;
    }
}
void connectWiFi() {
    WiFi.persistent(false);
    WiFi.disconnect(true);
    WiFi.mode(WIFI_OFF);
    WiFi.mode(WIFI_STA);

    WiFi.onEvent(WiFiEvent);
    WiFi.begin(ssid, password);
    Serial.println(F("WiFi connexion ongoing"));
}

void setup() {

  hspi = new SPIClass(HSPI);
  hspi->begin(CLOCKPIN, 12, DATAPIN, 14); //SCLK, MISO, MOSI, SS

  displayBuffer = (uint8_t *)malloc(24 * 16);

  Serial.begin(115200);
  while (!Serial) { ; }
  delay(500); 

  connectWiFi();
  delay(1000);

  for(int i=0; i<384; i++){
    displayBuffer[i] = 0x01;
  }

  hspi->beginTransaction(SPISettings(spiClk, MSBFIRST, SPI_MODE0));
  hspi->transferBytes(displayBuffer , NULL, (24*16));
  hspi->endTransaction();

}

int count = 0;
int frameCount=0;

void loop() {

  WiFiClient client = wifiServer.available();
 
  if (client) {
 
    while (client.connected()) {
      while (client.available()>0) {
        char c = client.read();
        // Serial.print(c, HEX);
        // Serial.print(' ');
        displayBuffer[count] = c;
        count++;
        if (count>=384) {
          count = 0;
          Serial.println(frameCount++);
          
          hspi->beginTransaction(SPISettings(spiClk, MSBFIRST, SPI_MODE0));
          hspi->transferBytes(displayBuffer , NULL, (24*16));
          hspi->endTransaction();

          delay(15);
        } 
      }
 
      delay(15);
    }

    client.stop();
    Serial.println("\nClient disconnected\n");
    count = 0;
    frameCount = 0;
  }
  delay(1);

}
