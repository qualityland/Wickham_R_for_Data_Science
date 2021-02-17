library(tidyverse)


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

