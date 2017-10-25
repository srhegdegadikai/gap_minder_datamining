library(readxl)
library(tidyverse)

#read the data
fertility <- read_xlsx("fertility.xlsx")

# convert from wide form to long form of data
fertility %>% gather(year, fertility_rate, -`Total fertility rate`) -> fertility

# convert the year column into integer type
as.integer(fertility$year) -> fertility$year

# change the names of columns
col_names <- c("country","year","fertility_rate")
names(fertility) <- col_names

# save it to a csv file
write_csv(fertility,"fertility.csv")


# do the same for the other dataset
child_death <- read_xlsx("childdeaths.xlsx")

child_death %>% gather(year, total_deaths, -`Child deaths`) -> child_death

as.integer(child_death$year) -> child_death$year

col_names <- c("country","year","total_deaths")
names(child_death) <- col_names

write_csv(child_death,"child_death.csv")


