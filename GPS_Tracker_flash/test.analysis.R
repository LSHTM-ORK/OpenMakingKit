library(measurements)
########################################################################################
#define substring right function
substrRight<-function(x, n){substr(x, nchar(x)-n+1, nchar(x))}
########################################################################################
# define nmea gps conversion function
convert.nmea.gps<-function(loc,nsew)
{
  loc<-gsub(pattern = substrRight(x = as.character(loc),n = 7),replacement = paste(" ",substrRight(x = as.character(loc),n = 7),sep=""),x = as.character(loc),ignore.case = T)
  loc.conv<-measurements::conv_unit(loc, from = 'deg_dec_min', to = 'dec_deg')
  if(nsew=="S"){loc.conv<-paste("-",loc.conv,sep="")}
  if(nsew=="W"){loc.conv<-paste("-",loc.conv,sep="")}


  return(loc.conv)
}
########################################################################################

gps<-read.csv("test.data.csv",header=F,na.strings = "")

cp<-gps[grep(gps$V1,pattern = "CP"),]

gps<-gps[-grep(gps$V1,pattern = "CP"),]
gps<-as.data.frame(gps)
names(gps)<-c("time","lat","n_s","lon","w_e","fix_quality","num_satellites","horz_dilution_position","altitude_m","height_geoid","time_since_last_DGPS_update","dgps_station_id_number","empty","checksum")

gps$APCP<-substr(gps$time,start = 2,stop = 3)
gps$time<-substr(gps$time,start = 4,14)
gps$time<-as.integer(gps$time)
gps<-gps[!is.na(gps$time),]

gps$time[which(nchar(gps$time)==5)]<-paste("0",gps$time[which(nchar(gps$time)==5)],sep="")

#gps$time<-strptime(gps$time,format="%H%M%S")

gps<-gps[-which(is.na(gps$lat)),]
# convert from degrees and decimal minutes to degrees

gpsconv<-as.data.frame("lat")
gpsconv$lon<-NA
for(i in 1:nrow(gps))
{
convert.nmea.gps(lat = gps$lat[i],ns = gps$n_s[i],lon = gps$lon[i],we = gps$w_e[i])
}


#GGA          Global Positioning System Fix Data
#123519       Fix taken at 12:35:19 UTC
#4807.038,N   Latitude 48 deg 07.038' N
#     01131.000,E  Longitude 11 deg 31.000' E
#1            Fix quality: 0 = invalid
#1 = GPS fix (SPS)
#2 = DGPS fix
#3 = PPS fix
#4 = Real Time Kinematic
#5 = Float RTK
#6 = estimated (dead reckoning) (2.3 feature)
#7 = Manual input mode
#8 = Simulation mode
#08           Number of satellites being tracked
#0.9          Horizontal dilution of position
#545.4,M      Altitude, Meters, above mean sea level
#46.9,M       Height of geoid (mean sea level) above WGS84
#ellipsoid
##(empty field) time in seconds since last DGPS update
#(empty field) DGPS station ID number
#*47          the checksum data, always begins with *
