library(data.table)
NA_STRS="?"
suppressWarnings(DT<-fread(".\\household_power_consumption.txt",na.strings=NA_STRS))

working<-data.table(DT$Date,DT$Time,DT$Global_active_power)
setkey(working,V1)
working<-working[c("1/2/2007","2/2/2007"),]
working<-working[!is.na(working$V3)]
working$V3<-as.numeric(working$V3)
working[,dateTime:={working[,as.POSIXct(strptime(paste(V1,V2),format="%d/%m/%Y %H:%M:%S"))]}]

xlab_<-""
ylab_<-"Global Active Power (kilowatts)"
par(ps=12)
type_="l"


plot(working[,dateTime],working[,V3],xlab=xlab_,ylab=ylab_,type=type_)
dev.copy(png,file="plot2.png")
dev.off()
