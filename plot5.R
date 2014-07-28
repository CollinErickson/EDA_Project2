NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

require(plyr)
#scc <- readRDS('./Source_Classification_Code.rds')
#vehicle.sccs <- scc$SCC[grep('Vehicle',levels(scc$EI.Sector),fixed=T)]
#balt.vehicle <- NEI[NEI$SCC %in% vehicle.sccs & NEI$fips==24510,]
#balt.years <- ddply(balt.vehicle,'year',function(df){sum(df$Emissions)})

balt <- NEI[NEI$type=='ON-ROAD' & NEI$fips==24510,]
balt.years <- ddply(balt,'year',function(df){sum(df$Emissions)})


png(filename='plot5.png')
par(mfrow=c(1,1))
plot(balt.years,pch=20,col='red',cex=2,main='Emissions from motor vehicle sources in Baltimore 1999-2008',
     xlab='Year',ylab='Total emissions (tons)')
abline(lm(balt.years$V1~balt.years$year))
dev.off()
