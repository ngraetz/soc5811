###########################################################################################################
## Assignment 1
library(tidyverse)  ## Functions for dealing with tabular data.
library(data.table) ## Functions for dealing with tabular data.
library(ggplot2)    ## Functions for data visualization.
library(tidycensus) ## Functions for loading aggregate Census data directly from the Census website.
library(tigris)     ## Functions for loading shapefiles directly from the Census website.
library(sf)         ## Functions for shapefiles
###########################################################################################################

## First, let's load microdata from the 2018-2023 American Community Survey (ACS) for Minneapolis.
##    - I'm loading this directly from Github; on the class Github page, you can navigate to the "data" folder and click
##      on the specific dataset we are using here. You can then click the "Raw" button over on the right; once redirected,
##      copy the URL to the dataset and read it directly from there.
##    - Alternatively, you can simply download the dataset and then provide the filepath to where the data is stored
##      on your local computer. 
msp_micro <- fread('https://raw.githubusercontent.com/ngraetz/soc5811/refs/heads/main/data/acs2023_hennepin.csv')

## 1. Look at the first 10 rows in the dataset. 

## 2. What type of variable is household income? 

## 3. What is the mean household income across all individuals in the dataset?

## 4. What is the median household income across all individuals in the dataset?

## 5. Make a histogram of median household income across all individuals in the dataset. 

## 6. What kind of variable is educational attainment?

## 7. What is the most common level of educational attainment across all individuals in the dataset?

## 8. What proportion of individuals have 4 years or more of college education?

## 9. Make a bar chart of educational attainment across all individuals in the dataset. 

## Second, let's load aggregate data from the 2018-2023 American Community Survey (ACS). 
## for all neighborhoods (i.e., Census tracts) in Hennepin County, Minnesota. 
##    - Here we are loading data directly from the Census website using the get_acs() function from a very 
##      useful package called "tidycensus." 
##    - Median household income is called "estimate" in this dataset and each row is a neighborhood (i.e., Census tract). 
msp_tracts <- get_acs(geography = 'tract', 
                      variables = 'B19013_001', ## This is the code for median income; you can look up different codes using load_variables() from tidycensus
                      state='MN', 
                      county = 'Hennepin')

## 10. How many Census tracts are there in Hennepin county?

## 11. How many Census tracts have a median household income greater than or equal to $100,000? 

## 12. Make a histogram of median household income across all neighborhoods in the dataset. 

## No assignment questions below - but here is an example of how to make a map with our aggregate neighborhood-level data!
## Use get_acs() again, but include the geometry=TRUE argument to load as a shapefile. 
msp_tracts_shapefile <- get_acs(geography = "tract",
                                variables = "B19013_001",
                                state = "MN",
                                county = "Hennepin",
                                geometry = TRUE) %>% 
  erase_water() ## This function erases bodies of water from the shapefile. 

## Plot as a map using geom_sf() from the sf package. 
ggplot(data=msp_tracts_shapefile,
       aes(fill=estimate)) + 
  geom_sf() + 
  scale_fill_viridis_c(option='inferno') + 
  labs(fill='Median household income') + 
  theme_void()

## If you want to learn more about spatial data and mapping in R, check out tidycensus here:
##    - https://walker-data.com/tidycensus/index.html
## In particular, here are examples of loading/mapping Census data: 
##    - https://walker-data.com/tidycensus/articles/spatial-data.html
  
