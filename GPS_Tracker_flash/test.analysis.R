library(measurements)
library(leaflet)
########################################################################################
#define substring right function
substrRight<-function(x, n){substr(x, nchar(x)-n+1, nchar(x))}
########################################################################################
# define nmea gps conversion function
convert.nmea.gps<-function(loc,nsew)
{
  pointplace<-unlist(gregexpr(pattern ='\\.',loc))
  n.characters<-nchar(loc)

  degrees<-substr(loc,start = 1,stop = pointplace-3)
  if(degrees==""){degrees<-0}
  mins<-substr(loc,pointplace-2,n.characters)
  mins<-as.numeric(mins)/60
  loc<-as.numeric(degrees)+mins

  if(nsew=="W" | nsew == "S"){loc<--loc}
  return(loc)
}
########################################################################################

gps<-read.csv("test.data2.csv",header=F,na.strings = "")

#cp<-gps[grep(gps$V1,pattern = "CP"),]

#gps<-gps[-grep(gps$V1,pattern = "CP"),]
gps<-as.data.frame(gps)
names(gps)<-c("time","lat","n_s","lon","w_e","fix_quality","num_satellites","horz_dilution_position","altitude_m","height_geoid","time_since_last_DGPS_update","dgps_station_id_number","empty","checksum")

gps$APCP<-substr(gps$time,start = 2,stop = 3)
gps$time<-substr(gps$time,start = 4,14)
gps$time<-as.integer(gps$time)
gps<-gps[!is.na(gps$time),]

gps$time[which(nchar(gps$time)==5)]<-paste("0",gps$time[which(nchar(gps$time)==5)],sep="")

gps$time<-strptime(gps$time,format="%H%M%S")
gps<-gps[-which(is.na(gps$lat)),]

# convert from degrees and decimal minutes to degrees

for(i in 1:nrow(gps))
{
  gps$lat[i]<-convert.nmea.gps(loc = gps$lat[i],nsew = gps$n_s)
  gps$lon[i]<-convert.nmea.gps(loc = gps$lon[i],nsew = gps$w_e)
  }

gps$lat<-as.numeric(gps$lat)
gps$lon<-as.numeric(gps$lon)


m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addCircleMarkers(lng=gps$lon, lat=gps$lat,radius = 1)
m  # Print the map



