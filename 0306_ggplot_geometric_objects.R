library(tidyverse)


#-------------------------------------------------------------------------------
## 3.6 Geometric Objects
#-------------------------------------------------------------------------------

# scatter plot
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

# smoothing data points to a line
# displaying standard error as well
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

 
## 3.6.1 Exercises

# 1. What geom would you use to draw a line chart?
#     A boxplot?
#     A histogram?
#     An area chart?

# 2. Run this code in your head and predict what the output will look like.
#     Then, run the code in R and check your predictions.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

# 3. What does show.legend = FALSE do? What happens if you remove it?
#     Why do you think I used it earlier in the chapter?
  
# 4. What does the 'se' argument to geom_smooth() do?
#     A: se=TRUE shows standard errors.
  
# 5. Will these two graphs look different? Why/why not?
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
