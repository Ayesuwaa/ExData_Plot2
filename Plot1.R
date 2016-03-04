## Getting the data
## set working directory to where you want the data to unzip to. this case "Exploratory ResearchII" 
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(dataset_url, "FNEI_data.zip")
unzip("FNEI_data.zip", exdir = "Exploratory ResearchII")

## Reading in the two portions of the file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## checking few rows of each file
head(NEI)
head(SCC)

# combining all the 4 years needed for analysis
Allyears <- aggregate(Emissions ~ year, NEI, sum)

# Generate the graph in the same directory as the source code
png(filename='~/R/Exploraroty ResearchII/Plot1.png')

## Has emission values decreased over the years?
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for
#each of the years 1999, 2002, 2005, and 2008.
barplot(height=Allyears$Emissions, names.arg=Allyears$year, xlab="Year", 
        ylab=expression('Total PM'[2.5]*' Emissions'),
        main=expression('Total PM'[2.5]*' Emissions Across 10 Years'))

dev.off()
