NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

require(plyr)
balt <- NEI[NEI$fips==24510,]
balt.res <- ddply(balt,'year',function(df){sum(df$Emissions)})

png(filename='plot2.png')
plot(balt.res,pch=20,col='red',cex=2,main='Total emissions from PM2.5 from 1999 to 2008 in Baltimore',
     xlab='Year',ylab='Total emissions (tons)')
abline(lm(balt.res$V1~balt.res$year))
dev.off()