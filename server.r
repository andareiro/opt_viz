# Load packages for Shiny, options pricing, and data wrangling
library(shiny)
library(RQuantLib)
library(tidyr)
library(dplyr)
library(ggplot2)

# Set the static inputs for the options pricing models
## Dividend yield
q <- 0.0
## Risk-free rate
r <- 0.025

## Price range of the underlying security - this is an input for the pricing
## models, and the x-axis for our plot
S <- seq(1, 800, by = 1)

# We want to know how the value and the greeks change across prices (S) for each
# of the options. This function will produce the values and greeks for European
# and Asian options. Our Shiny app will let us change the inputs for these
# models. This function will quickly turn those inputs into a consolidated set
# of results, which we can then easily plot.

# Create the variables needed
optOut = list()
eur = list()
asian = list()
asianOut = list()
eurOut = list()
# Code up the function, using a single data table as an input source. We'll
# create that data table later in the reactive portion of this file. The data
# table has one row for every unique underlying price (S). This function reads
# in each line and calculates the corresponding values and greeks.
optMatrix <- function (data) {
  for(i in 1:dim(data)[1]) {
    #Calculate the values for the European options
    eur <- EuropeanOption(as.character(data[i,"type"]),
                              data[i,"underlying"],
                              data[i,"strike"],
                              data[i,"dividendYield"],
                              data[i,"riskFreeRate"],
                              data[i,"maturity"],
                              data[i,"volatility"])
    # Calculate the values for the Asian option, using the same inputs
    asian <- AsianOption(averageType = as.character(data[i,"averageType"]),
                          type = as.character(data[i,"type"]),
                           underlying = data[i,"underlying"],
                           strike = data[i,"strike"],
                           dividendYield = data[i,"dividendYield"],
                           riskFreeRate = data[i,"riskFreeRate"],
                           maturity = data[i,"maturity"],
                           volatility = data[i,"volatility"])
    #Combine and return the two sets of values
    eurOut <- rbind_list(eurOut, eur)
    asianOut <- rbind_list(asianOut, asian)
      }
  return(list(eurOut, asianOut))
}

shinyServer(
  function(input, output) {
    ## Update the inputs for the pricing models with user input
    opt_type <- reactive({opt_type <- input$opt_type})
    K <- reactive({K <- input$strike})
    sigma <- reactive({sigma <- input$vol})
    t <- reactive ({t <- input$tenor/12})
    
    output$primary_plot <- renderPlot({
      #First let's pull in all the input from the user, and create a data
      #table to feed our function
      data <- data.frame (type = rep(opt_type(), length(S)),
                          underlying = S,
                          strike = rep(K(), times = length(S)),
                          dividendYield = rep(q, times = length(S)),
                          riskFreeRate = rep(r, times = length(S)),
                          maturity = rep(t(), times = length(S)),
                          volatility = rep(sigma(), times = length(S)),
                          # geometric averaging method for the AsianOption function,
                          # can be updated to an input in a future version
                          averageType = rep("geometric", times = length(S))
      )
      
      ## Calculate the options values and greeks using our function
      optOutput <- optMatrix(data)
      
      ## Create and reshape a data frame to befit the plotting functions
      optPlotVars <- data.frame(underlying = data$underlying,
                                value_eur = optOutput[[1]]$value,
                                value_asian = optOutput[[2]]$value)
        optPlotVars <- gather(optPlotVars, "underlying")
        names(optPlotVars) <- c("underlying", "value_type", "value")
        
        ## Plot the option values
        ggplot(optPlotVars, aes(x = underlying, y = value, col = value_type)) +
          # geom_point() +
          geom_smooth() +
          ggtitle(label = "Option Value vs. Underlying Price")+
          scale_x_continuous(name = "Underlying Price (S)") +
          scale_y_continuous(name = "Option Value (C or P)") +
          scale_color_discrete(labels = c("European", "Asian"))+
          theme(legend.title=element_blank())
    })
    # Output to inform the user of the fixed input variables, specified at the 
    # beginning of this file
    output$rf_rate <- renderText({paste("Risk-Free Rate: ",r,sep="")})
    output$div_yield <- renderText({paste("Dividend Yield: ",q, sep = "")})
	}
)
