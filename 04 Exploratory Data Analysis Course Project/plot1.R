#Load libraries
library(lubridate)
library(dplyr)
library(ggplot2)
Sys.setlocale("LC_TIME", "English")

#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Plot total PM2.5 emission from all sources for each of the years
png('Plot1.png')
boxplot(log10(NEI$Emissions)~NEI$year,
        xlab="Year",ylab=expression('PM2.5 [log'[10]*'(ton)]'),
        main="Total PM2.5 emission from all sources")
dev.off()
