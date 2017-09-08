library(shiny)
library(shinyjs)
library(DT)
library(dplyr)
library(tidyr)
library(stringi)
library(qdapDictionaries)
library(tidytext)
library(minpack.lm)

load("data/unigrams.RData")
load("data/bigrams.RData")
load("data/trigrams.RData")
load("data/tetragrams.RData")
source("data/tidyWords.R")
source("data/katzBOProb.R")
source("data/helpers.R")

appTitle <- "Word-O-Matic suggestR"
appAuthor <- "Luis A Sandino"
appDate <- "2017"
appEmail <- "la.sandino@gmail.com"

values <- reactiveValues(line = "",
                         data = data_frame(),
                         wordn = 5,
                         showp = TRUE,
                         seed = 1,
                         rwordn = 20,
                         random = TRUE
                         )
