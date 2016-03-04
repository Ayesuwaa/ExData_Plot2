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
png(filename='~/R/Exploraroty ResearchII/Plot2.png')


#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510")
#from 1999 to 2008? Use the base plotting system to make a plot answering this question.


# subsetting NEI for Maryland
MD <- NEI[NEI$fips == "24510", ]
MD_all_years <- aggregate(Emissions ~ year,MD, sum)

#Plotting 
png(filename='~/R/Exploraroty ResearchII/plot2.png')
barplot(height=MD_all_years$Emissions, names.arg=MD_all_years$year, 
        xlab="Year", ylab=expression('Total PM'[2.5]*' Emission'),
        main=expression('Total PM'[2.5]*' in Baltimore City, Maryland'))

dev.off()


