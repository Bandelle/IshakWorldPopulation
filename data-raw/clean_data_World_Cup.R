library(tidyverse)
library(rvest)
library(readxl)

url <- 'https://en.wikipedia.org/wiki/FIFA_World_Cup'
page <- read_html(url)

w_cup <-
  page %>% html_nodes('table') %>%
  .[[4]] %>%
  html_table(header=FALSE, fill =TRUE) %>%
  slice(-1*1:2) %>% select(1:6)

World_Cup <- w_cup %>% magrittr::set_colnames(c('Year','Hosts','Venues/Cities','Totalattendance','Matches','Averageattendance')) %>% select(-3) %>% select(1,2,4,3,5) %>%
  mutate_at(vars(matches('attendance')),str_remove_all, ',') %>%
  mutate_at(vars(matches('attendance')),as.numeric) %>%
  mutate_at(vars(matches('Matches')),as.numeric) %>%
  mutate_at(vars(matches('Year')),as.factor) %>%
  drop_na() %>% slice(-23)

usethis::use_data(World_Cup,overwrite = TRUE)
