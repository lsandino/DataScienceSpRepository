#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(
        fluidPage(
                titlePanel("R foreign exchange rates calculator"),
                sidebarLayout(
                        sidebarPanel(
                                selectInput("base", label = h4("Select base currency"),
                                            choices = list("AUD" = "AUD",
                                                           "BGN" = "BGN",
                                                           "BRL" = "BRL",
                                                           "CAD" = "CAD",
                                                           "CHF" = "CHF",
                                                           "CNY" = "CNY",
                                                           "CZK" = "CZK",
                                                           "DKK" = "DKK",
                                                           "EUR" = "EUR",
                                                           "GBP" = "GBP",
                                                           "HKD" = "HKD",
                                                           "HRK" = "HRK",
                                                           "HUF" = "HUF",
                                                           "IDR" = "IDR",
                                                           "ILS" = "ILS",
                                                           "INR" = "INR",
                                                           "JPY" = "JPY",
                                                           "KRW" = "KRW",
                                                           "MXN" = "MXN",
                                                           "MYR" = "MYR",
                                                           "NOK" = "NOK",
                                                           "NZD" = "NZD",
                                                           "PHP" = "PHP",
                                                           "PLN" = "PLN",
                                                           "RON" = "RON",
                                                           "RUB" = "RUB",
                                                           "SEK" = "SEK",
                                                           "SGD" = "SGD",
                                                           "THB" = "THB",
                                                           "TRY" = "TRY",
                                                           "USD" = "USD",
                                                           "ZAR" = "ZAR"),
                                            selected = "EUR"),
                                selectInput("desired", label = h4("Select desired currency"),
                                            choices = list("AUD" = "AUD",
                                                           "BGN" = "BGN",
                                                           "BRL" = "BRL",
                                                           "CAD" = "CAD",
                                                           "CHF" = "CHF",
                                                           "CNY" = "CNY",
                                                           "CZK" = "CZK",
                                                           "DKK" = "DKK",
                                                           "EUR" = "EUR",
                                                           "GBP" = "GBP",
                                                           "HKD" = "HKD",
                                                           "HRK" = "HRK",
                                                           "HUF" = "HUF",
                                                           "IDR" = "IDR",
                                                           "ILS" = "ILS",
                                                           "INR" = "INR",
                                                           "JPY" = "JPY",
                                                           "KRW" = "KRW",
                                                           "MXN" = "MXN",
                                                           "MYR" = "MYR",
                                                           "NOK" = "NOK",
                                                           "NZD" = "NZD",
                                                           "PHP" = "PHP",
                                                           "PLN" = "PLN",
                                                           "RON" = "RON",
                                                           "RUB" = "RUB",
                                                           "SEK" = "SEK",
                                                           "SGD" = "SGD",
                                                           "THB" = "THB",
                                                           "TRY" = "TRY",
                                                           "USD" = "USD",
                                                           "ZAR" = "ZAR"),
                                            selected = "USD"),
                                numericInput("value", label = h4("Enter numeric value"), value = 1,min=1),
                                h3("How to use:"),
                                tags$ul(
                                        tags$li("At initialization (data loading can take a couple minutes, be patient), the application shows the current exchange rate between Euros and US Dollars, and the its evolution during the last month"), 
                                        tags$li("The user can select from two lists the base and desired currencies. The acronyms for the currencies are in the help tab"), 
                                        tags$li("There is a numeric input to calculate the equivalence of any desired value"),
                                        tags$li("Results are updated dynamically as the inputs are changed")
                                )
  
                        ),
                        mainPanel(
                                tabsetPanel(
                                        tabPanel("Calculator",
                                                 h4("Current exchange rate is:"),
                                                 verbatimTextOutput("today"),
                                                 h4("Result value is:"),
                                                 verbatimTextOutput("calc"),
                                                 h4("Last month evolution:"),
                                                 plotOutput("yearPlot")),
                                        tabPanel("Help",dataTableOutput("help")
                                                 )
                                )
            
                        )
                )
        )
)