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

plot(hpc$Time,hpc$Global_active_power,type="n",
     xlab = "",ylab="Global Active Power (kilowatts")
lines(hpc$Time,hpc$Global_active_power)



png(file="plot2.png")
with(hpc,{plot(hpc$Time,hpc$Global_active_power,type="n",
                xlab = "",ylab="Global Active Power (kilowatts")
                lines(hpc$Time,hpc$Global_active_power)})
dev.off()
