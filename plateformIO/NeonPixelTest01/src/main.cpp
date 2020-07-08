#include <Arduino.h>
#include <WiFi.h>
#include "time.h"
#include "Adafruit_GFX.h"
#include "NeonPixelMatrix.h"
#include <Muth01_4.h>

// constants
const char* ntpServer = "pool.ntp.org";
const char* ssid = "xxx";
const char* password = "xxx";
const uint16_t char_place[] = {0, 8, 17, 25, 34, 42};

// global vars
struct tm timeinfo;
uint8_t time_digits[] = {0,0,0,0,0,0};
uint8_t time_digits_old[] = {0,0,0,0,0,0};
NeonPixelMatrix neonPixelMatrix = NeonPixelMatrix(200, 24);
uint8_t color = 0x40;

void WiFiEvent(WiFiEvent_t event, WiFiEventInfo_t info) {
    switch (event) {

        case SYSTEM_EVENT_STA_START:
            WiFi.setHostname("NeonPixels");
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
            //init and get the time
            configTime(3600, 3600, ntpServer, ntpServer, ntpServer);
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

// get time with NTP
void getTime() {
    if (!WiFi.isConnected()) {
        Serial.println("Not connected");
        return;
      }
    // get time
    if (!getLocalTime(&timeinfo)) {
        Serial.println("Failed to obtain time");
        return;
    }

    Serial.print(&timeinfo, "%A %d %B %Y %H:%M:%S");
    Serial.print(", RSSI: ");
    Serial.print(WiFi.RSSI());
    Serial.print(", Free Heap: ");
    Serial.println(ESP.getFreeHeap());

    // generate time numbers
    for (int i=0; i<6; i++){
      time_digits_old[i] = time_digits[i];  
    }

    time_digits[5] = timeinfo.tm_sec % 10;
    time_digits[4] = timeinfo.tm_sec / 10;
    time_digits[3] = timeinfo.tm_min % 10;
    time_digits[2] = timeinfo.tm_min / 10;
    time_digits[1] = timeinfo.tm_hour % 10;
    time_digits[0] = timeinfo.tm_hour / 10;

}

void setup() {
  Serial.begin(115200);
  while (!Serial) { ; }
  neonPixelMatrix.setDisplayPixelSize(48,8);
  neonPixelMatrix.setViewOrigin(0,8);
  neonPixelMatrix.begin();
  neonPixelMatrix.setFont(&Muth014pt7b);
  neonPixelMatrix.setCursor(0,15);
  neonPixelMatrix.setTextColor(color);
  neonPixelMatrix.print("Starting");
  neonPixelMatrix.display();

  delay(2000); 
  connectWiFi();
  delay(2000);
}

ulong last = 0;
void loop() {

  if (millis() - last < 1000) {
    delay(50);
  } else {
    last = millis();
    getTime();
    delay(100);

    for (int i=0; i<10; i++) {
      neonPixelMatrix.clear();
      for (int d = 0; d<6; d++){
        if (time_digits[d] != time_digits_old[d]) {
          neonPixelMatrix.drawChar(char_place[d], 15-i, 0x30+time_digits_old[d] , color, 0x00, 1);
          neonPixelMatrix.drawChar(char_place[d], 24-i, 0x30+time_digits[d] , color, 0x00, 1);
        } else {
          neonPixelMatrix.drawChar(char_place[d], 15, 0x30+time_digits[d] , color, 0x00, 1);
        }

      }
      neonPixelMatrix.drawPixel(15, 10, color);
      neonPixelMatrix.drawPixel(15, 13, color);
      neonPixelMatrix.drawPixel(32, 10, color);
      neonPixelMatrix.drawPixel(32, 13, color);
      neonPixelMatrix.display();
      delay(30);
    }

    if (time_digits[4]==4 && time_digits[5]==4) {
      neonPixelMatrix.setCursor(60,15);
      neonPixelMatrix.setTextColor(color);
      neonPixelMatrix.print(&timeinfo, "%A %d %B");
      for (int i=0; i<200; i++) {
        neonPixelMatrix.setViewOrigin(i, 8);
        neonPixelMatrix.display();
        delay(30);
      }
      neonPixelMatrix.setViewOrigin(0, 8);
      neonPixelMatrix.display();
    }

    delay(100);
  }

}
