## Read in the data for February 1 & 2, 2007

## Create column names, based on analysis of the file
cnames=c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

## Determine first and last rows containing data for the time period in question
start<-grep("1/2/2007",readLines("household_power_consumption.txt"))[1]
end<-grep("3/2/2007",readLines("household_power_consumption.txt"))[1]

## Determine the Classes of data, and use it to load in the data
initial<-read.table("household_power_consumption.txt", header=TRUE,sep = ";", nrows = 10)
classes<-sapply(initial,class)
## Load in the portion of the table needed for this assignment
table<-read.table("household_power_consumption.txt", header=FALSE,skip=start, nrows=end-start-1, colClasses = classes, sep = ";")

##Assign the column names since they were removed as part of the subsetting
names(table)<-cnames

## Convert Date & Time variables to Date/Time

table$date_time <-as.POSIXlt(paste(table$Date, table$Time), format="%d/%m/%Y H%:$M:%S")

table$date_time <-paste(table$Date, table$Time)
table$date_time <-strptime(table$date_time, "%d/%m/%Y %H:%M:%S")

## create a function to create plot3
plot3<-function (){
	##Plot a graph of global active power vs time
	with(table,plot(date_time,Sub_metering_1, xlab="",ylab = "Energy sub metering", type="n"))
	with(table,lines(date_time,Sub_metering_1))
	with(table,lines(date_time,Sub_metering_2,col="red"))
	with(table,lines(date_time,Sub_metering_3, col="blue"))
	legend("topright", lty = 1, bty="n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),cex=0.5)
}

##Plot a graph of global active power vs time
par(mfrow=c(2,2))
with(table,{
	plot(date_time,Global_active_power, type = "l", xlab="",ylab = "Global Active Power")
	plot(date_time,Voltage, type = "l", xlab="datetime",ylab = "Voltage")
	plot3()			
	plot(date_time,Global_reactive_power, type = "l", xlab="datetime",)
})


##Save the plot as Plot4.png
dev.copy(png, file="Plot4.png")
dev.off() ## Close the png device

