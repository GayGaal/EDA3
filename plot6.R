## This part of the script contains commands, similar for all the plots ##
fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, "data.zip")
unzip("data.zip") 
## reading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds") 
## getting the needed plotting data for plot 6
## subsetting SCC list where sources are motor vehicles
sccSubset <- as.character(subset(SCC, grepl("[Vv]ehicle", SCC.Level.Two))[,1])
## subsetting NEI data to contain only motor vehicles data
mvData <- NEI[NEI$SCC %in% sccSubset,]
## subsetting mvData data to only Baltimore
compareData <- subset(mvData, fips=="24510" | fips=="06037")
compareData$city <- ifelse(compareData$fips=="24510", "Baltimore", "Los Angeles County" )
## calculating
plotData <- with(compareData, aggregate(Emissions ~ year + city, FUN=sum))
plotData$city <- as.factor(plotData$city)
## plotting the data directly to png
png(file="plot6.png", height=480, width=480)
require(ggplot2)
qplot(year, Emissions, data=plotData, geom="path", color=city, main="Motor Vehicles Emissions in two cities") 
dev.off()