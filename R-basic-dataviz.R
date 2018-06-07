## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ------------------------------------------------------------------------
# install.packages('tidyverse') # if you don't already have tidyverse
library('tidyverse') # load the tidyverse package

## ------------------------------------------------------------------------
boston.weather <- read_csv('boston_weather.csv')

## ------------------------------------------------------------------------
head(boston.weather)

## ------------------------------------------------------------------------
barplot(boston.weather$temp)

## ------------------------------------------------------------------------
boston.weather.max <- boston.weather %>% # the dataframe
  group_by(year) %>% # the grouping variable
  summarise(max.temp = max(temp)) # the variable we want: maximum temperature

## ------------------------------------------------------------------------
head(boston.weather.max)

## ------------------------------------------------------------------------
barplot(boston.weather.max$max.temp)

## ------------------------------------------------------------------------
barplot(boston.weather.max$max.temp, 
        names.arg = boston.weather.max$year)

## ------------------------------------------------------------------------
barplot(boston.weather.max$max.temp, 
        names.arg = boston.weather.max$year, 
        ylim = c(0, 100))

## ----cars----------------------------------------------------------------
summary(cars)

## ------------------------------------------------------------------------
?plot()
plot(x = boston.weather.max$year, 
     y = boston.weather.max$max.temp, 
     type = 'l')

## ------------------------------------------------------------------------
plot(x = boston.weather.max$year, 
     y = boston.weather.max$max.temp, 
     type = 'l', 
     xlab = 'year',
     ylab = 'temperature (in F)',
     main = 'Maximum temperatures in Boston on June 7th\n2007-2017\n')

## ------------------------------------------------------------------------
boston.weather.min <- boston.weather %>% # the dataframe
  group_by(year) %>% # the grouping variable
  summarise(min.temp = min(temp)) # the variable we want: minimum temperature

## ------------------------------------------------------------------------
plot(x = boston.weather.max$year, 
     y = boston.weather.max$max.temp,
     type = 'l', 
     xlab = 'year',
     ylab = 'temperature (in F)',
     main = 'Max and min temperatures in Boston on June 7th\n2007-2017\n')
lines(x = boston.weather.min$year, 
      y = boston.weather.min$min.temp)

## ------------------------------------------------------------------------
plot(x = boston.weather.max$year, 
     y = boston.weather.max$max.temp,
     type = 'l', 
     xlab = 'year',
     ylab = 'temperature (in F)',
     main = 'Max and min temperatures in Boston on June 7th\n2007-2017\n',
     ylim = c(40, 100))
lines(x = boston.weather.min$year, 
      y = boston.weather.min$min.temp)

## ------------------------------------------------------------------------
plot(x = boston.weather.max$year, 
     y = boston.weather.max$max.temp,
     type = 'l', 
     xlab = 'year',
     ylab = 'temperature (in F)',
     main = 'Max and min temperatures in Boston on June 7th\n2007-2017\n',
     ylim = c(40, 100), 
     col = 'red')
lines(x = boston.weather.min$year, 
      y = boston.weather.min$min.temp,
      col = 'blue')

## ------------------------------------------------------------------------
?legend()

## ------------------------------------------------------------------------
plot(x = boston.weather.max$year, 
     y = boston.weather.max$max.temp,
     type = 'l', 
     xlab = 'year',
     ylab = 'temperature (in F)',
     main = 'Max and min temperatures in Boston on June 7th\n2007-2017\n',
     ylim = c(40, 100), 
     col = 'red')
lines(x = boston.weather.min$year, 
      y = boston.weather.min$min.temp,
      col = 'blue')
legend(2014, 100, 
       legend = c('Max', 'Min'),
       col = c('red', 'blue'), lty = 1)

## ------------------------------------------------------------------------
plot(x = boston.weather.min$min.temp, 
     y = boston.weather.max$max.temp)

## ------------------------------------------------------------------------
plot(x = boston.weather.min$min.temp, 
     y = boston.weather.max$max.temp)
abline(lm(boston.weather.max$max.temp ~ boston.weather.min$min.temp))

## ------------------------------------------------------------------------
cor(x = boston.weather.min$min.temp, 
     y = boston.weather.max$max.temp)

## ------------------------------------------------------------------------
summary(lm(boston.weather.max$max.temp ~ boston.weather.min$min.temp))

## ------------------------------------------------------------------------
head(boston.weather)

## ------------------------------------------------------------------------
hist(boston.weather$temp)

## ------------------------------------------------------------------------
?boxplot()
boxplot(temp~year, 
        data = boston.weather)

## ------------------------------------------------------------------------
# Create a data frame 
data(Seatbelts)
data.seatbelts <- data.frame(Year = floor(time(Seatbelts)),
                  Month = factor(cycle(Seatbelts),
                               labels = month.abb), Seatbelts)

## ----message = FALSE, warning = FALSE------------------------------------
# Now, let's plot the data, using the basic plotting function of ggplot2 
qplot(data = data.seatbelts, 
      x = Year, 
      y = DriversKilled, 
      main = 'Drivers Killed by Year')

