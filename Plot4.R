## Getting the data
## set working directory to where you want the data to unzip to. this case "Exploratory ResearchII" 
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(dataset_url, "FNEI_data.zip")
unzip("FNEI_data.zip", exdir = "Exploratory ResearchII")

## Reading in the two portions of the file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999-2008?
library (ggplot2)

## Merging NEI and SCC in order to get names for emissions values
library(dplyr)
SCC$SCC <-as.character(SCC$SCC)
NEISCC <- left_join(NEI, SCC, by ="SCC")


# fetch all NEIxSCC records with Short.Name (SCC) Coal
coalMatches  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subsetNEISCC <- NEISCC[coalMatches, ]

# combining all the 4 years needed for analysis
Allyears <- aggregate(Emissions ~ year, subsetNEISCC, sum)

        # Generate the graph in the same directory as the source code
png(filename='~/R/Exploraroty ResearchII/Plot4.png')   

g <- ggplot(Allyears, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
        xlab("Year") +
        ylab(expression('Total PM'[2.5]*" Emissions")) +
        ggtitle('Total Emissions from Coal Sources - 1999 to 2008')
print(g)