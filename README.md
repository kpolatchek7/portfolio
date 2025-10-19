# EVR 628 portfolio

## Description

This data science portfolio will showcase the coding skills I develop
throughout the EVR 628 course.

## Project structure

'scripts/': R scripts for analysis
'results/': Output figures and tables

## Author

Katherine Polatchek

# Project objective

This project will use open source data from IATTC, specifically Shark EPO 
longline catch and effort aggregated by year, month, flag, 5°x5°. This data
will be analyzed to determine catch per unit effort of shark species by diving
total catch by number of hooks set. Additional analysis will aim to determine
the coordinates at which shark catch was highest for each year.

# Contents of project repository

Raw data:

LLShark-Tiburon.pdf: IATTC metadata
PublicLLSharkMt.csv: Contains effort and retained catch data by species
measured by weight (metric tons)
PublicLLSharkNum.csv: Contains effort and retained catch data by species
measured by number of individuals caught

R scripts:

data_processing.R: contains the data and packages loaded, and what steps were
taken to tidy the dataset

Processed data:

clean_shark_catch_data: contains data after adjusting latitude/longitude column
names
clean_number_sharks_caught: contains tidy data after filtering out weight data
and adjusting shark species column names

# Column names of clean data (number_sharks_caught)

Year: Year the longline was set/hauled <dbl>
Month: Month the longline was set/hauled <dbl>
Flag: Flag of the country owning the longline <chr>
Latitude: Latitude of the center of the 5°x5° cell <dbl>
Longitude: Longitude of the center of the 5°x5° cell <dbl>
Hooks: Number of hooks set <dbl>

#Remaining columns contain retained number of sharks broken down by species

Blue <dbl>
Blacktip <dbl>
Silky <dbl>
Mako <dbl>
Oceanic_whitetip <dbl>
Shortfin_mako <dbl>
Hammerhead <dbl>
Thresher <dbl>
Requiem: unidentified sharks belonging to family Carcharhinidae <dbl>
Miscellaneous_species: unidentified sharks which may include an extensive 
list of species detailed in the metadata <dbl>


