library(data.table)
NA_STRS="?"
suppressWarnings(DT<-fread(".\\household_power_consumption.txt",na.strings=NA_STRS))

working<-data.table(DT$Date,DT$Time,DT$Sub_metering_1,DT$Sub_metering_2,DT$Sub_metering_3)
setkey(working,V1)
working<-working[c("1/2/2007","2/2/2007"),]
working<-working[!is.na(working$V3)]
working$V3<-as.numeric(working$V3)
working[,dateTime:={working[,as.POSIXct(strptime(paste(V1,V2),format="%d/%m/%Y %H:%M:%S"))]}]

xlab_<-""
ylab_<-"Energy sub metering"
par(ps=12)
type_="l"
par(mar=c(5.1,4.1,2.1,2.1))

plot(working[,dateTime],working[,V3],xlab=xlab_,ylab=ylab_,type=type_)
lines(working[,dateTime],working[,V4],col="red")
lines(working[,dateTime],working[,V5],col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1,col=c("black","red","blue"),y.intersp=.75)
#dev.copy(png,file="plot3.png")
png(filename="plot3.png")
plot(working[,dateTime],working[,V3],xlab=xlab_,ylab=ylab_,type=type_)
lines(working[,dateTime],working[,V4],col="red")
lines(working[,dateTime],working[,V5],col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1,col=c("black","red","blue"),y.intersp=.75)
dev.off()
