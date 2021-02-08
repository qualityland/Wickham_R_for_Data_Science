library(tidyverse)


#-------------------------------------------------------------------------------
## Creating a Coordinate System and adding Layers
#-------------------------------------------------------------------------------


# mpg comes with ggplot2
ggplot2::mpg


# ggplot(data = <DATA>) +
#   <GEOM_FUNCTION>(mapping = aes(<MAPPINGS))


# engine displacement (l) vs. mileage (miles per gallon)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))


## Exercises
# Run ggplot(data = mpg). What do you see?
ggplot(data = mpg)
# an empty coodinate system without any layers.


# How many rows are in mpg? How many columns?
# 234 rows, 11 columns
mpg
dim(mpg)
nrow(mpg)
ncol(mpg)


# What does the 'drv' variable describe? Read the help to ?mpg
?mpg
# drv - the type of drive train, where:
#   f = front-wheel drive,
#   r = rear wheel drive,
#   4 = 4wd


#-------------------------------------------------------------------------------
## Aesthetic Mappings
#-------------------------------------------------------------------------------


# 3rd variable 'class', visualized with different colors
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

