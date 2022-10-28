library(tidyverse)


#-------------------------------------------------------------------------------
## 3.2 Creating a Coordinate System and adding Layers
#-------------------------------------------------------------------------------


# mpg (miles per gallon) comes with the ggplot2 package
ggplot2::mpg


## 3.2.3 A graphing template

# ggplot(data = <DATA>) +
#   <GEOM_FUNCTION>(mapping = aes(<MAPPINGS))


# engine displacement (l) vs. mileage (miles per gallon)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))


## 3.2.4 Exercises

# 1. Run ggplot(data = mpg). What do you see?
ggplot(data = mpg)
# an empty coordinate system without any layers.


# 2. How many rows are in mpg? How many columns?
# 234 rows, 11 columns
mpg
dim(mpg)
nrow(mpg)
ncol(mpg)


# 3. What does the 'drv' variable describe? Read the help to ?mpg
?mpg
# drv - the type of drive train, where:
#   f = front-wheel drive,
#   r = rear wheel drive,
#   4 = 4wd


# 4. Make a scatterplot of 'hwy' vs 'cyl'.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = cyl, y = hwy))


# 5. What happens when you make a scatterplot of 'class' vs 'drv'?
#    Why is the plot not usefull?
ggplot(data = mpg) +
  geom_point(mapping = aes(x = drv, y = class))
# Only shows which car type is available with which drives.
# Not useful because many data points are overlapping.
# better:
ggplot(data = mpg) +
  geom_jitter(mapping = aes(x = drv, y = class))
