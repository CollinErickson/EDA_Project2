NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

require(plyr)
balt <- NEI[NEI$fips==24510,]

res <- ddply(NEI,c('year','type'),function(df){sum(df$Emissions)})

balt.res <- ddply(balt,c('year','type'),function(df){sum(df$Emissions)})


png(filename='plot3.png',height=960)

par(mfrow=c(2,1))
par(cex.main=2,cex.lab=1.5)

plot(balt.res$year,balt.res$V1,col=as.factor(balt.res$type),pch=20,cex=4,
     main='Total emissions by type for Baltimore',xlab='Year',ylab='Total Emissions (tons)')
abline(lm(V1~year,data=balt.res,subset=type=='POINT'),col='red')
lapply(1:4,
       function(x){
         abline(lm(V1~year,data=balt.res,
                subset=type==levels(as.factor(balt.res$type))[x]),col=x,lwd=3
         )
      }
)
legend(x=2005.2,y=max(balt.res$V1),legend=levels(as.factor(balt.res$type)),col=1:4,lty=c(1,1),lwd=c(2.5,2.5),cex=1)


#plot(res$year,res$V1,col=as.factor(res$type),pch=20,cex=4,
#     main='Total emissions by type',xlab='Year',ylab='Total Emissions (tons)')
#abline(lm(V1~year,data=res,subset=type=='POINT'),col='red')
#lapply(1:4,
#       function(x){
#         abline(lm(V1~year,data=res,
#                   subset=type==levels(as.factor(res$type))[x]),col=x,lwd=3
#         )
#       }
#)
#legend(x=2005.2,y=max(res$V1),legend=levels(as.factor(res$type)),col=1:4,lty=c(1,1),lwd=c(2.5,2.5),cex=1)


dev.off()