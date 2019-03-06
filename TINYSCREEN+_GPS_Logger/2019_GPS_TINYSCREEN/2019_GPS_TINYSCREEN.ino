//-------------------------------------------------------------------------------
//  GPS logger with tinyscreen, live view of global position and logging to SD card at user defined intervals
//  
//
//  Written by Chrissy h Roberts, Emergency and Epidemics Data Kit, London School of Hygiene and Tropical Medicine
//  This project was supported by the National Institute for Health Research (NIHR) [Policy Research Programme (PR-OD-1017-20001)]. 
//  The contributions here reflect the  author(s) and not necessarily those of the NIHR or the Department of Health and Social Care.
//
//  Based on TinyCircuits TinyCircuits-GPS-Tracker-Tutorial
//  Written by Ben Rose for TinyCircuits, https://tiny-circuits.com
//
//  Creative Commons Share-Alike 3.0 License
//-------------------------------------------------------------------------------

#include <Wire.h>
#include <SPI.h>
#include <TinyScreen.h>
#include <RTCZero.h>
#include <TinyGPS++.h>
#include <SD.h>
#include "GPS.h"
#include <Adafruit_GPS.h>
#if defined (ARDUINO_ARCH_AVR)
#define SerialMonitorInterface Serial
#include <SoftwareSerial.h>
#elif defined(ARDUINO_ARCH_SAMD)
#define SerialMonitorInterface SerialUSB
#include "SoftwareSerialZero.h"
#endif


//Library must be passed the board type
//TinyScreenDefault for TinyScreen shields
//TinyScreenAlternate for alternate address TinyScreen shields
//TinyScreenPlus for TinyScreen+
TinyScreen display = TinyScreen(TinyScreenPlus);
RTCZero rtc;


////////////////////////////////////  
// SET UP GPS DEVICE 
////////////////////////////////////  
const int chipSelect = 10;
// The GPS connection is attached with a software serial port
SoftwareSerial softSerial(GPS_RXPin, GPS_TXPin);

#define Gps_serial softSerial


////////////////////////////////////  
//Set default sleep time to 3 minutes
////////////////////////////////////  

 int sleeptime = 180000;
////////////////////////////////////  
//Make a variable for number of tries when signal is bad
////////////////////////////////////  
int tries = 0;


////////////////////////////////////  
//Make a variable for startup to keep trying until first signal found
////////////////////////////////////  
int startup = 1;

int yearnow = 18;
////////////////////////////////////  
// Make a TinyGPS++ object
////////////////////////////////////  
TinyGPSPlus gps;


/////////////////////////////////////////////////////////////////////////////////
// Define function to intialise the SD card
/////////////////////////////////////////////////////////////////////////////////

bool InitSD()
{
   // make sure that the default chip select pin is set to
  // output, even if you don't use it:
  pinMode(10, OUTPUT);
  // 10 is reserved for TinyD
  if (!SD.begin(10)) 
  {
    // don't do anything more:
    return false;
  }
  return true;
}

/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
// SETUP LOOP
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////

void setup() {

///###################################################
// Start clock - Start GPS - Start serial Monitor  
  rtc.begin(); // initialize RTC
  Gps_serial.begin(GPSBaud);
  SerialMonitorInterface.begin(115200);
///###################################################
  
  while (!SerialMonitorInterface && millis() < 5000); //On TinyScreen+, this will wait until the Serial Monitor is opened or until 5 seconds has passed
  gpsInitPins();
  Wire.begin();//initialize I2C before we can initialize TinyScreen- not needed for TinyScreen+
  // Turn on the tinyscreen
  display.begin();
  //setBrightness(brightness);//sets main current level, valid levels are 0-15
  display.setBrightness(6);

  SerialMonitorInterface.print("Initialized...");


///###################################################
// Initialize the SD card and print test line
///###################################################
 while(InitSD() == false)
  {
    delay(1000);
    SerialMonitorInterface.println("Can't start SD card");
  }
    SerialMonitorInterface.println("SD card started");

SerialMonitorInterface.println("printing to SD file - test");   
File dataFile = SD.open("datalog.txt", FILE_WRITE);
dataFile.println("Starting new log...");
dataFile.close();


///###################################################
// Show splash screen on tinyscreen
///###################################################

  display.setFlip(true);
  display.clearScreen();
  display.setFont(liberationSans_8ptFontInfo);
  display.setCursor(3,15);
  display.print("LSHTM");
  display.setCursor(3,25);
  display.print("Open Research Kits");
  display.setCursor(3,35);
  display.print("Open GPS Logger");  
  delay(5000);
  gpsOn();

}

