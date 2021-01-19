# install tidyverse
install.packages("tidyverse")


# additional packages
install.packages(c("nycflights13", "gapminder", "Lahman"))


# check for updated tidyverse package
tidyverse::tidyverse_update()


# check your OS and tidyverse package versions
# former devtools::session_info(); now in separate package.
sessioninfo::session_info(c("tidyverse"))
