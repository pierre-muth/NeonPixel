EESchema Schematic File Version 4
LIBS:neonpixel-cache
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L neonpixel:PIC16F15313 U1
U 1 1 5EAE9375
P 5300 2100
F 0 "U1" H 5300 2515 50  0000 C CNN
F 1 "PIC16F15313" H 5300 2424 50  0000 C CNN
F 2 "SMD_Packages:SOIC-8-N" H 5300 2100 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/40001897A.pdf" H 5300 2100 50  0001 C CNN
	1    5300 2100
	1    0    0    -1  
$EndComp
$Comp
L Transistor_FET:BSS138 Q1
U 1 1 5EAE9CA1
P 7500 2250
F 0 "Q1" H 7706 2296 50  0000 L CNN
F 1 "PMV280ENEAR" H 7706 2205 50  0000 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-23" H 7700 2175 50  0001 L CIN
F 3 "https://www.fairchildsemi.com/datasheets/BS/BSS138.pdf" H 7500 2250 50  0001 L CNN
	1    7500 2250
	1    0    0    -1  
$EndComp
$Comp
L Device:D_Schottky D1
U 1 1 5EAEBEA7
P 7850 1600
F 0 "D1" H 7750 1400 50  0000 C CNN
F 1 "S110FA " H 7650 1500 50  0000 C CNN
F 2 "neonpixel:SMD_Diode" H 7850 1600 50  0001 C CNN
F 3 "~" H 7850 1600 50  0001 C CNN
	1    7850 1600
	-1   0    0    1   
$EndComp
$Comp
L Device:R R2
U 1 1 5EAEC3E7
P 7200 2500
F 0 "R2" H 7270 2546 50  0000 L CNN
F 1 "100K" H 7270 2455 50  0000 L CNN
F 2 "Resistors_SMD:R_0805" V 7130 2500 50  0001 C CNN
F 3 "~" H 7200 2500 50  0001 C CNN
	1    7200 2500
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 5EAEC980
P 8700 2200
F 0 "R1" H 8770 2246 50  0000 L CNN
F 1 "100K" H 8770 2155 50  0000 L CNN
F 2 "Resistors_SMD:R_0805" V 8630 2200 50  0001 C CNN
F 3 "~" H 8700 2200 50  0001 C CNN
	1    8700 2200
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 5EAECE88
P 8300 2150
F 0 "C2" H 8415 2196 50  0000 L CNN
F 1 "1n" H 8415 2105 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 8338 2000 50  0001 C CNN
F 3 "~" H 8300 2150 50  0001 C CNN
	1    8300 2150
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 5EAED232
P 6850 1900
F 0 "C1" H 6965 1946 50  0000 L CNN
F 1 "100n" H 6965 1855 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 6888 1750 50  0001 C CNN
F 3 "~" H 6850 1900 50  0001 C CNN
	1    6850 1900
	1    0    0    -1  
$EndComp
$Comp
L Device:L L1
U 1 1 5EAED63B
P 7300 1600
F 0 "L1" V 7490 1600 50  0000 C CNN
F 1 "10uH LQH32PN100MN0L" V 7400 1600 50  0000 C CNN
F 2 "neonpixel:SMD_inductor" H 7300 1600 50  0001 C CNN
F 3 "~" H 7300 1600 50  0001 C CNN
	1    7300 1600
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7450 1600 7600 1600
Wire Wire Line
	7600 2050 7600 1600
Connection ~ 7600 1600
Wire Wire Line
	7600 1600 7700 1600
Wire Wire Line
	8000 1600 8300 1600
Wire Wire Line
	8300 1600 8300 2000
Wire Wire Line
	7300 2250 7200 2250
Wire Wire Line
	7200 2250 7200 2350
Wire Wire Line
	7150 1600 6850 1600
Wire Wire Line
	6850 1600 6850 1750
