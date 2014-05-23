## This part of the script contains commands, similar for all the plots ##
fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, "data.zip")
unzip("data.zip") ##marked as comments not to repeat it again - works
## reading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds") ## once again
## getting the needed plotting data for plot 1
plotData <- with(NEI, aggregate(Emissions ~ year, FUN=sum))
plotData[,2] <- plotData[,2]/1000000
## plotting the data directly to png
png(file="plot1.png", height=480, width=480)
par(mar=rep(5,4))
with(plotData, plot(year, Emissions, type="b", pch=19, lwd=2, col="red", ylab="Total Yearly Emissions in million tons"))
dev.off()