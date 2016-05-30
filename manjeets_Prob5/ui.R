#ui reference : https://gist.github.com/wch/4026749
library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Stock Trend Chart"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      #input sotck symbol
      selectInput("ID",
                label = h4("Company Name"),
                choices = list("Apple" = "AAPL", "Alibaba"="BABA", "Google"="GOOG", "IBM"="IBM", "Intel"="INTC", "Microsoft"="MSFT", "Tesla"="TSLA")),
      # set data range
      dateRangeInput("dates",label = h4("Date range"),start="2016-01-01",end="2016-03-05"),
      width=3

    ),

    # Show a plot of the generated distribution and support document
    mainPanel(
      tabsetPanel(
        # show a plot
        tabPanel(
          "Graph",plotOutput("Plot",width = "100%", height = "500px")
        )
      ),
      # set sidebar layout size
      width = 9
    )
  )
))