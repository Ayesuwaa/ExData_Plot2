## Getting the data
## set working directory to where you want the data to unzip to. this case "Exploratory ResearchII" 
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(dataset_url, "FNEI_data.zip")
unzip("FNEI_data.zip", exdir = "Exploratory ResearchII")

## Reading in the two portions of the file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
subsetNEI <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]
Allyears <- aggregate(Emissions ~ year, subsetNEI, sum)

png(filename='~/R/Exploraroty ResearchII/Plot5.png')
library(ggplot2)
g <- ggplot(Allyears, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
        xlab("Year") +
        ylab(expression('Total PM'[2.5]*" Emissions")) +
        ggtitle('Total Emissions from Motor Vehicle in Baltimore City, MD - 1999 to 2008')
print(g)
dev.off()