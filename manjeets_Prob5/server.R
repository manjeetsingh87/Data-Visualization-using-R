#Server code referred from https://ghl0506.shinyapps.io/ShinyWork/

library(shiny)
library(quantmod)

# get stock data function
require_symbol <- function(symbol,start,end,envir = parent.frame()) {
  if (is.null(envir[[symbol]])) {
    envir[[symbol]] <- getSymbols(symbol,from =start,to =end,auto.assign = FALSE, src="google")
  }

  envir[[symbol]]
}

shinyServer(function(input, output) {
  # get stock data from google finance
  datainput<-reactive({
    symbol_env <- new.env()
    stock <- require_symbol(input$ID,input$dates[1],input$dates[2])
  })

  #plot stock chart
  output$Plot <- renderPlot({
    chartSeries(datainput(),theme="white",type ="line")
  })

})