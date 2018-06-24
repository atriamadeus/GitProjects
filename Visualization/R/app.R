library(shiny)
library(plotly)
library(data.table)

data=fread("quarter_all.csv")
head(data)

#Define UI

 ui <- fluidPage( title ="US Air Traffic",
       titlePanel(h1("US TRAFFIC DENSITY BETWEEN AIRPORTS ")),
       sidebarLayout(
       sidebarPanel( width=,
       helpText(h3("A pair of origin and destination airport forms a Market. Traffic means total passengers flying between the airports")),

       sliderInput("slider", 
                   width= 400,
                   h5("In terms of US Overall traffic, markets with traffic flow greater than the following percentile"),
                   min=0.50, max=1,value=0.70 ),
       
       selectInput("var",
                   width= 200,
                   label="Time Period",
                   choices=c("First Quarter","Second Quarter",
                             "Third Quarter", "Fourth Quarter"),
                   selected="First Quarter")
                   
       ),            

       mainPanel(plotlyOutput("plot1",height = "680px", width = "800px"))
       )

    )


# Define Server Logic ------

server <- function(input, output){

  
  output$plot1 <- renderPlotly({

    data_selected <- data[(PASSENGERS >=(quantile(data[,PASSENGERS],input$slider)))&(TIMEPERIOD == input$var),]
    data_selected$my_text=paste("PASSENGER : " , data_selected$PASSENGERS   , sep="")
    data_selected$origin_text=paste("ORIGIN : " , data_selected$ORIGIN   , sep="")
    data_selected$dest_text=paste("DEST : " , data_selected$DEST   , sep="")
    vals <- unique(scales::rescale(c(volcano)))
    o <- order(vals, decreasing = FALSE)
    cols <- scales::col_numeric("Blues", domain = NULL)(vals)
    colz <- setNames(data.frame(vals[o], cols[o]), NULL)

    plot_ly(x=data_selected[,ORIGIN],y=data_selected[,DEST],z=data_selected[,PASSENGERS],
                     type="heatmap",
                     hoverinfo="text",
                     text=paste('</br>ORIGIN: ',data_selected[,ORIGIN],
                                '</br> DEST: ',data_selected[,DEST],
                                '</br> PASSENGERS : ',data_selected[,PASSENGERS]),
                     showscale = T,    #plot_a <-plotly_build(plot_a)

                     colorscale = colz)
 
  })
  
  
}

   

# Run the app -----

shinyApp(ui=ui, server=server)

 