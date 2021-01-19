library(tidyverse)


# mpg comes with ggplot2
ggplot2::mpg


# engine displacement (l) vs. mileage (miles per gallon)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))
