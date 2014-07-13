NA_STRS="?"
DT<-fread(".\\household_power_consumption.txt",na.strings=NA_STRS)
main_<-"Global Active Power"
xlab_<-"Global Active Power (kilowatts)"
ylab_<-"Frequency"
col_<-"red"
par(ps=12)
working<-data.table(DT$Date,DT$Global_active_power)
setkey(working,V1)
working<-working[c("1/2/2007","2/2/2007"),]
active_global_power<-working$V2[!is.na(working$V2)]
active_global_power<-as.numeric(active_global_power)

png(filename="plot1.png")

hist(active_global_power,main=main_,xlab=xlab_,ylab=ylab_,col=col_)
#dev.copy(png,file="plot1.png")
dev.off()