/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
// END SETUP LOOP
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////






/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
// MAIN LOOP
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
void loop() {
  //setFlip(boolean);//done in hardware on the SSD1331

  readInput();

}
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
// END MAIN LOOP
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////




void readInput() {

///###################################################
// Show menu screen on tinyscreen
///###################################################

  display.clearScreen();
  display.setFlip(true);
  display.clearScreen();
  display.setFont(thinPixel7_10ptFontInfo);
  display.setCursor(10,30);
  display.fontColor(TS_8b_White,TS_8b_Black);
  display.print("ORK Open GPS");
  display.setFont(liberationSans_8ptFontInfo);
  display.fontColor(TS_8b_Red,TS_8b_Black);

  display.setCursor(1,10);
  display.print("< log");
  display.setCursor(45,10);
  display.print("gps live >");
  display.setCursor(1,45);
  display.print("< Set");
  display.setCursor(55,45);
  display.print("NMEA >");

 // now menu screen is up, wait for button pushes with buttonloop command
  unsigned long startTime = millis();
  while (millis() - startTime < 3000) buttonLoop();
  startTime = millis();
  while (millis() - startTime < 3000) buttonLoop();
  display.clearScreen();
  
}


//#########################
//# CHECK FOR BUTTON PUSHES
//#########################
void buttonLoop() 
  {
   
  if (display.getButtons(TSButtonUpperLeft)) 
          {
           display.clearScreen();
           display.setFont(liberationSans_8ptFontInfo);
           display.setCursor(13,15);
           display.print("Starting logger");
           display.setCursor(13,25);
           display.print("Interval");
           display.setCursor(23,35);
           display.print(sleeptime/1000);
           display.print(" s");
           delay(2000);
           logintervals_basic();
          }

  if (display.getButtons(TSButtonLowerLeft)) 
          {
           setinterval();
           }

  if (display.getButtons(TSButtonUpperRight)) 
          {
          getgps();
          }

  if (display.getButtons(TSButtonLowerRight)) 
          {
          nmeafeed();
          }
  }
  


//#########################
//# Define Function : Get GPS real time
//#########################

void setinterval(){
      while(!display.getButtons(TSButtonLowerRight))
      {
      display.clearScreen();
      display.setFont(thinPixel7_10ptFontInfo);
      display.setCursor(2,15);
      display.print("< 1s"); 
      display.setCursor(50,15);
      display.print("> 1s");
      display.setCursor(15,30);
      display.print("Current interval"); 
      display.setCursor(25,40);
      display.print(sleeptime/1000);      
      display.print(" s"); 
      delay(50);
      if(display.getButtons(TSButtonUpperRight)){sleeptime = sleeptime + 1000;}
      if(display.getButtons(TSButtonUpperLeft)){sleeptime = sleeptime - 1000;}

      }
}


//#########################
//# Define Function : Get GPS real time
//#########################

