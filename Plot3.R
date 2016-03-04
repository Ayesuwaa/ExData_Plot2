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
png(filename='~/R/Exploraroty ResearchII/plot3.png')


#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City?
#Which have seen increases in emissions from 1999-2008? 
#Use the ggplot2 plotting system to make a plot answer this question
library(ggplot2)

# subsetting NEI for Maryland
MD <- NEI[NEI$fips == "24510", ]
MD_all_years_Type <- aggregate(Emissions ~ year + type, MD, sum)

#Plotting 
png(filename='~/R/Exploraroty ResearchII/plot3.png')
T <- ggplot(MD_all_years_Type, aes(year, Emissions, color=type))
T <- T +geom_line() + xlab("Year") + ylab(expression('Total PM'[2.5]*" Emissions")) +
        ggtitle('Total Emission in Baltimore City, MD by Type')
print(T)
