library(readr)
library(dplyr)

#This is a test from Joseph Crouson

# Load data into dataframe
aclu <- read_csv('aclu_separations.csv')

#Inspect data
head(aclu)
summary(aclu)

#Clean the data.  addr column same info as program_city and program_state
aclu <- aclu %>%
  select(-addr)

aclu

#Rename columns for explicit readability and understanding
aclu <- aclu %>%
  rename(city = program_city, state = program_state,
         number_children = n, longitude = lon, latitude = lat)

aclu

#We are interested in knowing how far the detention centers were from the US-Mexico Border.  Add column for that data.
border_latitude <- 25.83

aclu <- aclu %>%
  mutate(lat_change_border = latitude - border_latitude)
aclu

#New dataframe containing detention centers that were far away from where separations occurred
further_away <- aclu %>%
  filter(lat_change_border > 15) %>%
  arrange(desc(lat_change_border))

further_away

#New dataframe containing detnetion centers with the most children in desc order
ordered_by_children <- aclu %>%
  arrange(desc(number_children))

ordered_by_children

#New dataframe containing detenction centers in the state of Texas in desc order of number_children
chosen_state <- 'TX'

chosen_state_separations <- aclu %>%
  filter(state == chosen_state) %>%
  arrange(desc(number_children))

chosen_state_separations