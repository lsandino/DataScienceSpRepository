# Define Server logic for application
shinyServer(function(input, output, session) {
    
    observeEvent(input$keyPress,{
        if (input$keyPress == 13){
            values$data <- katzBOProb(tidyWords(input$text, 3), 10)
            values$line <- "I'm thinking in..."
        }
    })
    
    observeEvent(input$themes,{
        output$myUI <- renderUI({
            tags$head(tags$link(rel = "stylesheet", type = "text/css", href = input$themes))
        })
    })
    
    observe({
        values$wordn <- input$wordn
        values$showp <- input$showp
        output$tbl <- DT::renderDataTable(head(values$data, values$wordn), 
                                          class = 'display compact',
                                          options = list(dom = 't',
                                                         columnDefs = list(list(className = 'dt-right',
                                                                                targets = 1),
                                                                           list(className = 'dt-center', visible = values$showp,
                                                                                targets = 3))
                                          )
        )
        output$line <- renderUI({strong(em(values$line))})
    })                     
    
    observeEvent(input$generate,{
        withBusyIndicatorServer("generate", {
            values$seed <- input$seed
            values$rwordn <- input$rwordn
            values$random <- input$random
            temp <- data_frame(words = c("*", "*", unigrams$words[values$seed]))
            rtext <- unigrams$words[values$seed]
            for (i in seq(1:values$rwordn)){
                new <- katzBOProb(temp, 5)
                if (values$random){
                    word <- new$Suggestion[sample(1:5,1)]
                } else {
                    word <- new$Suggestion[1]
                }
                rtext <- paste(rtext, word, sep = " ")
                temp$words <- c(tail(temp$words,2), word)
            }
            output$rtext <- renderUI({h4(rtext)})
        })
    })
    
    observeEvent(input$clear,{
        updateTextInput(session, "text", value = "")
    })
})