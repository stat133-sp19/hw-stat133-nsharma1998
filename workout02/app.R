#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

future_value = function(amount, rate, years) {
  return(amount * (1 + rate) ** years)
}

annuity = function(contrib, rate, years) {
  return(contrib*((((1+rate)^years)-1)/rate))
}

growing_annuity = function(contrib, rate, growth, years) {
  return(contrib*(((((1+rate)^years)-1) - (((1+growth)^years)-1))/(rate-growth)))
}

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Simulation of Investment Scenarios"),
  fluidRow(
    column(4,
           
           # Copy the line below to make a slider bar 
           sliderInput("amount", label = h3("Initial Amount"), min = 0, 
                       max = 100000, value = 1000, step=500, pre = "$")
    ),
    column(4,
           
           # Copy the line below to make a slider range 
           sliderInput("return", label = h3("Return Rate (in %)"), min = 0, 
                       max = 20, value = 5, step=0.1)
    ),
    column(4,
           
           # Copy the line below to make a slider range 
           sliderInput("years", label = h3("Years"), min = 0, 
                       max = 50, value = 20, step=1)
    )
  ),
  
  fluidRow(
    column(4,
           
           # Copy the line below to make a slider bar 
           sliderInput("contrib", label = h3("Annual Contribution"), min = 0, 
                       max = 50000, value = 2000, step=500, pre = "$")
    ),
    column(4,
           
           # Copy the line below to make a slider range 
           sliderInput("growth", label = h3("Growth Rate (in %)"), min = 0, 
                       max = 20, value = 2, step=0.1)
    ),
    column(4,
           
           selectInput("facet", label = h3("Facet"), 
                       choices = list("Yes" = 1, "No" = 2), 
                       selected = 2)
    )
  ),
  
  hr(),
  
  fluidRow(h4("Timelines"),
           plotOutput("plot")),
  
  br(),
  
  fluidRow(h4("Balances"),
           verbatimTextOutput("df")
           
  )
  
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  
  
  output$plot <- renderPlot({
    
      library(ggplot2)
      years <- input$years
      
      no_contrib = c(rep(0, years + 1))
      fixed_contrib = c(rep(0, years + 1))
      growing_contrib = c(rep(0, years + 1))
      amount = input$amount
      contrib = input$contrib
      rate = input$return / 100
      growth = input$growth / 100
      for (year in 0:years) {
        no_contrib[year+1] = future_value(amount, rate, year)
        fixed_contrib[year+1] = annuity(contrib, rate, year) + future_value(amount, rate, year)
        growing_contrib[year+1] = growing_annuity(contrib, rate, growth, year) + future_value(amount, rate, year)
      }
      
      savings = data.frame(year = rep(c(0:years), 3), values = c(no_contrib, fixed_contrib, growing_contrib),
                           variable = c(rep('no contrib', years + 1), rep('fixed contrib', years + 1), rep('growing contrib', years + 1)))
      
      if (input$facet == 2) { 
      
        ggplot(data = savings, aes(x = year, y = values, group = variable)) +
          geom_line(aes(color = variable)) +
          geom_point(aes(color = variable)) +
          labs(x = 'year', y = 'value', title = 'Three modes of investing')
        
      } else {
        ggplot(data = savings, aes(x = year)) + 
          geom_point(aes(colour = variable, y = values)) +
          geom_line(aes(colour = variable, y = values))  +
          geom_area(aes(fill = variable, y = values), alpha = 0.5) +
          labs(x = 'year', y = 'value', title = 'Three modes of investing') +
          facet_wrap(~variable)
      }
    
  })
  
  
  output$df <- renderPrint({
    
    years <- input$years
    
    no_contrib = c(rep(0, years + 1))
    fixed_contrib = c(rep(0, years + 1))
    growing_contrib = c(rep(0, years + 1))
    amount = input$amount
    contrib = input$contrib
    rate = input$return / 100
    growth = input$growth / 100
    for (year in 0:years) {
      no_contrib[year+1] = future_value(amount, rate, year)
      fixed_contrib[year+1] = annuity(contrib, rate, year) + future_value(amount, rate, year)
      growing_contrib[year+1] = growing_annuity(contrib, rate, growth, year) + future_value(amount, rate, year)
    }
    
    savings = data.frame(year = c(0:years), no_contrib = no_contrib, fixed_contrib = fixed_contrib, growing_contrib = growing_contrib)
    savings
    
    
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)


