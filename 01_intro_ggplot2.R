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

# 1. Run ggplot(data = mpg). What do you see?
ggplot(data = mpg)
# an empty coodinate system without any layers.


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
# But many data points are overlapping.


#-------------------------------------------------------------------------------
## Aesthetic Mappings
#-------------------------------------------------------------------------------


# 3rd variable 'class', visualized with different colors
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))


# mapping an unordered variable (class) to an ordered aesthetic (size) raises
# a warning:
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = class))


# a warning pops up when mapping 'class' to the transparency (alpha)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))


# even two warnings appear when mapping 'class' to the shape of the data points
# (more classes than available shapes!)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))


# manually changing an aesthetic
# (means: outside of aes() function)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# print all different shapes available in R
dat <- tibble(p = c(0:25, 32:127),
              x = p %% 16,
              y = p %/% 16)

ggplot(dat, aes(x, y)) +
  geom_text(aes(label = p), size = 3, nudge_y = -.25) +
  geom_point(aes(shape = p), size = 5, fill = "red") +
  scale_shape_identity() +
  theme_void()


## Excercises

# 1. What's done wrong with this code? Why are the points not blue?
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
# manual mapping must be done OUTSIDE of the aes() function
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# 2.  Q: Which variables in 'mpg' are categorical?
#     A: manufacturer, model, trans, drv, fl, class
#     Q: Which variables are continuous?
#     A: displ, year, cty, hwy
#     Q: How can you see this information when you run 'mpg'?
#     A: The data type is visible right below the column name.

# 3. Map a continuous variable to 'color', 'size' and 'shape'.
# color:
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = cyl))
# size:
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = cyl))
# shape:
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = as.character(cyl)))
#     Q: How do these aesthetics behave differently for categorical versus
#         continuous variables?
#     A: 'shape' raises an error using a continuous variable, but works when
#         converted to a character as long as there are only few different
#         values.

# 4. What happens if you map the same variable to multiple aesthetics?
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = cty, size = cty))
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = cyl, shape = as.character(cyl)))
#     A: Works - both aesthetics are modified.

# 5. What does the 'stroke' aesthetic do? What shapes does it work with?
#     (Hint: use ?geom_point)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, stroke = cyl), shape = 21,
             fill = 'red', size = 4, color = 'white')
#     A: 'stroke' surrounds the points with a yard or lift.
