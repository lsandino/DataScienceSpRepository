#Load libraries
library(lubridate)
library(dplyr)
library(rmarkdown)
library(knitr)

#Perfom data analysis and create the Codebook
knit("run_analysis.Rmd")
knit("CodeBook.Rmd")
