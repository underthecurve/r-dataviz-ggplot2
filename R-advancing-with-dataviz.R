## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ------------------------------------------------------------------------
# install.packages('tidyverse') # if you don't already have tidyverse
library('tidyverse') # load the tidyverse package

## ------------------------------------------------------------------------
# Create a data frame 
data(Seatbelts)
data.seatbelts <- data.frame(Year = floor(time(Seatbelts)),
                  Month = factor(cycle(Seatbelts),
                               labels = month.abb), Seatbelts)

## ----message=FALSE, warning=FALSE----------------------------------------
# Now, let's plot the data, using the basic plotting function of ggplot2 
qplot(data = data.seatbelts, x = Year, y = DriversKilled, main = 'Drivers Killed by Year')

## ------------------------------------------------------------------------
drivers.plot <- ggplot(data = data.seatbelts, # the data
       aes(x = Year, # 'aes' stands for 'aesthetics': what's on the x- and y- axes
           y = DriversKilled))

## ----message=FALSE, warning=FALSE----------------------------------------
drivers.plot

## ----message=FALSE, warning=FALSE----------------------------------------
drivers.plot + geom_point() # adding geometry layer

## ----message=FALSE, warning=FALSE----------------------------------------
drivers.plot + 
  geom_text(aes(label = Month))

## ----message=FALSE, warning=FALSE----------------------------------------
drivers.plot + geom_point() + ggtitle('Drivers Killed by Year')

## ----message=FALSE, warning=FALSE----------------------------------------
# These produce the exact same plot:
qplot(data = data.seatbelts, x = Year, y = DriversKilled, main = 'Drivers Killed by Year')

ggplot(data = data.seatbelts, 
       aes(x = Year, y = DriversKilled)) + 
  geom_point() + 
  ggtitle('Drivers Killed by Year') 

## ------------------------------------------------------------------------
life <- read_csv('life.csv')
str(life)

## ------------------------------------------------------------------------
head(life)

## ----eval = FALSE--------------------------------------------------------
## ggplot(_____, aes(x = ______, y = _____)) +
##   _____

## ----warning = FALSE, message=FALSE--------------------------------------
life.usa <- life %>% filter(country.code == 'USA')

## ------------------------------------------------------------------------
ggplot(life.usa, aes(x = male, y = female)) +
  geom_point() 

## ------------------------------------------------------------------------
ggplot(life.usa, aes(x = male, y = female)) +
  geom_point() +
  geom_line()

## ------------------------------------------------------------------------
ggplot(life.usa, aes(x = male, y = female)) +
  geom_point() +
  geom_smooth()

## ------------------------------------------------------------------------
ggplot(life.usa, aes(x = male, y = female)) +
  geom_point() +
  geom_smooth(method = 'lm', se = F)

## ------------------------------------------------------------------------
ggplot(life, aes(x = year, y = `both sexes`)) +
  geom_point()

## ------------------------------------------------------------------------
ggplot(life, aes(x = year, y = `both sexes`)) +
  geom_point() +
  geom_line() # what if I had run geom_smooth() instead?

## ------------------------------------------------------------------------
ggplot(life, aes(x = year, y = `both sexes`, group = country)) +
  geom_point() +
  geom_line() 

## ------------------------------------------------------------------------
ggplot(life, aes(x = year, y = `both sexes`, group = country)) +
#  geom_point() +
  geom_line() 

## ------------------------------------------------------------------------
ggplot(life, aes(x = year, y = `both sexes`, group = country)) +
  geom_line() +
  facet_wrap(~ country)

## ------------------------------------------------------------------------
americas <- life %>% filter(region == 'Americas' & year == 2015)

## ------------------------------------------------------------------------
ggplot(data = americas, aes(x = `both sexes`, y = country)) +
  geom_point()

## ------------------------------------------------------------------------
class(americas$country) # a character
americas$country.factor <- as.factor(americas$country)
class(americas$country.factor) # a factor

## ------------------------------------------------------------------------
levels(americas$country.factor)

## ------------------------------------------------------------------------
# install.pacakges('forcats') #if you don't already have forcats 
library('forcats') #load forcats package

americas$country.factor.reorder <- fct_reorder(americas$country.factor, # factor variable to reorder
                                               americas$`both sexes`) # variable to reorder it by

## ------------------------------------------------------------------------
levels(americas$country.factor.reorder)

## ------------------------------------------------------------------------
ggplot(data = americas, aes(x = `both sexes`, y = country.factor.reorder)) +
  geom_point()

## ------------------------------------------------------------------------
p <- ggplot(data = americas, 
            aes(x = `both sexes`, y = fct_reorder(country.factor, `both sexes`))) +
  geom_point()

p

## ------------------------------------------------------------------------
p + labs(x = 'Life expectancy at birth in 2015, years', y = '')

## ------------------------------------------------------------------------
p + labs(x = 'Life expectancy at birth in 2015, years', y = '') + 
  scale_x_continuous(limits = c(50, 100))

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

## ------------------------------------------------------------------------
# plot1 + theme_bw()
# install.packages('ggthemes') # if you don't already have ggthemes
library('ggthemes') # load the ggthemes pacakge
plot1 + theme_few()

## ------------------------------------------------------------------------
plot1 + theme(panel.background = element_blank())

## ------------------------------------------------------------------------
ggsave('plot1.png', plot1 + theme_few())
ggsave('plot1.png', plot1 + theme_few(), width = 8, height = 6)

## ------------------------------------------------------------------------
# install.packages('gapminder') # if you don't already have gapminder
library('gapminder') # load the gapminder package
gapminder

## ------------------------------------------------------------------------
p <- ggplot(data = gapminder %>% filter(year == 2007), aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

p

## ------------------------------------------------------------------------
p <- ggplot(data = gapminder %>% filter(year == 2007), aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(size = pop))

## ------------------------------------------------------------------------
p
p + scale_size_area()

## ------------------------------------------------------------------------
p <- ggplot(data = gapminder %>% filter(year == 2007), aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(size = pop, color = continent))

p + scale_size_area()

## ------------------------------------------------------------------------
p <- ggplot(data = gapminder %>% filter(year == 2007), aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(size = pop), color = 'blue')

p + scale_size_area(max_size = 10) 
# max_size = 10 sets the maximum size of the points (in this case, it makes them larger)

## ------------------------------------------------------------------------
p + scale_size_area(max_size = 10) + theme(legend.position = 'bottom')

## ----eval = FALSE--------------------------------------------------------
## ggplot(data = americas, aes(x = country.factor, y = `both sexes`)) +
##   geom_bar()

## ------------------------------------------------------------------------
ggplot(data = americas, aes(x = country.factor)) +
  geom_bar()

ggplot(data = americas, aes(x = country.factor, y = `both sexes`)) +
  geom_bar(stat = 'identity')

## ------------------------------------------------------------------------
p <- ggplot(data = americas, aes(x = country.factor, y = `both sexes`)) +
  geom_col()

## ------------------------------------------------------------------------
p + coord_flip()

