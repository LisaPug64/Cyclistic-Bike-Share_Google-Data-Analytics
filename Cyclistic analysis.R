data_2022_06 <- read.csv("202206-divvy-tripdata.csv")
data_2021_07 <- read.csv("202107-divvy-tripdata.csv")
data_2021_08 <- read.csv("202108-divvy-tripdata.csv")
data_2021_09 <- read.csv("202109-divvy-tripdata.csv")
data_2021_10 <- read.csv("202110-divvy-tripdata.csv")
data_2021_11 <- read.csv("202111-divvy-tripdata.csv")
data_2021_12 <- read.csv("202112-divvy-tripdata.csv")
data_2022_01 <- read.csv("202201-divvy-tripdata.csv")
data_2022_02 <- read.csv("202202-divvy-tripdata.csv")
data_2022_03 <- read.csv("202203-divvy-tripdata.csv")
data_2022_04 <- read.csv("202204-divvy-tripdata.csv")
data_2022_05 <- read.csv("202205-divvy-tripdata.csv")
#merge files into a single file
d12months <- rbind(data_2022_06, data_2021_07, data_2021_08, data_2021_09, data_2021_10, data_2021_11, data_2021_12, data_2022_01, data_2022_02, data_2022_03, data_2022_04, data_2022_05)
#drop monthly files from the environment
remove(data_2022_06, data_2021_07, data_2021_08, data_2021_09, data_2021_10, data_2021_11, data_2021_12, data_2022_01, data_2022_02, data_2022_03, data_2022_04, data_2022_05)
#make copy of cleaned data df
d12months_2 <- d12months
head(d12months_2)
#create column ride_length in minutes
d12months_2$ride_length <- difftime(d12months_2$ended_at, d12months_2$started_at, units = "mins")
head(d12months_2)
d12months_2$date <- as.Date(d12months_2$started_at) 
d12months_2$weekday <- format(as.Date(d12months_2$started_at), "%A")
d12months_2$month <- format(as.Date(d12months_2$started_at), "%m")
d12months_2$day <- format(as.Date(d12months_2$date), "%d")
d12months_2$year <- format(as.Date(d12months_2$date), "%Y")
head(d12months_2)
# remove duplicates
d12months_2 <- distinct(d12months_2)
#remove null rows 
d12months_2 <- na.omit(d12months_2)
#ride time less <= to 0
d12months_2 <- d12months_2[!(d12months_2$ride_length <=5),]
#remove columns not used
d12months_2 <- d12months_2 %>%  
  select(-c(ride_id, start_station_id, end_station_id, start_lat, start_lng, end_lat, end_lng))
head(d12months_2)
#change column name member_casual / member_type
d12months_2 <- d12months_2 %>% rename(member_type = member_casual)
head(d12months_2)

#confirm ride length is numeric
d12months_2$ride_length <- as.numeric(as.character(d12months_2$ride_length))
is.numeric(d12months_2$ride_length)

#view final df
View(d12months_2)

write_csv(d12months_2,"C:\\Users\\lisal\\Downloads\\rdata.csv")



          
          

