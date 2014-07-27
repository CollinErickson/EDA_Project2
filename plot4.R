NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

require(plyr)
scc <- readRDS('./Source_Classification_Code.rds')
grep('Coal',levels(scc$EI.Sector),fixed=T)
coal.sccs <- scc$SCC[grep('Coal',levels(scc$EI.Sector),fixed=T)]
coal <- NEI[NEI$SCC %in% coal.sccs,]
coal.years <- ddply(coal,'year',function(df){sum(df$Emissions)})

png(filename='plot4.png')
par(mfrow=c(1,1))
plot(coal.years,pch=20,col='red',cex=2,main='Emissions from coal combustion-related sources 1999-2008',
     xlab='Year',ylab='Total emissions (tons)')
abline(lm(coal.years$V1~coal.years$year))
dev.off()

