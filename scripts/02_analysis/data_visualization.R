################################################################################
# Data visualization and analysis
################################################################################
#
# Katherine Polatchek
# kgp31@miami.edu
# 6 November 2025
#
# Analysis and visualization of shark catch data on longlines in the Eastern Pacific
#
################################################################################

# Load libraries
library(tidyverse)
library(patchwork)

# Load clean, processed data
sharks_caught_clean <- read_rds(file= "data/processed/clean_number_sharks_caught.rds")


# Build plot visualizing number of sharks caught per year and by country
p1 <- ggplot(data = number_sharks_caught_long,
       mapping = aes(x = Year, y = count, fill = Flag)) +
  geom_col() +
  labs(
    title = "Number of sharks caught on longlines annually in the Eastern Pacific",
    x = "Year",
    y = "Count",
    fill = "Country",
    caption = "Data Source: IATTC") +
  theme_bw() +
  theme(plot.title = element_text(size = 11)) + #Make title smaller to prevent overlap
  theme(
    legend.title = element_text(size = 10), #Make legend smaller so it looks better on combined plot
    legend.text  = element_text(size = 8),
    legend.key.size = unit(0.4, "cm"),
    legend.spacing = unit(0.1, "cm"))

# Build plot visualizing number of sharks caught per country and by species
p2 <- ggplot(data = number_sharks_caught_long,
       mapping = aes(x = species, y = Flag)) +
  geom_bin_2d() +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) + #Make x-axis labels on a 45 degree angle to prevent overlap
  labs (
    title = "Distribution of species caught per country",
    x = "Species",
    y = "Country",
    fill = "Count",
    caption = "Data Source: IATTC") +
  theme(plot.title = element_text(size = 11)) + #Make title smaller
  theme(
    legend.title = element_text(size = 10), #Make legend smaller so it looks better on combined plot
    legend.text  = element_text(size = 8),
    legend.key.size = unit(0.5, "cm"))

# Create a two panel figure using patchwork package

p3 <- p1 / p2

# Export figures

ggsave(filename = "results/img/catch_by_year_and_country.pdf", p1, width = 10,
       height = 5, dpi = 300)

ggsave(filename = "results/img/species_distribution_by_country.pdf", p2,
       width = 10, height = 5, dpi = 300)

ggsave(filename = "results/img/combined_plot.pdf", p3, width = 10, height = 8,
       dpi = 300)
