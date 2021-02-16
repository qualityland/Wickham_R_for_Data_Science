library(tidyverse)


#-------------------------------------------------------------------------------
## 3.2 Creating a Coordinate System and adding Layers
#-------------------------------------------------------------------------------


# mpg comes with ggplot2
ggplot2::mpg


# ggplot(data = <DATA>) +
#   <GEOM_FUNCTION>(mapping = aes(<MAPPINGS))


# engine displacement (l) vs. mileage (miles per gallon)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))


## 3.2.4 Exercises

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
## 3.3 Aesthetic Mappings
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


## 3.3.1 Excercises

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

# 6. What happens if you map an aesthetic to something other than a variable
#     name ,like 'aes(color = displ < 5)'?
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = !(displ > 5 & hwy > 22)))
# works fine


#-------------------------------------------------------------------------------
## 3.5 Facets
#-------------------------------------------------------------------------------

# add a 3rd variable using facet_wrap()
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)

# add 3rd and 4th variable using facet_grid()
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)

# same but with proper labels
drv.labs <- c('4-wheel', 'front-drive', 'rear-drive')
names(drv.labs) <- c('4', 'f', 'r')
cyl.labs <- c('4 cylinders', '5 cylinders', '6 cylinders', '8 cylinders')
names(cyl.labs) <- c(4, 5, 6, 8)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl, labeller = labeller(drv = drv.labs, cyl = cyl.labs)) +
  labs(title = "Fuel Efficiency on the Highway",
       subtitle = "split up by drive type and no. of cylinders",
       x = "Engine Displacment (l)",
       y = "Highway Efficiency (miles per gallon)"
       )

# add 3rd variable using facet_grid()
# (dot notation dropping rows)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(.~cyl)

# (dot notation dropping columns)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(cyl~.)

## 3.5.1 Excercises

# 1. What happens if you facet on a continuous variable?
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~cty)
#   A: creates a facet plot for each unique value of this variable.
#       internal: continuous variable is converted to a factor and then a
#                 separate plot displayed for every unique value.

# 2. Q: What do the empty cells in plot with 'facet_grid(drv ~ cyl)' mean?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl)) +
  facet_grid(drv ~ cyl)
#   A: means: there are no observation with this combination of 'drv' and
#       'cyl'values.
#   Q: How do they relate to this plot?
ggplot(data = mpg) +
  geom_point(mapping = aes(x = drv, y = cyl))
#   A: also shows that there is no data with these combinations of 'drv' and
#       'cyl' values.

# 3. Q: What plots does the following code make? What does '.' do?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)
#   A: facet_grid by default splits up facets for two additional variables,
#       if only one additional variable is needed the '.' defines if rows or
#       columns should not be used (formula: rows ~ columns).
#   A: the above plot arranges facets for different drives (drv) in rows.

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)
#   A: the above plot arranges facets in columns for different number of
#       cylinders (cyl).

# 4. Take the first faceted plot in this section:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
#   Q: What are the advantages to using faceting instead of the color aesthetic?
#   A: It's easier to see where a whole group is located. Less overplotting.

#   Q: What are the disadvantages?
#   A: Difficult to do exact comparisons since different plots have to be
#       compared.
#   Q: How might the balance change if you had a larger dataset?
#   A: Especially on a large dataset facetting will be valueable, while
#       e.g. different colors will lead to a big cloud of differently colored
#       data points.

# 5. Read ?facet_wrap.
#     Q: What does nrow do?
#     A: defines in how many rows the different facets should be split.

#     Q: What does ncol do?
#     A: defines in how many columns the different facets are split.

#     Q: What other options control the layout of the individual panels?
#     Q: Why doesn’t facet_grid() have nrow and ncol arguments?
#     A: Because number of rows and columns is defined by the data (
#         observations that fit 3rd and 4th variable).

# 6. Q: When using facet_grid() you should usually put the variable with more
#     unique levels in the columns. Why?
#     A: It's more difficult to compare y values when they are more distant
#         on the y axis.


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
