## This part of the script contains commands, similar for all the plots ##
fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, "data.zip")
unzip("data.zip") 
## reading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds") 
## getting the needed plotting data for plot 5
## subsetting SCC list where sources are motor vehicles
sccSubset <- as.character(subset(SCC, grepl("[Vv]ehicle", SCC.Level.Two))[,1])
## subsetting NEI data to contain only motor vehicles data
mvData <- NEI[NEI$SCC %in% sccSubset,]
## subsetting mvData data to only Baltimore
BaltimoreData <- subset(mvData, fips=="24510")
## calculating
plotData <- with(BaltimoreData, aggregate(Emissions ~ year, FUN=sum))
## plotting the data directly to png
png(file="plot5.png", height=480, width=480)
par(mar=rep(5,4))
with(plotData, plot(year, Emissions, type="b", pch=19, lwd=2, col="red", ylab="Total Yearly Emissions", main="Total PM25 motor vehicles emissions in Baltimore"))
dev.off()