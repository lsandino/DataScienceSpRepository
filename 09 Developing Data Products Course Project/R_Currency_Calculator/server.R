#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
require(rjson)
require(lubridate)
require(ggplot2)
require(knitr)

shinyServer(function(input, output){
        currencies <- data.frame(
                c("USD","JPY","BGN","CZK","DKK","EUR","GBP","HUF","PLN",
                "RON","SEK","CHF","NOK","HRK","RUB","TRY","AUD","BRL",
                "CAD","CNY","HKD","IDR","ILS","INR","KRW","MXN","MYR",
                "NZD","PHP","SGD","THB","ZAR","ISK"),
                c("US dollar","Japanese yen","Bulgarian lev","Czech koruna","Danish krone","Euro","Pound sterling","Hungarian forint","Polish zloty",
                "Romanian leu","Swedish krona","Swiss franc","Norwegian krone","Croatian kuna","Russian rouble","Turkish lira","Australian dollar","Brazilian real",
                "Canadian dollar","Chinese yuan renminbi","Hong Kong dollar","Indonesian rupiah","Israeli shekel","Indian rupee","South Korean won","Mexican peso","Malaysian ringgit",
                "New Zealand dollar","Philippine peso","Singapore dollar","Thai baht","South African rand","Icelandic krona"))
        names(currencies) <- c("Acronym","Currency")
        output$today <- renderText({ 
                url <- paste("http://api.fixer.io/latest?base=",input$base,sep="")
                data <- fromJSON(file=url,method="C")
                i <- match(input$desired,names(data$rates))
                paste("1 ",input$base," = ",as.character(as.numeric(data$rates[i]))," ",input$desired," (",as.character(now()),")",sep="") 
        })
        output$calc <- renderText({ 
                url <- paste("http://api.fixer.io/latest?base=",input$base,sep="")
                data <- fromJSON(file=url,method="C")
                i <- match(input$desired,names(data$rates))
                paste(as.character(input$value)," ",input$base," = ",as.character(as.numeric(data$rates[i])*input$value)," ",input$desired,sep="") 
        })
        output$yearPlot <- renderPlot({
                t2 <- now()
                t1 <- t2 %m-% months(1)
                t2 <- paste(year(t2),month(t2),day(t2),sep="-")
                t1 <- paste(year(t1),month(t1),day(t1),sep="-")
                times <- seq.Date(as.Date(t1),as.Date(t2),"day")
                rate <- numeric(length = length(times))
                for (k in seq(1,length(times))) {
                        url <- paste("http://api.fixer.io/",as.character(times[k]),"?base=",input$base,sep="")
                        data <- fromJSON(file=url,method="C")
                        i <- match(input$desired,names(data$rates))
                        rate[k] <- as.numeric(data$rates[i])
                }
                ggplot(data.frame(Date = times,Exchange.Rate = rate), aes(Date, Exchange.Rate)) +
                        geom_point() +
                        geom_line(color="blue",size=1) +
                        xlab("Date") + ylab("Exchange Rate")
        })
        output$help <- renderDataTable(currencies)
        
})