void getgps (){
  SerialMonitorInterface.print("Starting live tracker (on screen)");

  while(!display.getButtons(TSButtonLowerRight))
{
 while (Gps_serial.read() != '$') {
 if(!Gps_serial.available()){return;}   
  }
   while (gps.satellites.isValid() == 0) {   
      if(display.getButtons(TSButtonUpperRight)){break;}
      display.clearScreen();
      display.setFont(thinPixel7_10ptFontInfo);
      display.setCursor(15,30);
      if(digitalRead( GPS_SYSONPin ) == LOW){display.print("WARNING : No SIGNAL");}
      delay(1000);
      }

// Show current position data on screen and serial device

      SerialMonitorInterface.print(gps.satellites.value());
      SerialMonitorInterface.print("\t");
      SerialMonitorInterface.print(gps.satellites.isValid());            
      SerialMonitorInterface.print("\t");
      SerialMonitorInterface.print(gps.altitude.meters(),4);                  
      SerialMonitorInterface.print("\t");
      SerialMonitorInterface.print(gps.location.lat(),6);                        
      SerialMonitorInterface.print("\t");
      SerialMonitorInterface.print(gps.location.lng(),6);   
      SerialMonitorInterface.print("\t");
      SerialMonitorInterface.print(gps.date.year());
      SerialMonitorInterface.print("\t");
      SerialMonitorInterface.print(gps.date.month());
      SerialMonitorInterface.print("\t");
      SerialMonitorInterface.print(gps.date.day());
      SerialMonitorInterface.print("\t");
      SerialMonitorInterface.print(gps.time.hour());   
      SerialMonitorInterface.print("\t");
      SerialMonitorInterface.print(gps.time.minute());   
      SerialMonitorInterface.print("\t");
      SerialMonitorInterface.print(gps.time.second());   
      SerialMonitorInterface.print("\t");
      SerialMonitorInterface.println(gps.hdop.value());     
      SerialMonitorInterface.print(gps.location.lat(),6);
      SerialMonitorInterface.print("\t");
      SerialMonitorInterface.println(gps.location.lng(),6);
      SerialMonitorInterface.print(":");      
      SerialMonitorInterface.print(gps.time.hour());   
      SerialMonitorInterface.print(":");
      SerialMonitorInterface.print(gps.time.minute());   
      SerialMonitorInterface.print(":");
      SerialMonitorInterface.print(gps.time.second()); 
      
      

  display.clearScreen();
  display.setFont(thinPixel7_10ptFontInfo);
  display.setCursor(15,30);
 if(digitalRead( GPS_SYSONPin ) == LOW){display.print("WARNING : GPS is OFF");}
 
////////////////////////////////////  
//Start data feed on the GPS baud
////////////////////////////////////  
 unsigned long start = millis();
  do 
  {
    while (Gps_serial.available())
      gps.encode(Gps_serial.read());
  } while (millis() - start < 1000);
  
  display.clearScreen();


  
  display.setFont(liberationSans_8ptFontInfo);
  display.setCursor(3,15);
  display.print("Lat : ");
  display.println(gps.location.lat(),6);
  display.setCursor(3,25);
  display.print("Lon : ");
  display.println(gps.location.lng(),6);      
  display.setCursor(3,35);
  display.print("Alt : ");
  display.print(gps.altitude.meters());      
  display.print(" S|");
  display.print(gps.satellites.value());      
  display.setCursor(3,45);
  display.println(gps.date.value());
  display.print("  ");
  if (gps.time.hour() < 10) {    display.print("0");}
  display.println(gps.time.hour());
  display.print(":");
  if (gps.time.minute() < 10) {    display.print("0");}
  display.println(gps.time.minute());
  delay(1000);
  }  
}


//#########################
//# Define Function : waitforcharacter
//#########################
    
char waitForCharacter() {
  while (!Gps_serial.available());
  return Gps_serial.read();
}

//#########################
//# Basic log to SD card
//#########################
    
