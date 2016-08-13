#Load libraries
library(lubridate)
library(dplyr)
library(ggplot2)
Sys.setlocale("LC_TIME", "English")

#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Plot average PM2.5 emission in Blatimore City by type for each of the years
NEI <- filter(NEI,fips=="24510")
NEI <- group_by(NEI,type,year)
NEI <- summarize(NEI,avg=mean(Emissions))
png('Plot3.png')
g <- qplot(x=year,y=log10(avg),color=type,data=NEI,
           main="Average PM2.5 emission in Baltimore City",
           xlab="Year",ylab=expression('PM2.5 [log'[10]*'(ton)]'))
g + geom_smooth(method=lm,se=FALSE)
dev.off()