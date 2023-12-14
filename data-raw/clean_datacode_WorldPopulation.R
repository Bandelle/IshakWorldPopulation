library(tidyverse)
library(rvest)
library(readxl)

Estimate_Population <- read_excel("data-raw/World_Population.xlsx" ,sheet = 1,skip = 16)
Estimate_Population_2 <- Estimate_Population  %>% select(-1,-2,-4:-7) %>% slice(-1:-26) %>% rename(Country_Name='Region, subregion, country or area *')
Estimate_Population_2

names_to_remove <- c("Middle Africa","Southern Africa","Western Africa",
                     "NORTHERN AFRICA AND WESTERN ASIA","Northern Africa","Western Asia",
                     "CENTRAL AND SOUTHERN ASIA","Central Asia","Southern Asia",
                     "EASTERN AND SOUTH-EASTERN ASIA","Eastern Asia","South-Eastern Asia",
                     "LATIN AMERICA AND THE CARIBBEAN","Caribbean","Central America",
                     "South America","AUSTRALIA/NEW ZEALAND",
                     "OCEANIA (EXCLUDING AUSTRALIA AND NEW ZEALAND)",
                     "Melanesia","Micronesia","Polynesia",
                     "EUROPE AND NORTHERN AMERICA","EUROPE","Eastern Europe",
                     "Northern Europe","Southern Europe","Western Europe","NORTHERN AMERICA")

WorldPopulation <- Estimate_Population_2[!(Estimate_Population_2$Country_Name %in% names_to_remove),] %>% drop_na() %>%
  mutate_at(vars(matches('19')),as.numeric) %>%
  mutate_at(vars(matches('20')),as.numeric)

usethis::use_data(WorldPopulation,overwrite = TRUE)
