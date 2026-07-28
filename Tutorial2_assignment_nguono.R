#Task:Skill check tutorial 2
#Date:26th July, 2026
#dataset:Covid-19
#Author:Kevin Ng'uono
#loading dplyr packages
library(dplyr)

#reading the comma separated file
#covid19 <- read.csv("data/covid19_data.csv", stringsAsFactors = FALSE)
Covid_19 <-read.csv("C:/Users/user/OneDrive/Desktop/R/R_Course/Data/covid19_data.csv")

#Dimension of the dataset dim("_var")
dim(Covid_19)

#Rows=2214 & columns=8
#Dataset Structure str("_var")
str("Covid_19")
#Character that is chr()
#Summary of dataset
summary("Covid_19")
#Maximum Value is 8
# Arrange by population_2019
Covid_19 %>%
  arrange(population_2019) %>%
  head()
#  Filter for Ireland 
ireland_covid_data <- Covid_19 %>%
  filter(countries_and_territories == "Ireland")

head(ireland_covid_data)

#  Filter for East African countries 
east_africa_covid_data <- Covid_19 %>%
  filter(countries_and_territories %in% c("Kenya", "Uganda", "Tanzania",
                                          "Rwanda", "Burundi"))

head(east_africa_covid_data)

# Create mortality_rate variable 
mortality_covid19 <- Covid_19 %>%
  mutate(mortality_rate = (deaths / population_2019) * 1000)

head(mortality_covid19)

#saving
save(mortality_covid19,
     file = "mortality_covid19.RData")

# Arrange mortality_covid19 by mortality_rate (descending)
  mortality_covid19 %>%
  arrange(desc(mortality_rate)) %>%
  head()
# country and year_month with the highest mortality rate
  #Country   :Year_month :rate
  #San_merino:2020-03 :  0.7256262

#  Select specific columns 
mortality_selected <- mortality_covid19 %>%
  select(year_month,
         countries_and_territories,
         mortality_rate)

head(mortality_selected)

#  Group by country and count observations 
monthly_data_count <- Covid_19 %>%
  group_by(countries_and_territories) %>%
  count()

monthly_data_count

#  Arrange monthly_data_count to find smallest count 
monthly_data_count %>%
  arrange(n)
head(1)
# country had the smallest number of observations
#Vanuatu=2

# Task 15: Mean deaths in Ireland
#option 1
ireland_covid_data %>%
  summarise(mean_deaths = mean(deaths, na.rm = TRUE))

# Comment: Mean monthly deaths = 177.4167
#option 2
ireland_covid_data %>%
  summarise(mean_deaths = mean(deaths))

# Task 16: Total cases by continent

continent_cases <- Covid_19 %>%
  group_by(continent) %>%
  summarise(total_cases = sum(cases, na.rm = TRUE))

continent_cases

continent_cases %>%
  arrange(desc(total_cases))

# Comment:
# Continent with highest cases is America with  30899845 cases

# Task 17: Mean mortality rate by continent
continent_mortality <- Covid_19 %>%
  mutate(mortality_rate = (deaths / population_2019) * 1000) %>%
  group_by(continent) %>%
  summarise(mean_mortality_rate =
              mean(mortality_rate, na.rm = TRUE))

continent_mortality

continent_mortality %>%
  arrange(desc(mean_mortality_rate))

# Continent with highest mortality rate  is Europe with mortality rate of 0.0464

# Task 18: Highest monthly cases in Europe and America

Europe_America_cases <- Covid_19 %>%
  filter(continent %in% c("Europe", "America","Africa")) %>%
  group_by(year_month, continent) %>%
  summarise(total_cases = sum(cases, na.rm = TRUE),
            .groups = "drop") %>%
  arrange(continent, desc(total_cases))

Europe_America_cases

# Highest month for Europe
Europe_America_cases %>%
  filter(continent == "Europe") %>%
  head(1)

# Highest month for America
Europe_America_cases %>%
  filter(continent == "America") %>%
  head(1)

# Highest month for America
Europe_America_cases %>%
  filter(continent == "Africa") %>%
  head(1)

# Task 19: Percentage case fatality
case_fatality <- Covid_19 %>%
  filter(continent %in% c("Africa", "Europe")) %>%
  group_by(countries_and_territories) %>%
  summarise(
    total_cases = sum(cases, na.rm = TRUE),
    total_deaths = sum(deaths, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  mutate(
    percentage_case_fatality =
      (total_deaths / total_cases) * 100
  ) %>%
  arrange(desc(percentage_case_fatality))

case_fatality

# Country with highest percentage case fatality
case_fatality %>%
  head(1)
#Isle_of_Man    cases=370 deaths 25 pctof fatality=6.76

