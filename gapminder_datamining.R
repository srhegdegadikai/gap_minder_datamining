library(gapminder)
library(tidyverse)
library(gganimate)

# india - population growth along with lifexpetency as a timeseries 
gapminder %>% filter(country == "India") %>% ggplot(.,aes(year,lifeExp)) +
  geom_line() + geom_point(aes(size =pop))

# the same plot as above for the whole world
gapminder %>% group_by(continent,year) %>% 
  summarise(population = sum(as.numeric(pop)), life_expectency = sum(lifeExp)/n()) %>%
  ggplot(.,aes(year,life_expectency)) +
  geom_line(aes(color = continent)) + 
  geom_point(aes(size = population, color = continent), alpha = .7) +
  ggtitle("Population growth along with the change in life expectency over the years")

# gdp vs population
gapminder %>% group_by(continent,year) %>% 
  summarise(population = sum(as.numeric(pop)), percapita_GDP = sum(gdpPercap)/n()) %>%
  ggplot(.,aes(year,percapita_GDP)) +
  geom_line(aes(color = continent)) +
  geom_point(aes(size = population, color = continent), alpha = .7) +
  ggtitle("Population growth along with the change in Per Capita GDP over the years")

# read the fertility and the child death data

child_mortality <- read_csv("child_death.csv")
fertility <- read_csv("fertility.csv")

gapminder %>% left_join(fertility) %>% left_join(child_mortality)-> gapminder

# population vs fertility rate
gapminder %>% group_by(continent,year) %>% drop_na() %>% 
  summarise(population = sum(as.numeric(pop)), avg_fertility = sum(fertility_rate)/n(),
            early_death_of_child = sum(sum(total_deaths)/pop)/n()) %>%
    ggplot(.,aes(population,avg_fertility,frame =year)) + 
      geom_point(aes(size=early_death_of_child,color=continent, cumulative = TRUE)) +
      geom_line(aes(cumulative = TRUE,color=continent)) +
  labs(x = "Population", y= "Avg. Fertiltiy", size = "Child Mortality", 
       color = "Continent") +
  ggtitle("Change in Fertiltiy over the years along with Population and Child mortality - ") -> gg

gganimate(gg, filename = "country.gif", ani.width = 800, ani.height = 500)


