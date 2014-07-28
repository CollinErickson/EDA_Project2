NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

require(plyr)

balt <- NEI[NEI$type=='ON-ROAD' & NEI$fips=='24510',]
balt.years <- ddply(balt,'year',function(df){sum(df$Emissions)})
balt.p <- balt.years
balt.p$Location <- rep('Baltimore',4)
LA <- NEI[NEI$type=='ON-ROAD' & NEI$fips=='06037',]
LA.years <- ddply(LA,'year',function(df){sum(df$Emissions)})
LA.p <- LA.years
LA.p$Location <- rep('LA County',4)

toplot <- rbind(balt.p,LA.p)

png(filename='plot6.png')
ggplot(toplot,aes(year,V1,color=Location))+geom_point(size=8)+geom_smooth(method=lm,se=T,lwd=2)+labs(title='Emissions from motor vehicle sources for\nLA County and Baltimore 1999-2008')+xlab('Year')+ylab('Total emissions (tons)')
dev.off()