$Comp
L power:GND #PWR07
U 1 1 5EAF3360
P 7200 2750
F 0 "#PWR07" H 7200 2500 50  0001 C CNN
F 1 "GND" H 7205 2577 50  0000 C CNN
F 2 "" H 7200 2750 50  0001 C CNN
F 3 "" H 7200 2750 50  0001 C CNN
	1    7200 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	7200 2750 7200 2650
$Comp
L power:GND #PWR08
U 1 1 5EAF3D57
P 7600 2750
F 0 "#PWR08" H 7600 2500 50  0001 C CNN
F 1 "GND" H 7605 2577 50  0000 C CNN
F 2 "" H 7600 2750 50  0001 C CNN
F 3 "" H 7600 2750 50  0001 C CNN
	1    7600 2750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR06
U 1 1 5EAF40D4
P 6850 2750
F 0 "#PWR06" H 6850 2500 50  0001 C CNN
F 1 "GND" H 6855 2577 50  0000 C CNN
F 2 "" H 6850 2750 50  0001 C CNN
F 3 "" H 6850 2750 50  0001 C CNN
	1    6850 2750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR09
U 1 1 5EAF4485
P 8300 2750
F 0 "#PWR09" H 8300 2500 50  0001 C CNN
F 1 "GND" H 8305 2577 50  0000 C CNN
F 2 "" H 8300 2750 50  0001 C CNN
F 3 "" H 8300 2750 50  0001 C CNN
	1    8300 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	7600 2450 7600 2750
Wire Wire Line
	8300 2300 8300 2750
Wire Wire Line
	6850 2750 6850 2050
Wire Wire Line
	7200 2250 5950 2250
Connection ~ 7200 2250
$Comp
L power:+5V #PWR03
U 1 1 5EAF55B2
P 6600 1450
F 0 "#PWR03" H 6600 1300 50  0001 C CNN
F 1 "+5V" H 6615 1623 50  0000 C CNN
F 2 "" H 6600 1450 50  0001 C CNN
F 3 "" H 6600 1450 50  0001 C CNN
	1    6600 1450
	1    0    0    -1  
$EndComp
Connection ~ 6850 1600
$Comp
L Connector:Conn_01x02_Female J1
U 1 1 5EAF66E3
P 9050 1600
F 0 "J1" H 9078 1576 50  0000 L CNN
F 1 "Conn_01x02_Female" H 9078 1485 50  0000 L CNN
F 2 "neonpixel:NeonPins" H 9050 1600 50  0001 C CNN
F 3 "~" H 9050 1600 50  0001 C CNN
	1    9050 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	8850 1600 8300 1600
Connection ~ 8300 1600
Wire Wire Line
	8850 1700 8700 1700
Wire Wire Line
	8700 1700 8700 2050
$Comp
L power:GND #PWR010
U 1 1 5EAF90C0
P 8700 2750
F 0 "#PWR010" H 8700 2500 50  0001 C CNN
F 1 "GND" H 8705 2577 50  0000 C CNN
F 2 "" H 8700 2750 50  0001 C CNN
F 3 "" H 8700 2750 50  0001 C CNN
	1    8700 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	8700 2750 8700 2350
$Comp
L power:+5V #PWR02
U 1 1 5EAFB1CE
P 4550 1450
F 0 "#PWR02" H 4550 1300 50  0001 C CNN
F 1 "+5V" H 4565 1623 50  0000 C CNN
F 2 "" H 4550 1450 50  0001 C CNN
F 3 "" H 4550 1450 50  0001 C CNN
	1    4550 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	4650 1950 4550 1950
Wire Wire Line
	4550 1950 4550 1450
$Comp
L power:GND #PWR05
U 1 1 5EAFC817
P 6100 2750
F 0 "#PWR05" H 6100 2500 50  0001 C CNN
F 1 "GND" H 6105 2577 50  0000 C CNN
F 2 "" H 6100 2750 50  0001 C CNN
F 3 "" H 6100 2750 50  0001 C CNN
	1    6100 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	5950 1950 6100 1950
