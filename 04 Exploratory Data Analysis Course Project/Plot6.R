#Load libraries
library(lubridate)
library(dplyr)
library(ggplot2)
Sys.setlocale("LC_TIME", "English")

#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Search only for emissions related to Motor vehicles in Baltimore City and L.A County
EI.Sector <- SCC$EI.Sector[match(NEI$SCC,SCC$SCC)]
NEI <- cbind(NEI,EI.Sector)
NEI <- NEI[grep("Vehicles",NEI$EI.Sector),]
NEI <- filter(NEI,fips=="24510"|fips=="06037")
NEI <- group_by(NEI,fips,year)
NEI <- summarize(NEI,avg=mean(Emissions))
NEI$fips <- factor(NEI$fips,c("24510","06037"),c("Baltimore City","L.A. County"))
colnames(NEI)[1] <- "City"

#Plot average PM2.5 emission from Motor vehicles in Baltimore City and L.A. County for each of the years
png('Plot6.png')
g <- ggplot(NEI,aes(year,log10(avg),fill=City))
g + geom_bar(stat = "identity",width=1,position="dodge") + xlab("Year") + ylab(expression('PM2.5 [log'[10]*'(ton)]')) + ggtitle("Average PM2.5 emission from Motor vehicles") + annotate("text",x=2002,y=2,label="NOTE: Logaritmic scale \n negative values for PM2.5 less than 1 ton")
dev.off()