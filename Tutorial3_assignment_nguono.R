
# Tutorial 3 Assignment
# Name: Kevin Ng'uono
# Date: 26th July,2026
# Title: Gapminder Data Analysis and Visualization

# Task 2: Load required packages
library(dplyr)
library(ggplot2)
library(patchwork)


# Task 3: Read the dataset
gapminder <- read.csv("data/gapminder_data.csv",
                      stringsAsFactors = FALSE)

# Check dataset
head(gapminder)
str(gapminder)

#Task 4: Scatter plot Life Expectancy vs GDP per capita
ggplot(gapminder,
       aes(x = lifeExp,
           y = gdpPercap)) +
  geom_point()

# Task 5: Colour scatter plot by continent
ggplot(gapminder,
       aes(x = lifeExp,
           y = gdpPercap,
           colour = continent)) +
  geom_point()


# Task 6: Transform GDP using log10
ggplot(gapminder,
       aes(x = lifeExp,
           y = log10(gdpPercap),
           colour = continent)) +
  geom_point()


# Task 7: Facet by continent
ggplot(gapminder,
       aes(x = lifeExp,
           y = log10(gdpPercap),
           colour = continent)) +
  geom_point() +
  facet_grid(~continent)



# Task 8: Add theme and save as plot1
plot1 <- ggplot(gapminder,
                aes(x = lifeExp,
                    y = log10(gdpPercap),
                    colour = continent)) +
  geom_point() +
  facet_grid(~continent) +
  theme_minimal() +
  labs(
    title = "Life Expectancy vs GDP per Capita",
    x = "Life Expectancy",
    y = "Log10 GDP per Capita"
  )

plot1


# Task 9: Density plot of Life Expectancy by continent
ggplot(gapminder,
       aes(x = lifeExp,
           fill = continent)) +
  geom_density(alpha = 0.5) +
  theme_minimal()


# Task 10: Life expectancy over time by country
plot2 <- ggplot(gapminder,
                aes(x = year,
                    y = lifeExp,
                    colour = country)) +
  geom_line() +
  theme_minimal() +
  theme(legend.position = "none") +
  labs(
    title = "Life Expectancy Over Time",
    x = "Year",
    y = "Life Expectancy"
  )

plot2

# Task 11: GDP per capita in 2007 by continent
gapminder_2007 <- gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarise(mean_gdp = mean(gdpPercap,
                            na.rm = TRUE))


gapminder_2007

# Task 12: Point plot of mean GDP by continent
ggplot(gapminder_2007,
       aes(x = continent,
           y = mean_gdp,
           colour = continent)) +
  geom_point()

# Task 13: Bar plot of mean GDP by continent
ggplot(gapminder_2007,
       aes(x = continent,
           y = mean_gdp,
           fill = continent)) +
  geom_col() +
  labs(
    title = "Mean GDP per Capita in 2007",
    x = "Continent",
    y = "Mean GDP per Capita"
  ) +
  theme_minimal()

# Task 14: Summary dataset by continent and year
gapminder_summary <- gapminder %>%
  group_by(continent, year) %>%
  summarise(
    mean_gdp = mean(gdpPercap, na.rm = TRUE),
    mean_lifeExp = mean(lifeExp, na.rm = TRUE)
  )

# Task 15: Line plot mean life expectancy

plot3 <- ggplot(gapminder_summary,
                aes(x = year,
                    y = mean_lifeExp,
                    colour = continent)) +
  geom_line() +
  geom_point() +
  theme_minimal() +
  labs(
    title = "Mean Life Expectancy by Continent",
    x = "Year",
    y = "Mean Life Expectancy"
  )

plot3

# Task 16: Kenya dataset
kenya_gapminder <- gapminder %>%
  filter(country == "Kenya")

# Task 17: Kenya GDP trend
ggplot(kenya_gapminder,
       aes(x = year,
           y = gdpPercap)) +
  geom_line(color = "blue") +
  geom_point(color = "blue") +
  labs(
    title = "GDP per Capita in Kenya",
    x = "Year",
    y = "GDP per Capita"
  ) +
  theme_minimal()


# Task 18: Identify decreasing life expectancy
gapminder_decline <- gapminder %>%
  filter(year %in% c(1997,2002,2007),
         diff_lifeExp < 0)


# Task 19: Bar plot of life expectancy decline
ggplot(gapminder_decline,
       aes(x = country,
           y = diff_lifeExp,
           fill = country)) +
  geom_col() +
  facet_grid(~year,
             scales = "free_x") +
  theme(
    axis.text.x =
      element_text(angle = 90,
                   vjust = 0.5,
                   hjust = 1)
  )

# Task 20: Final version saved as plot4
plot4 <- ggplot(gapminder_decline,
                aes(x = country,
                    y = diff_lifeExp,
                    fill = country)) +
  geom_col() +
  facet_grid(~year,
             scales = "free_x") +
  theme_minimal() +
  theme(
    legend.position = "none",
    axis.text.x =
      element_text(angle = 90,
                   vjust = 0.5,
                   hjust = 1)
  ) +
  labs(
    title = "Countries with Declining Life Expectancy",
    x = "Country",
    y = "Reduction in Life Expectancy"
  )


plot4


plot4


# Task 21: Combine four plots using patchwork
combined_plot <- (plot1 | plot2) /
  (plot3 | plot4)

combined_plot

# Task 22: Save combined figure
ggsave("gapminder_combined_plot.png",
       combined_plot,
       width = 12,
       height = 10)         
  
library(rmarkdown)
library(knitr)
library(patchwork)
library(tinytex)

