#Load libraries
library(lubridate)
library(dplyr)
library(ggplot2)
Sys.setlocale("LC_TIME", "English")

#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Search only for emissions related to Coal sector
EI.Sector <- SCC$EI.Sector[match(NEI$SCC,SCC$SCC)]
NEI <- cbind(NEI,EI.Sector)
NEI <- NEI[grep("Coal",NEI$EI.Sector),]
NEI <- group_by(NEI,type,year)
NEI <- summarize(NEI,avg=mean(Emissions))

#Plot average PM2.5 emission from Coal combustion in the US by type for each of the years
png('Plot4.png')
g <- ggplot(NEI,aes(year,avg))
g + geom_point() + facet_grid(type ~ .,scales="free_y") + geom_smooth(method=lm,se=FALSE) + xlab("Year") + ylab("PM2.5 [ton]") + ggtitle("Average PM2.5 emission from Coal combustion in the US")
dev.off()