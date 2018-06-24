library(shiny)

library(plotly)
library(data.table)
#setwd("D:/GitPythonProject/data")
#data=fread("db1b_q1.csv")
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

# ui <- dashboardPage(
#        skin="black",
#       dashboardHeader(),
#       dashboardSidebar(sliderInput("slider","Percentile",min=0.5, max=0.95,value=0.7)),
#       dashboardBody(
#         fluidRow(
#               box(plotlyOutput('plot1')))
#         )
#       )

# Define Server Logic ------

#data_selected <- subset(data,data[,PASSENGERS >=(quantile(data[,PASSENGERS],0.8))])
server <- function(input, output){

  
  output$plot1 <- renderPlotly({
    #data_selected <- subset(data,data$PASSENGERS >=quantile(data$PASSENGERS,input$slider))
    #data_selected <- subset(data,data[,PASSENGERS >=(quantile(data[,PASSENGERS],input$slider))])
    data_selected <- data[(PASSENGERS >=(quantile(data[,PASSENGERS],input$slider)))&(TIMEPERIOD == input$var),]
    data_selected$my_text=paste("PASSENGER : " , data_selected$PASSENGERS   , sep="")
    data_selected$origin_text=paste("ORIGIN : " , data_selected$ORIGIN   , sep="")
    data_selected$dest_text=paste("DEST : " , data_selected$DEST   , sep="")
    vals <- unique(scales::rescale(c(volcano)))
    o <- order(vals, decreasing = FALSE)
    cols <- scales::col_numeric("Blues", domain = NULL)(vals)
    colz <- setNames(data.frame(vals[o], cols[o]), NULL)
    
    #data <- switch(data[PASSENGERS >=quantile(data[,PASSENGERS],input$slider1[1])& PASSENGERS <= quantile(data[,PASSENGERS],input$slider1[2]),])
    # legend <- switch(input$select, 
    #                  "Percent White" = "% White",
    #                  "Percent Black" = "% Black",
    #                  "Percent Hispanic" = "% Hispanic",
    #                  "Percent Asian" = "% Asian")
    # color <- switch(input$select, 
    #                 "Percent White" = "darkgreen",
    #                 "Percent Black" = "black",
    #                 "Percent Hispanic" = "darkorange",
    #                 "Percent Asian" = "darkviolet")
    # 
    
    
    
    
    
    plot_ly(x=data_selected[,ORIGIN],y=data_selected[,DEST],z=data_selected[,PASSENGERS],
                     type="heatmap",
                     #text=paste(data_selected[,my_text]," ",
                     #           data_selected[,origin_text]," ",
                     #           data_selected[,dest_text]),
                     hoverinfo="text",
                     text=paste('</br>ORIGIN: ',data_selected[,ORIGIN],
                                '</br> DEST: ',data_selected[,DEST],
                                '</br> PASSENGERS : ',data_selected[,PASSENGERS]),
                     showscale = T,    #plot_a <-plotly_build(plot_a)

                     colorscale = colz)
    
    #options(warn = -1)
    #plot_a <- ggplotly(plot_a)
    #options(warn = -1)
    #plot_a
    #percent_map(data, color, legend, input$slider1[1], input$slider1[2])
  })
  
  
}

   

# Run the app -----
 
 
#if (interactive()) shinyApp(ui, server)
shinyApp(ui=ui, server=server)

 