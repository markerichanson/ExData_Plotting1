library(data.table)
NA_STRS="?"
suppressWarnings(DT<-fread(".\\household_power_consumption.txt",na.strings=NA_STRS))

working<-data.table(DT$Date,DT$Time,DT$Global_active_power)
setkey(working,V1)
working<-working[c("1/2/2007","2/2/2007"),]
working<-working[!is.na(working$V3)]
working$V3<-as.numeric(working$V3)

xlab_<-""
ylab_<-"Global Active Power (kilowatts)"
par(ps=12)
par(xaxt="n")
type_="l"


plot(1:nrow(working),working[,V3],xlab=xlab_,ylab=ylab_,type=type_)
par(xaxt="s")
axis(1, at=c(1,nrow(working)/2,nrow(working)),labels=c("Thu","Fri","Sat"))
dev.copy(png,file="plot2.png")
dev.off()
