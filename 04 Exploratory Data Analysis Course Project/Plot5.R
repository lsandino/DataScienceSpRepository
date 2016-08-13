#Load libraries
library(lubridate)
library(dplyr)
library(ggplot2)
Sys.setlocale("LC_TIME", "English")

#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Search only for emissions related to Motor vehicles in Baltimore City
EI.Sector <- SCC$EI.Sector[match(NEI$SCC,SCC$SCC)]
NEI <- cbind(NEI,EI.Sector)
NEI <- NEI[grep("Vehicles",NEI$EI.Sector),]
NEI <- filter(NEI,fips=="24510")
NEI <- group_by(NEI,type,year)
NEI <- summarize(NEI,avg=mean(Emissions))

#Plot average PM2.5 emission from Motor vehicles in Baltimore City for each of the years
png('Plot5.png')
g <- ggplot(NEI,aes(year,avg))
g + geom_bar(stat = "identity",width=0.8,col="blue",fill="blue") + xlab("Year") + ylab("PM2.5 [ton]") + ggtitle("Average PM2.5 emission from Motor vehicles in Baltimore City")
dev.off()