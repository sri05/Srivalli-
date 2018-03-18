 setwd("C:/Users/Admin/Desktop/Temp R")
 uberdata <- read.csv("uberdata.csv")
 View(uberdata)

Getting uniform format of the dates
install.packages("lubridate")
library(lubridate)
 uberdata$Request.timestamp <- lubridate::parse_date_time(uberdata$Request.timestamp,orders = c("d/m/Y H:M","d-m-Y H-M-S"))
 uberdata$Drop.timestamp <- lubridate::parse_date_time(uberdata$Drop.timestamp,orders = c("d/m/Y H:M","d-m-Y H-M-S"))

To extract Dates, Time, Day

uberdata$requested_Date <- as.Date(uberdata$Request.timestamp)
uberdata$Drop_Date <- as.Date(uberdata$Drop.timestamp)
uberdata$requested_hour <- format(uberdata$Request.timestamp,"%H:%M")
uberdata$requested_day <- format(uberdata$Request.timestamp,"%a")

str(uberdata)

uberdata$requested_Date <- as.integer(format(uberdata$requested_Date,'%H'))

Calculating the Trip Time 

uberdata$triptime <- round(difftime(uberdata$Drop.timestamp,uberdata$Request.timestamp, units = 'hours'),2)

Creating Time Slot variables
Early Morning = 3:00 - 6:59
Morning = 7:00 - 11:59
Day  = 12:00 - 16:59
Evening = 17:00 - 21:59
Night = 22:00 - 23:59
Mid Night = 00:00 - 2:59

timeslot <- c('Early Morning', 'Morning','Day','Evening','Night','Mid Night')

uberdata$req_timeslot <- sapply(uberdata$Request.timestamp, function(t)
{
  mins = as.integer(format(t,'%H'))*60 + as.integer(format(t,'%M'))
  time_slot_index = 24/length(timeslot)
  index = ceiling((mins/60)/time_slot_index)
 if (index == 0)
 {
   index = 1
 }
 return(timeslot[index])
  })

uberdata$req_timeslot <- factor(uberdata$req_timeslot, levels = timeslot)

view(uberdata.csv)
write.csv(uberdata, file = "C:/Users/Admin/Desktop/Temp R/uberdata1.csv", row.names = FALSE)
view(uberdata.csv)


