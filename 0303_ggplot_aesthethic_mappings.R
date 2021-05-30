library(tidyverse)


#-------------------------------------------------------------------------------
## 3.3 Aesthetic Mappings
#-------------------------------------------------------------------------------


# add a 3rd variable 'class' (visualized with different colors)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))


# mapping an unordered variable (class) to an ordered aesthetic (size) raises
# a warning:
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = class))


# warning: ordered aesthetic 'alpha' (transparency) used for a discrete
#          variable 'class'
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

# 1.  Q: What's done wrong with this code? Why are the points not blue?
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))

#     A: Manual mapping must be done OUTSIDE of the aes() function
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# 2.  Q: Which variables in 'mpg' are categorical?
#     A: manufacturer, model, trans, drv, fl, class
#     Q: Which variables are continuous?
#     A: displ, year, cty, hwy
#     Q: How can you see this information when you run 'mpg'?
#     A: The for a tibble the data type of a vaciable is visible right below
#        the column name. For data frames use str(<data frame>).

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
#     A: For categorical data the legend shows a level for every category (as
#         long as levels are available).
#         For continuous data it shows only some levels (e.g. full numbers).

# 4.  Q: What happens if you map the same variable to multiple aesthetics?
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = cty, size = cty))
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = cyl, shape = as.character(cyl)))
#     A: Data points vary in both aesthetics (e.g. color and size).

# 5.  Q: What does the 'stroke' aesthetic do? What shapes does it work with?
#       (Hint: use ?geom_point)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, stroke = cyl), shape = 21,
             fill = 'red', size = 4, color = 'white')
#     A: 'stroke' surrounds the points with a yard or lift.

# 6.  Q: What happens if you map an aesthetic to something other than a variable
#       name ,like 'aes(color = displ < 5)'?
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = !(displ > 5 & hwy > 22)))
#     A: The expression is shown in the legend and both values (TRUE or FALSE)
#       are displayed in different level of the aesthetic.