void logintervals_basic() {

 int counter=1;
 while(!display.getButtons(TSButtonLowerRight))
 {
 unsigned long start = millis();
  do 
  {
    while (Gps_serial.available())
      gps.encode(Gps_serial.read());
  } while (millis() - start < 1000);

      SerialMonitorInterface.print("\t");
      SerialMonitorInterface.print(gps.satellites.isValid());            
      SerialMonitorInterface.print("\t");
      SerialMonitorInterface.print(gps.altitude.meters(),4);                  
      SerialMonitorInterface.print("\t");
      SerialMonitorInterface.print(gps.location.lat(),6);                        
      SerialMonitorInterface.print("\t");
      SerialMonitorInterface.print(gps.location.lng(),6);   
      SerialMonitorInterface.print("\t");
      SerialMonitorInterface.print(gps.date.year());
      SerialMonitorInterface.print("\t");
      SerialMonitorInterface.print(gps.date.month());
      SerialMonitorInterface.print("\t");
      SerialMonitorInterface.print(gps.date.day());
      SerialMonitorInterface.print("\t");
      SerialMonitorInterface.print(gps.time.hour());   
      SerialMonitorInterface.print("\t");
      SerialMonitorInterface.print(gps.time.minute());   
      SerialMonitorInterface.print("\t");
      SerialMonitorInterface.print(gps.time.second());   
      SerialMonitorInterface.print("\t");
      SerialMonitorInterface.println(gps.hdop.value());     
      SerialMonitorInterface.print(gps.location.lat(),6);
      SerialMonitorInterface.print("\t");
      SerialMonitorInterface.println(gps.location.lng(),6);
      SerialMonitorInterface.print(":");      
      SerialMonitorInterface.print(gps.time.hour());   
      SerialMonitorInterface.print(":");
      SerialMonitorInterface.print(gps.time.minute());   
      SerialMonitorInterface.print(":");
      SerialMonitorInterface.print(gps.time.second());   
         

      // if ( counter % 10 == 0 )
    {

  display.clearScreen();
  display.setFont(liberationSans_8ptFontInfo);
  display.setCursor(3,15);
  display.print("Lat : ");
  display.println(gps.location.lat(),6);
  display.setCursor(3,25);
  display.print("Lon : ");
  display.println(gps.location.lng(),6);      
  display.setCursor(3,35);
  display.print("Alt : ");
  display.print(gps.altitude.meters());      
  display.print(" S|");
  display.print(gps.satellites.value());      
  display.setCursor(3,45);
  display.println(gps.date.value());
  display.print("  ");
  if (gps.time.hour() < 10) {    display.print("0");}
  display.println(gps.time.hour());
  display.print(":");
  if (gps.time.minute() < 10) {    display.print("0");}
  display.print(gps.time.minute());
  delay(1000);
  display.clearScreen();
  display.setFont(liberationSans_8ptFontInfo);
  display.setCursor(3,15);
  display.print(" # ");
  display.print(counter);
  delay(1000);
  display.clearScreen();
  delay(100);
    }

    File dataFile = SD.open("datalog.txt", FILE_WRITE);
if (dataFile) 
    {
      dataFile.print(gps.satellites.value());
      dataFile.print("\t");
      dataFile.print(gps.satellites.isValid());            
      dataFile.print("\t");
      dataFile.print(gps.altitude.meters(),4);                  
      dataFile.print("\t");
      dataFile.print(gps.location.lat(),6);                        
      dataFile.print("\t");
      dataFile.print(gps.location.lng(),6);   
      dataFile.print("\t");
      dataFile.print(gps.date.year());
      dataFile.print("\t");
      dataFile.print(gps.date.month());
      dataFile.print("\t");
      dataFile.print(gps.date.day());
      dataFile.print("\t");
      dataFile.print(gps.time.hour());   
      dataFile.print("\t");
      dataFile.print(gps.time.minute());   
      dataFile.print("\t");
      dataFile.print(gps.time.second());   
      dataFile.print("\t");
      dataFile.print(gps.hdop.value());     
      dataFile.println("Logged_by_basic_logger");     
      dataFile.close();
    }
  display.clearScreen();

//if interval set to less than one minute, don't turn off gps inbetween
//if interval set above one minute, turn off gps inbetween

if(sleeptime>59999)
    {
    gpsOff();
    SerialMonitorInterface.println("GPS OFF");   
    }
    
if(sleeptime<60000){delay(sleeptime);}
if(sleeptime>59999){delay(sleeptime-20000);}
if(sleeptime>59999)
    {
    gpsOn();
    SerialMonitorInterface.println("GPS on");   

counter=0;
//while(gps.satellites.value()==0 && counter <180)
//{
  SerialMonitorInterface.print("waiting for fresh signal : ");   

  delay(20000);
  SerialMonitorInterface.println(counter);   

  counter++;
//}
    }
}

}



//#########################
//# Define Function : See some NMEA data to prove it is doing something
//#########################
    
//NMEA version
void nmeafeed() {
  while (Gps_serial.read() != '$') {
    if(!Gps_serial.available()){
      return;
    }
  }
  int counter = 1;
  char c = 0;
  char buffer[100];
  buffer[0] = '$';
  c = waitForCharacter();
  while (c != '*') {
    buffer[counter++] = c;
    if(c=='$'){//new start
      counter=1;
    }
    c = waitForCharacter();
  }
  buffer[counter++] = c;
  buffer[counter++] = waitForCharacter();
  buffer[counter++] = waitForCharacter();
  buffer[counter++] = '\r';
  buffer[counter++] = '\n';
  buffer[counter] = '\0';

  buffer[1] = 'G';
  buffer[2] = 'P';

  gpsDoChecksum(buffer);
  display.clearScreen();
  display.setFont(thinPixel7_10ptFontInfo);
  display.setCursor(1,1);

    SerialMonitorInterface.print((char *)buffer);
display.print((char *)buffer);
  SerialMonitorInterface.print((char *)buffer);

}
