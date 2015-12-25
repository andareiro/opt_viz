library(shiny)
shinyUI(pageWithSidebar(
	headerPanel("Value Explorer: European, Asian Options"),
	sidebarPanel(
	  h3('Parameters'),
    radioButtons('opt_type',
                 'Option Type',
                 c("Put" = "put",
                   "Call" = "call"),
                 selected = "call"),
    sliderInput('strike',
                'Strike Price',
                min = 1,
                max = 800,
                value = 400,
                step = 1),
    sliderInput('vol',
                'Volatility',
                min = 0.01,
                max = .5,
                value = 0.25,
                step = 0.01),
    sliderInput('tenor',
                'Tenor (months)',
                min = 1,
                max = 48,
                value = 12,
                step = 1),
    h3('Static Parameters'),
	  textOutput("div_yield"),
	  textOutput("rf_rate")
    ),
	mainPanel(
	  plotOutput("primary_plot"),
	  p('Asian options pay out a daily average of the intrinsice value of the option. This
      effectively smooths the payout of
	    a European option - it will never be as high as the full payout from a European,
      which is set entirely at expiration.'),
	  p('Some differences we can observe:'),
	  tags$ul(tags$li('Increasing the tenor increases the probability of a large payout on the final day,
	        which increases the value of the European more than the Asian'),
	     tags$li('Increasing the volatility again disproportionately increases the value
	        of the European'),
	     tags$li('The value of the options nears parity as the tenor is made shorter')
	  ),
	  p('Sources for more information:'),
	  tags$ul(tags$li('Asian options: ',tags$a(href = "https://en.wikipedia.org/wiki/Asian_option", "Wikipedia"),
	          ', ', tags$a(href="http://www.investopedia.com/terms/a/asianoption.asp",
	                       "Investopedia")),
	  tags$li('European options and the Black-Scholes-Merton pricing model: ', tags$a(href="https://en.wikipedia.org/wiki/Black%E2%80%93Scholes_model",
	                                       "Wikipedia"))
	  )
	  ))
	  )
