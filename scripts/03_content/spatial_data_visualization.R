################################################################################
# Spatial data visualization
################################################################################
#
# Katherine Polatchek
# kgp31@miami.edu
# 16 November 2025
#
# Assignment 3: Produce a map that shows a spatial aspect of your data1, and export it as a .png figure
#
################################################################################

# SET UP #######################################################################

## Load packages ---------------------------------------------------------------
library(EVR628tools)   # For fishing effort data and color palettes
library(ggspatial)     # To add map elements to a ggplot
library(rnaturalearth) # To add country outlines
library(tidyverse)     # General data wrangling
library(sf)            # Working with vector data
library(terra)         # Working with raster data
library(tidyterra)     # Working with raster data in tidy approach
library(mapview)       # To quickly inspect data

## Load data -------------------------------------------------------------------
sharks_caught_clean <- read_rds(file= "data/processed/clean_number_sharks_caught.rds")
# Load depth raster
depth <- rast("data/raw/depth_raster.tif")
# Load world's coastline
coast <- rnaturalearth::ne_countries() |> st_as_sf()
# Load EEZs
EEZ <- read_sf("data/raw/World_EEZ_v12_20231025/eez_boundaries_v12.shp")

# PROCESSING ###################################################################

## Rasterize fishing effort ----------------------------------------------------

effort_raster <- sharks_caught_clean |>
  group_by(Longitude, Latitude) |>
  summarise(effort = sum(Hooks)) |> #Used number of hooks as estimate of fishing effort because no data on soak time
  rast(crs = "EPSG:4326") # Define coordinate system

# Print raster to console
effort_raster

# Quick plot
plot(effort_raster)

# Crop EEZ vector to extent of fishing effort raster
EEZ_vect <- vect(EEZ)            # convert sf → SpatVector
EEZ_unwrapped <- unwrap(EEZ_vect)  # fix 0–360 / antimeridian
EEZ_fixed <- st_as_sf(EEZ_unwrapped)

r_bb <- st_as_sfc(st_bbox(effort_raster))
EEZ_crop <- st_crop(EEZ_fixed, r_bb) # crop EEZ vector to bounds of fishing effort raster

# Crop depth raster to extent of fishing effort raster
EPO_depth <- crop(depth, r_bb)

# Crop coastline vector to extent of fishing effort raster
sf::sf_use_s2(FALSE)
coast_crop <- st_crop(coast, r_bb)

# VISUALIZE ####################################################################

## Build plot ----------------------------------------------------------------
p1 <- ggplot() +
  geom_spatraster_contour(data= EPO_depth, # Plot depth raster using contours
                          aes(colour = after_stat(level)),
                          linewidth = 0.5) +
  geom_spatraster(data= effort_raster, na.rm = TRUE) + # Plot fishing effort raster
  geom_sf(data = EEZ_crop, fill = NA, color = "red") + # Plot EEZ vector
  geom_sf(data = coast_crop,
          fill = "gray",
          color = "black") + # Plot coastline vector
  scale_fill_viridis_c(na.value = "transparent") + # Make NA value transparent for effort raster
  scale_color_viridis_c(option = "mako") + # Scale for aesthetics
  theme_bw() + # Modify theme
  theme(
    axis.text.y = element_text(color = "black", size = 10),
    axis.ticks.y = element_line(color = "black")) +
  annotation_north_arrow(location = "tl") + # Add north arrow
  annotation_scale(location = "bl") + # Add scale bar
  labs(color = "Depth (m)",
       fill = "Effort (Number of Hooks)",
       x = "Longitude",
       y = "Latitude",
       title = "Shark longline fishing effort in the Eastern Pacific",
       caption = "Data source: IATTC")

# EXPORT #######################################################################

## The final step --------------------------------------------------------------

ggsave(filename = "results/img/shark_fishing_effort_EPO_1.png", p1, width = 10,
       height = 8, dpi = 300)
