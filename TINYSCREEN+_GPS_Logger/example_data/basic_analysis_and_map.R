library(sp)
library(maptools)
require(htmlwidgets)
library(geosphere)
points_to_line <- function(data, long, lat, id_field = NULL, sort_field = NULL) {

  # Convert to SpatialPointsDataFrame
  coordinates(data) <- c(long, lat)

  # If there is a sort field...
  if (!is.null(sort_field)) {
    if (!is.null(id_field)) {
      data <- data[order(data[[id_field]], data[[sort_field]]), ]
    } else {
      data <- data[order(data[[sort_field]]), ]
    }
  }

  # If there is only one path...
  if (is.null(id_field)) {

    lines <- SpatialLines(list(Lines(list(Line(data)), "id")))

    return(lines)

    # Now, if we have multiple lines...
  } else if (!is.null(id_field)) {

    # Split into a list by ID field
    paths <- sp::split(data, data[[id_field]])

    sp_lines <- SpatialLines(list(Lines(list(Line(paths[[1]])), "line1")))

    # I like for loops, what can I say...
    for (p in 2:length(paths)) {
      id <- paste0("line", as.character(p))
      l <- SpatialLines(list(Lines(list(Line(paths[[p]])), id)))
      sp_lines <- spRbind(sp_lines, l)
    }

    return(sp_lines)
  }
}

aa<-read.table(file = "datalog.txt",sep="\t")
names(aa)<-c("satellites","valid","altitude","latitude","longitude","year","month","day","hour","minute","second","precision")
aa<-aa[-(which(aa$latitude==0)),]

require(leaflet)

y <- points_to_line(aa, "longitude", "latitude")

a<-leaflet() %>%
  setView(lng=mean(aa$longitude), lat=mean(aa$latitude), zoom = 7) %>%
  addTiles() %>%
  addCircleMarkers(group="points",clusterOptions = markerClusterOptions(showCoverageOnHover = TRUE,disableClusteringAtZoom=15,spiderfyOnMaxZoom=FALSE,maxClusterRadius=40),lng=aa$longitude, lat=aa$latitude, label=paste(aa$hour,aa$minute,aa$second,sep=":"),labelOptions = labelOptions(noHide=F,riseOnHover = TRUE),radius=1,color = "#D55E00",opacity = 1)%>%
  addPolylines(data = y)
#  addLayersControl(overlayGroups = c("All Vaccinees","Vaccinees < 22 days","Health Centres"),   options = layersControlOptions(collapsed = FALSE))
#addLegend(colors =c("#D55E00"),labels = c("points"),map = a, opacity = 1,position = "bottomright")
saveWidget(a, file="watford.html",selfcontained = T,title ="watford")


a


aa$dist<-NA
for(i in 1:dim(aa)[1])
{
aa$dist[i+1]<-distm(c(aa$longitude[i], aa$latitude[i]), c(aa$longitude[i+1], aa$latitude[i+1]), fun = distHaversine)
}

paste("total distance : ",round(sum(aa$dist,na.rm = TRUE),digits = 2)," m",sep="")



