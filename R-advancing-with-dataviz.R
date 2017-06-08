##########################################################
## Advancing with data visualization in R using `ggplot2` 
##    Christine Zhang  			          
##     @christinezhang                
##  ychristinezhang at gmail dot com  
##########################################################

## Advancing with data visualization in R using `ggplot2`
## By Christine Zhang (@christinezhang on Twitter; ychristinezhang at gmail dot com)

# Link to annotated code: 
# xxxxx (markdown file for viewing on the web)
# xxxxx (pdf file for printing out)

# Before starting, ensure this .R file and the following data file are in the same folder:
# "life.csv"

# We need to tell R that our files are saved in the same location.
# In order to do this, you should click through the following:
# "Session --> Set Working Directory --> To Source File Location"

# In this workshop, we will:
#   
# - Examine the basic syntax of `ggplot2`
# - Use global life expectancy data to produce different type of plots charts using `ggplot2`
# - Explore advanced features of `ggplot2`
# - Learn to export graphics for publication

# install.packages('ggplot') # if you don't already have ggplot2
library('ggplot2') # load the ggplot2 package

#### The syntax of `ggplot2` ####

# Make a dataframe 
data(Seatbelts)
s <- as.data.frame(Seatbelts)

# Add in time-series data 
ts <- data.frame(Year=floor(time(Seatbelts)),
                 Month=factor(cycle(Seatbelts),
                              labels=month.abb), Seatbelts)

# Now, let's plot the data, using the basic plotting function of ggplot2 
qplot(data = ts, x = Year, y = DriversKilled, main = 'Drivers Killed by Year')

drivers.plot <- ggplot(data = ts, # the data
       aes(x = Year, # 'aes' stands for 'aesthetics': what's on the x- and y- axes
           y = DriversKilled))

drivers.plot

drivers.plot + geom_point() # adding geometry layer

drivers.plot + geom_point() + ggtitle('Drivers Killed by Year')

# These produce the exact same plot:
qplot(data = ts, x = Year, y = DriversKilled, main = 'Drivers Killed by Year')

ggplot(data = ts, 
       aes(x = Year, y = DriversKilled)) + 
  geom_point() + 
  ggtitle('Drivers Killed by Year') 

#### Life expectancy by country, 2000 to 2015 ####

life <- read.csv('life.csv', stringsAsFactors = F)
str(life)

head(life)

#### Scatter plots ####

# install.packages('dplyr') # if you don't already have the package
library('dplyr') # load the dplyr package
life.usa <- life %>% filter(country.code == 'USA')

ggplot(life.usa, aes(x = male, y = female)) +
  geom_point() 

ggplot(life.usa, aes(x = male, y = female)) +
  geom_point() +
  geom_line()

ggplot(life.usa, aes(x = male, y = female)) +
  geom_point() +
  geom_smooth()

ggplot(life.usa, aes(x = male, y = female)) +
  geom_point() +
  geom_smooth(method = 'lm', se = F)

ggplot(life, aes(x = year, y = both.sexes)) +
  geom_point()

ggplot(life, aes(x = year, y = both.sexes)) +
  geom_point() +
  geom_line() # what if I had run geom_smooth() instead?

## Why didn't that work correctly?

ggplot(life, aes(x = year, y = both.sexes, group = country)) +
  geom_point() +
  geom_line() 

ggplot(life, aes(x = year, y = both.sexes, group = country)) +
#  geom_point() +
  geom_line() 

#### Facetted plots ####

ggplot(life, aes(x = year, y = both.sexes, group = country)) +
  geom_line() +
  facet_wrap(~ country)

# What do we see in this plot (the zoomed in one on RStudio, not the one you actually see above) that we can't see in the one before it? Note you wouldn't publish the above graph, but it's useful as an exploratory exercise.

#### Reordering a plot ####

americas <- life %>% filter(region == 'Americas' & year == 2015)

ggplot(data = americas, aes(x = both.sexes, y = country)) +
  geom_point()

# Why didn't I put the countries on the x-axis?
# What would make this plot look better?

