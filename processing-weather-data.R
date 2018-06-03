library('tidyverse')
library('rvest')

# Dates from 2007-17

dates <- c("2007/6/7", "2008/6/7", "2009/6/7", 
           "2010/6/7", "2011/6/7", 
           "2012/6/7", "2013/6/7", 
           "2014/6/7", "2015/6/7", 
           "2016/6/7", "2017/6/7")

# Get historical data from wunderground.com

urls <- sprintf("https://www.wunderground.com/history/airport/KBOS/%s/DailyHistory.html?req_city=&req_state=&req_statename=&reqdb.zip=&reqdb.magic=&reqdb.wmo=", dates)

weather_data <- function(url) { 
  
  page <- url %>%
    read_html() 
  
  tbls_ls <- page %>%
    html_nodes("table") %>%
    .[5] %>%
    html_table(fill = TRUE)
  
  hourly <- tbls_ls[[1]]
  
  colnames(hourly) <- tolower(colnames(hourly))
  
  hourly <- hourly %>% 
    rename(time = `time (edt)`, temp = temp., dewpoint = `dew point`, windspeed = `wind speed`) %>% 
    mutate(temp = as.numeric(gsub("°F", "", temp)), 
           dewpoint = as.numeric(gsub("°F", "", dewpoint)), 
           windspeed = as.numeric(gsub("mph", "", windspeed)),
           precip = as.numeric(gsub("in", "", precip)),
           date = substring(url, 51, 59)) %>%
    separate(date, c("year", "month", "day"), sep = "/") %>%
    select(time, temp, dewpoint, windspeed, precip, events, conditions, year, month, day)
}

years <- lapply(urls, weather_data)
years.df <- data.frame(Reduce(rbind, years))

write_csv(years.df, 'boston_weather.csv')

