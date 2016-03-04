## Getting the data
## set working directory to where you want the data to unzip to. this case "Exploratory ResearchII" 
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(dataset_url, "FNEI_data.zip")
unzip("FNEI_data.zip", exdir = "Exploratory ResearchII")

## Reading in the two portions of the file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Compare emissions from motor vehicle sources in Baltimore City with 
#emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

NEISCC <- merge(NEI, SCC, by="SCC")
subsetNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]
subsetNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]

FipsAllyears <- aggregate(Emissions ~ year + fips, subsetNEI, sum)
FipsAllyears$fips[FipsAllyears$fips=="24510"] <- "Baltimore, MD"
FipsAllyears$fips[FipsAllyears$fips=="06037"] <- "Los Angeles, CA" 

library(ggplot2)
png("plot6.png", width=1000, height=400)
C <- ggplot(FipsAllyears, aes(factor(year), Emissions))
C <- C + facet_grid(. ~ fips)
C <- C + geom_bar(stat="identity")  +
        xlab("Year") +
        ylab(expression('Total PM'[2.5]*" Emissions")) +
        ggtitle('Total Emissions from motor vehicle in Baltimore City, MD vs. Los Angeles, CA 1999-2008')
print(C)
dev.off()