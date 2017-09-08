# Define UI for application
shinyUI(fluidPage(
    
    useShinyjs(),
    
    tags$style(appCSS),
    
    # Application title
    titlePanel(title = h1(appTitle, align = 'center')),
    
    # Sidebar
    sidebarLayout(
        sidebarPanel(
            tabsetPanel(
                tabPanel("Instructions",
                         div(br(), 
                             p("This application tries to predict which word comes next based on the last three words of an English sentence written by the user in the text input box to the right."),
                             p("To confirm the input press the ", strong("Enter"), " key. To clear the box click on the" , strong("Clear"), " button. Click on the", strong("Options"), " tab above to change some presentation settings."),
                             p("The next word probabilities are estimated with the Katz Back-Off algorithm using a 4-gram model built with 10% of randomly selected text lines extracted from the given text corpus at the Coursera Data Science Specialization Capstone Project."),
                             p("The algorithm implements smoothing using Good-Turing discounting when there are more than five data points to fit a power law for word counts, or Absolute discounting otherwise."),
                             p("For more information please visit this ", a(href = "https://lsandino.github.io/Word-O-Matic-SuggestR", "link")),
                             hr(),
                             p(em("Just for fun:"), " the application includes a random text generator based on the model. Select a seed number corresponding to a word in the unigram table and click on the", strong("Generate!"), " button. The slider controls the number of words generated. By default, the next word is always randomly selected from the 10 words with highest probability. Uncheck the option to always use the most likely word.") 
                         )
                ), #tabPanel 1
                tabPanel("Options",
                         br(),
                         sliderInput("wordn",
                                     "Set number of words suggested:",
                                     1, 10, 5),
                         checkboxInput("showp",
                                       "Show word probability estimates",
                                       TRUE),
                         hr(),
                         selectInput("themes", 
                                     "Select application theme*:",
                                     #c("Default" = "bootstrap.css", "Cerulean" = "cerulean.css", "Cosmo" = "cosmo.css", "Cyborg" = "cyborg.css", "Darkly" = "darkly.css", "Flatly" = "flatly.css", "Journal" = "journal.css", "Lumen" = "lumen.css", "Paper" = "paper.css", "Readable" = "readable.css",  "Sandstone" =  "sandstone.css", "Simplex" = "simplex.css",  "Slate" = "slate.css", "Solar" = "solar.css", "Spacelab" = "spacelab.css",  "Superhero" = "superhero.css", "United" = "united.css", "Yeti" = "yeti.css")
                                     c("Default" = "bootstrap.css", "Cerulean" = "cerulean.css", "Cosmo" = "cosmo.css", "Flatly" = "flatly.css", "Journal" = "journal.css", "Lumen" = "lumen.css", "Paper" = "paper.css", "Readable" = "readable.css",  "Sandstone" =  "sandstone.css", "Simplex" = "simplex.css",  "Solar" = "solar.css", "Spacelab" = "spacelab.css",  "United" = "united.css", "Yeti" = "yeti.css")
                         ),
                         br(),
                         "*Experimental. It might not work as expected if changed more than once."
                ), #tabPanel 2
                tabPanel("About", 
                         div(br(), 
                             strong(appTitle), 
                             br(), 
                             "\u00A9", 
                             em(paste(appDate, appAuthor, sep = " ")), 
                             br(), 
                             "Contact:", 
                             a(href = paste("mailto:", appEmail, "?Subject=", URLencode(appTitle), sep=""), "e-mail")
                         )
                ) #tabPanel 3
            ) #tabsetPanel
            , width = 5
        ), #sidebarPanel
        
        mainPanel(
            wellPanel(strong("Start writing an English sentence (press Enter to confirm):"),
                      br(),
                      br(),
                      fluidRow(
                          column(10,
                                 textInput("text",
                                           NULL,
                                           width = '100%'
                                 )
                          ), #column1
                          column(2,
                                 actionButton("clear",
                                              "Clear",
                                              width = '100%'
                                 )
                          ) #column2
                      ) #fluidRow
            ), #wellPanel
            
            wellPanel(htmlOutput("line"),
                      DT::dataTableOutput("tbl")
            ), #wellPanel
            hr(),
            h3("Random generator"),
            wellPanel(
                fluidRow(
                    column(6,
                           numericInput("seed", 
                                        paste("Select a number between 1 and" , length(unigrams$words), sep = " "),
                                        1, 1, length(unigrams$words), 1,
                                        width = '100%')
                    ), #column1
                    column(6,
                           sliderInput("rwordn",
                                       "Set the size of text to generate (number of words):",
                                       1, 25, 20,
                                       width = '100%')
                    ) #column2
                ), #fluidRow1
                fluidRow(
                    column(6,
                           withBusyIndicatorUI(
                               actionButton("generate",
                                        "Generate!",
                                        width = '100%')
                           )
                    ), #column1
                    column(6,
                           checkboxInput("random",
                                         "Use random suggestions",
                                         TRUE)
                    ) #column2
                ) #fluidRow2
            ),
            wellPanel(htmlOutput("rtext")),
            width = 7
        ) #mainPanel
    ), #sidebarLayout
    
    tags$script('
        $(document).on("keydown", function(e){
                Shiny.onInputChange("keyPress", e.which)
                });
                '),
    
    htmlOutput("myUI")
))