Wire Wire Line
	6100 1950 6100 2750
$Comp
L power:+5V #PWR01
U 1 1 5EAFEFD7
P 4700 3250
F 0 "#PWR01" H 4700 3100 50  0001 C CNN
F 1 "+5V" H 4715 3423 50  0000 C CNN
F 2 "" H 4700 3250 50  0001 C CNN
F 3 "" H 4700 3250 50  0001 C CNN
	1    4700 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	4850 3500 4700 3500
Wire Wire Line
	4700 3500 4700 3250
$Comp
L power:GND #PWR04
U 1 1 5EAFFF56
P 5700 3900
F 0 "#PWR04" H 5700 3650 50  0001 C CNN
F 1 "GND" H 5705 3727 50  0000 C CNN
F 2 "" H 5700 3900 50  0001 C CNN
F 3 "" H 5700 3900 50  0001 C CNN
	1    5700 3900
	1    0    0    -1  
$EndComp
Wire Wire Line
	5550 3700 5700 3700
Wire Wire Line
	5700 3700 5700 3900
Text Label 4400 3600 0    50   ~ 0
SCKin
Text Label 4400 3700 0    50   ~ 0
SDAin
Text Label 5950 3500 0    50   ~ 0
SCKout
Text Label 5950 3600 0    50   ~ 0
SDAout
Wire Wire Line
	5950 3500 5550 3500
Wire Wire Line
	5550 3600 5950 3600
Wire Wire Line
	4850 3600 4400 3600
Wire Wire Line
	4400 3700 4850 3700
Text Label 6300 2150 0    50   ~ 0
SDAout
Text Label 4300 2050 0    50   ~ 0
SCKin
Text Label 4300 2150 0    50   ~ 0
SDAin
Wire Wire Line
	4300 2150 4650 2150
Wire Wire Line
	4650 2050 4300 2050
Wire Wire Line
	5950 2150 6300 2150
Text Label 7800 3700 0    50   ~ 0
Vpp
Text Label 4300 2250 0    50   ~ 0
Vpp
Wire Wire Line
	4300 2250 4650 2250
Text Label 6300 2050 0    50   ~ 0
SCKout
Wire Wire Line
	6300 2050 5950 2050
Wire Wire Line
	7450 3700 7800 3700
$Comp
L Connector:Conn_01x01_Female J4
U 1 1 5EB1C667
P 7250 3700
F 0 "J4" H 7142 3475 50  0000 C CNN
F 1 "Conn_01x01_Female" H 7142 3566 50  0000 C CNN
F 2 "neonpixel:SMD_pad" H 7250 3700 50  0001 C CNN
F 3 "~" H 7250 3700 50  0001 C CNN
	1    7250 3700
	-1   0    0    1   
$EndComp
$Comp
L Connector:Conn_01x03_Female J2
U 1 1 5EB1D17B
P 5050 3600
F 0 "J2" H 5078 3626 50  0000 L CNN
F 1 "Conn_01x03_Female" H 5078 3535 50  0000 L CNN
F 2 "neonpixel:SMD_3_pin_254" H 5050 3600 50  0001 C CNN
F 3 "~" H 5050 3600 50  0001 C CNN
	1    5050 3600
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x03_Female J3
U 1 1 5EB1DEC1
P 5350 3600
F 0 "J3" H 5242 3275 50  0000 C CNN
F 1 "Conn_01x03_Female" H 5242 3366 50  0000 C CNN
F 2 "neonpixel:SMD_3_pin_254" H 5350 3600 50  0001 C CNN
F 3 "~" H 5350 3600 50  0001 C CNN
	1    5350 3600
	-1   0    0    1   
$EndComp
Wire Wire Line
	6600 1600 6600 1450
Wire Wire Line
	6850 1600 6600 1600
$EndSCHEMATC
