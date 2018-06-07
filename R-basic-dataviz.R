########################################
## Basic data viz in R 
##    Christine Zhang  			          
##     @christinezhang                
##  ychristinezhang at gmail dot com  
########################################

## Basic data visualization in R
## By Christine Zhang (@christinezhang on Twitter; ychristinezhang at gmail dot com)

# Link to annotated code: 
# https://github.com/underthecurve/r-dataviz-ggplot2/blob/master/R-basic-dataviz.md (markdown file for viewing on the web)
# https://github.com/underthecurve/r-dataviz-ggplot2/blob/master/R-basic-dataviz.pdf (pdf file for printing out)

# Before starting, ensure this .R file and the following data file are in the same folder:
# "boston_weather.csv"

# We need to tell R that our files are saved in the same location.
# In order to do this, you should click through the following:
# "Session --> Set Working Directory --> To Source File Location"

# In this workshop, we will:
  # - Go through a quick overview of some common graphic types
  # - Plot some common chart types in R

## Loading `tidyverse` and reading in data

# install.packages('tidyverse') # if you don't already have tidyverse
library('tidyverse') # load the tidyverse package

boston.weather <- read_csv('boston_weather.csv')

head(boston.weather)

#### Bar plot ####

barplot(boston.weather$temp)

boston.weather.max <- boston.weather %>% # the dataframe
  group_by(year) %>% # the grouping variable
  summarise(max.temp = max(temp)) # the variable we want: maximum temperature

head(boston.weather.max)

barplot(boston.weather.max$max.temp)

barplot(boston.weather.max$max.temp, 
        names.arg = boston.weather.max$year)

barplot(boston.weather.max$max.temp, 
        names.arg = boston.weather.max$year, 
        ylim = c(0, 100))

#### Line plot ####

?plot()
plot(x = boston.weather.max$year, 
     y = boston.weather.max$max.temp, 
     type = 'l')

plot(x = boston.weather.max$year, 
     y = boston.weather.max$max.temp, 
     type = 'l', 
     xlab = 'year',
     ylab = 'temperature (in F)',
     main = 'Maximum temperatures in Boston on June 7th\n2007-2017\n')

boston.weather.min <- boston.weather %>% # the dataframe
  group_by(year) %>% # the grouping variable
  summarise(min.temp = min(temp)) # the variable we want: minimum temperature

plot(x = boston.weather.max$year, 
     y = boston.weather.max$max.temp,
     type = 'l', 
     xlab = 'year',
     ylab = 'temperature (in F)',
     main = 'Max and min temperatures in Boston on June 7th\n2007-2017\n')
lines(x = boston.weather.min$year, 
      y = boston.weather.min$min.temp)

plot(x = boston.weather.max$year, 
     y = boston.weather.max$max.temp,
     type = 'l', 
     xlab = 'year',
     ylab = 'temperature (in F)',
     main = 'Max and min temperatures in Boston on June 7th\n2007-2017\n',
     ylim = c(40, 100))
lines(x = boston.weather.min$year, 
      y = boston.weather.min$min.temp)

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

?legend()

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

#### Scatter plot ####

plot(x = boston.weather.min$min.temp, 
     y = boston.weather.max$max.temp)

plot(x = boston.weather.min$min.temp, 
     y = boston.weather.max$max.temp)
abline(lm(boston.weather.max$max.temp ~ boston.weather.min$min.temp))

cor(x = boston.weather.min$min.temp, 
     y = boston.weather.max$max.temp)

summary(lm(boston.weather.max$max.temp ~ boston.weather.min$min.temp))

#### Box plot ####

head(boston.weather)

hist(boston.weather$temp)

?boxplot()
boxplot(temp~year, 
        data = boston.weather)

#### A taste of ggplot2 ####

# Create a data frame 
data(Seatbelts)
data.seatbelts <- data.frame(Year = floor(time(Seatbelts)),
                  Month = factor(cycle(Seatbelts),
                               labels = month.abb), Seatbelts)

# Now, let's plot the data, using the basic plotting function of ggplot2 
qplot(data = data.seatbelts, 
      x = Year, 
      y = DriversKilled, 
      main = 'Drivers Killed by Year')

# Don't worry, we'll get more into what the data actually say in the next class. What do you see as some advantages to `ggplot2`?

#### What else? ####

# - How would you add axis labels and a title to the boxplot of hourly Boston temperatures?
# - What are some positive aspects and limitations to the base R graphics package?
# - Are there other chart types or data visualziation methods you are interested in exploring?