################################################################################
# Data wrangling homework
################################################################################
#
# Katherine Polatchek
# kgp31@miami.edu
# 19 October 2025
#
# Data wrangling homework exercise/final project prep
#
################################################################################

#Load packages

library(tidyverse)
library(EVR628tools)
library(janitor)

#Load data

shark_catch_data <- read_csv(file = "data/raw/PublicLLShark/PublicLLSharkNum.csv") |>
  rename(Latitude = LatC5,
         Longitude = LonC5) #Rename columns

#Check column names

colnames(shark_catch_data)

#Filter data to only include number of sharks caught (no longer include weight data)

number_sharks_caught <-
  select(shark_catch_data, -c(17:26))

#Check column names for new object

colnames(number_sharks_caught)

#Change species codes to more logical names

number_sharks_caught <- number_sharks_caught |>
  rename(Blue = BSHn,
         Blacktip = CCLn,
         Silky = FALn,
         Mako = MAKn,
         Oceanic_whitetip = OCSn,
         Requiem = RSKn,
         Miscellaneous_species = SKHn,
         Shortfin_mako = SMAn,
         Hammerhead = SPNn,
         Thresher = THRn)

#Save processed data

saveRDS(shark_catch_data, "data/processed/clean_shark_catch_data.rds")
saveRDS(number_sharks_caught, "data/processed/clean_number_sharks_caught.rds")
