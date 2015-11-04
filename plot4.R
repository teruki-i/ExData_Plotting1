datalink<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("epc")){
    download.file(datalink,destfile="epc.zip")
    unzip("epc.zip",exdir = "epc")
}

hpc<-read.table("epc/household_power_consumption.txt",skip=66637, nrow=2880, sep=";",col.names = colnames(
    read.table("epc/household_power_consumption.txt", nrow = 1, header = TRUE, sep=";")))
##reads data out of txt file only for rows dated 1/2/2007 and 2/2/2007

hpc$Date<-as.Date(hpc$Date,"%d/%m/%Y")
##"Date" column was originally a Factor variable, so converted to Date

x<-paste(hpc$Date,hpc$Time)
hpc$Time<-strptime(x,"%Y-%m-%d %H:%M:%S")

par(mfrow=c(2,2))
## set parameter to allow four plots at once
## plots show up in order of top left->top right

##add first plot
plot(hpc$Time,hpc$Global_active_power,type="n",
     xlab = "",ylab="Global Active Power (kilowatts")

lines(hpc$Time,hpc$Global_active_power)

##add second plot
plot(hpc$Time,hpc$Voltage,type="n",xlab="datetime",ylab="Voltage")

lines(hpc$Time,hpc$Voltage)

##add third plot
plot(hpc$Time,hpc$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")

lines(hpc$Time,hpc$Sub_metering_1)
lines(hpc$Time,hpc$Sub_metering_2,col="red")
lines(hpc$Time,hpc$Sub_metering_3,col="blue")

legend("topright",lty=1,col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       bty="n")

##add fourth plot
plot(hpc$Time,hpc$Global_reactive_power,type="n",
     xlab="datetime",ylab="Global_reactive_power")
lines(hpc$Time,hpc$Global_reactive_power)



png(file="plot4.png")
with(hpc,{
    par(mfrow=c(2,2))
    ## set parameter to allow four plots at once
    ## plots show up in order of top left->top right
    
    ##add first plot
    plot(hpc$Time,hpc$Global_active_power,type="n",
         xlab = "",ylab="Global Active Power (kilowatts")
    
    lines(hpc$Time,hpc$Global_active_power)
    
    ##add second plot
    plot(hpc$Time,hpc$Voltage,type="n",xlab="datetime",ylab="Voltage")
    
    lines(hpc$Time,hpc$Voltage)
    
    ##add third plot
    plot(hpc$Time,hpc$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
    
    lines(hpc$Time,hpc$Sub_metering_1)
    lines(hpc$Time,hpc$Sub_metering_2,col="red")
    lines(hpc$Time,hpc$Sub_metering_3,col="blue")
    
    legend("topright",lty=1,col=c("black","red","blue"),
           legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
           bty="n")
    
    ##add fourth plot
    plot(hpc$Time,hpc$Global_reactive_power,type="n",
         xlab="datetime",ylab="Global_reactive_power")
    lines(hpc$Time,hpc$Global_reactive_power)
})
dev.off()
