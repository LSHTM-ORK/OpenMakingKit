library(shiny)
library(sp)
library(maptools)
library(htmlwidgets)
library(geosphere)
require(leaflet)

# Define UI for data upload app ----
ui <- fluidPage(

  # App title ----
  titlePanel("Settings"),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(
      sliderInput("Zoom","Zoom:",min = 1,max = 18,value = 15),
      sliderInput("Time","Time:",min = 1,max = 10000,value = 1,step = 1),

      # Input: Select a file ----
      fileInput("file1", "Choose CSV File",
                multiple = FALSE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),

      # Horizontal line ----
      tags$hr(),

      # Input: Checkbox if file has header ----
      checkboxInput("header", "Header", FALSE),

      # Input: Select separator ----
      radioButtons("sep", "Separator",
                   choices = c(Comma = ",",
                               Semicolon = ";",
                               Tab = "\t"),
                   selected = "\t"),

      # Input: Select quotes ----
      radioButtons("quote", "Quote",
                   choices = c(None = "",
                               "Double Quote" = '"',
                               "Single Quote" = "'"),
                   selected = '""'),

      # Horizontal line ----
      tags$hr(),

      # Input: Select number of rows to display ----
      radioButtons("disp", "Display",
                   choices = c(Head = "head",
                               All = "all"),
                   selected = "head")

    ),

    # Main panel for displaying outputs ----
    mainPanel(
      leafletOutput("mymap"),

      # Output: Data file ----
      tableOutput("contents")

    )

  )
)



# Define server logic to read selected file ----
server <- function(input, output,session) {

  output$contents <- renderTable({

    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, head of that data file by default,
    # or all rows if selected, will be shown.

    req(input$file1)

    # when reading semicolon separated files,
    # having a comma separator causes `read.csv` to error
    tryCatch(
      {
        aa <- read.csv(input$file1$datapath,
                       header = input$header,
                       sep = input$sep,
                       quote = input$quote)
      },
      error = function(e) {
        # return a safeError if a parsing error occurs
        stop(safeError(e))
      }
    )

  names(aa)<-c("satellites","valid","altitude","latitude","longitude","year","month","day","hour","minute","second","precision")
  if(length(which(aa$latitude==0))>0){aa<-aa[-(which(aa$latitude==0)),]}
  if(length(which(aa$longitude==0))>0){aa<-aa[-(which(aa$longitude==0)),]}
  aa$month<-sprintf("%02d", aa$month)
  aa$day<-sprintf("%02d", aa$day)
  aa$hour<-sprintf("%02d", aa$hour)
  aa$minute<-sprintf("%02d", aa$minute)
  aa$second<-sprintf("%02d", aa$second)
  aa$datetime<-paste(aa$year,"-",aa$month,"-",aa$day," ",aa$hour,":",aa$minute,":",aa$second,sep="")
  aa$datetime<-as.POSIXct(x = aa$datetime)

  updateSliderInput(session,"Time",
                    min = 1, max = nrow(aa), step = 1)

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
  y <- points_to_line(aa, "longitude", "latitude")


  output$mymap <- renderLeaflet(
    leaflet() %>%
      setView(lng=mean(aa$longitude), lat=mean(aa$latitude), zoom = input$Zoom) %>%
      addTiles() %>%
      addCircleMarkers(group="points",clusterOptions = markerClusterOptions(showCoverageOnHover = TRUE,disableClusteringAtZoom=15,spiderfyOnMaxZoom=FALSE,maxClusterRadius=40),lng=aa$longitude[input$Time], lat=aa$latitude[input$Time], label=paste(aa$datetime[input$Time],sep=":"),labelOptions = labelOptions(noHide=F,riseOnHover = TRUE),radius=1,color = "#D55E00",opacity = 1)%>%
      addPolylines(data = y) %>%
      addLegend("bottomright",colors=c("white"),labels= c(aa$datetime[input$Time]),opacity = 1)
)



    if(input$disp == "head") {
    return(aa[input$Time,])
  }
  else {
    return(aa)
  }

  })

}

# Create Shiny app ----
shinyApp(ui, server)