class(americas$country) # a character
americas$country.factor <- as.factor(americas$country)
class(americas$country.factor) # a factor

levels(americas$country.factor)

# install.pacakges('forcats') #if you don't already have forcats 
library('forcats') #load forcats package

americas$country.factor.reorder <- fct_reorder(americas$country.factor, americas$both.sexes)
  
levels(americas$country.factor.reorder)

## How can we check that that worked?

ggplot(data = americas, aes(x = both.sexes, y = country.factor.reorder)) +
  geom_point()

p <- ggplot(data = americas, aes(x = both.sexes, y = fct_reorder(country.factor, both.sexes))) +
  geom_point()

p

# Why didn't we need the dollar signs (e.g., `fct_reorder(americas$country.factor, americas$both.sexes)` this time)?

#### Axes labels and scales ####

p + labs(x = 'Life expectancy at birth in 2015, years', y = '')

p + labs(x = 'Life expectancy at birth in 2015, years', y = '') + scale_x_continuous(limits = c(50, 100))

## ------------------------------------------------------------------------
p + labs(x = 'Life expectancy at birth in 2015, years', y = '') + 
  scale_x_continuous(limits = c(60, 85), # minimum and maximum for the x-axis 
                     breaks = seq(from = 60, to = 85, by = 5)) # x-axis labels

## ------------------------------------------------------------------------
# ?scale_x_continuous()
plot1 <- p + labs(x = 'Life expectancy at birth in 2015, years', y = '') + 
  scale_x_continuous(limits = c(60, 85),  # minimum and maximum for the x-axis 
                     breaks = seq(from = 50, to = 100, by = 5), # x-axis labels
                     minor_breaks = NULL) +
  ggtitle("Haiti's life expectancy is the lowest in the region") # why did I use double quotes here?

plot1

#### Adjusting themes/appearance ####

# plot1 + theme_bw()
# install.packages('ggthemes') # if you don't already have ggthemes
library('ggthemes') # load the ggthemes pacakge
plot1 + theme_few()

#### Saving a plot ####

ggsave('plot1.png', plot1 + theme_few())
ggsave('plot1.png', plot1 + theme_few(), width = 8, height = 6)

#### Other attributes of ggplot: sizes, scales, and colors ####

# install.packages('gapminder') # if you don't already have gapminder
library('gapminder') # load the gapminder package
gapminder

## Exercise: create a scatter plot of GDP per capita in 2007 on the x-axis and life expectancy in 2007 on the y-axis and put it into an R object called `p`
  
p <- ggplot(data = gapminder %>% filter(year == 2007), aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

p

p <- ggplot(data = gapminder %>% filter(year == 2007), aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(size = pop))

p
p + scale_size_area()

p <- ggplot(data = gapminder %>% filter(year == 2007), aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(size = pop, color = continent))

p + scale_size_area()

# What if we just wanted the colors of the points to be, say, blue rather than mapped to the `continent` variable?

p <- ggplot(data = gapminder %>% filter(year == 2007), aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(size = pop), color = 'blue')

p + scale_size_area() 

#### Bar plots ####

ggplot(data = americas, aes(x = country.factor, y = both.sexes)) +
 geom_bar()

# Why didn't this work?
# Try this: 
# also try ?geom_bar()

ggplot(data = americas, aes(x = country.factor)) +
  geom_bar()

ggplot(data = americas, aes(x = country.factor, y = both.sexes)) +
  geom_bar(stat = 'identity')

p <- ggplot(data = americas, aes(x = country.factor, y = both.sexes)) +
  geom_col()

p + coord_flip()

## Exercise: reorder the bars by life expectancy from highest to lowest using the `fct_reorder` function in `forcats`

#### What else? ####

# - Change the look and feel of the bar graph above to your liking using the tools we've learned today and save it as a `.png` file.
# 
# - What other visualizations could you make using the `gapminder` dataset?
# 
# - What are some other customizations of `ggplot2` plots would you like to see that we haven't covered today (additional resources are the GitHub repo)