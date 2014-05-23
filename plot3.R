## This part of the script contains commands, similar for all the plots ##
fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, "data.zip")
unzip("data.zip") 
## reading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds") 
## getting the needed plotting data for plot 3
##subsetting
BaltimoreData <- subset(NEI, fips=="24510")
##calculating
plotData <- with(BaltimoreData, aggregate(Emissions ~ year + type, FUN=sum))
plotData$type <- as.factor(plotData$type)
## plotting the data directly to png
png(file="plot3.png", height=480, width=480)
require(ggplot2)
qplot(year, Emissions, data=plotData, geom="path", color=type, main="Total PM25 Emissions in Baltimore by type") 
dev.off()