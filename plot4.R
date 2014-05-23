## This part of the script contains commands, similar for all the plots ##
fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, "data.zip")
unzip("data.zip") 
## reading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds") 
## getting the needed plotting data for plot 4
## subsetting SCC list where sourse is coal combustion
sccSubset <- subset(SCC, grepl("[Cc]oal", EI.Sector) & grepl("[Cc]ombustion", SCC.Level.One))[,1]
## subsetting NEI dataset based on SCC list
coalData <- subset(NEI, SCC==sccSubset)
## calculating
plotData <- with(coalData, aggregate(Emissions ~ year, FUN=sum))
## plotting the data directly to png
png(file="plot4.png", height=480, width=480)
par(mar=rep(5,4))
with(plotData, plot(year, Emissions, type="b", pch=19, lwd=2, col="red", ylab="Total Yearly Emissions", main="Total PM25 coal combusion-related emissions by year"))
dev.off()