###########################################################################################################
## Assignment 1
library(tidyverse)  ## Functions for dealing with tabular data.
library(data.table) ## Functions for dealing with tabular data.
library(ggplot2)    ## Functions for data visualization.
library(tidycensus) ## Functions for loading aggregate Census data directly from the Census website.
library(tigris)     ## Functions for loading shapefiles directly from the Census website.
library(sf)         ## Functions for shapefiles
###########################################################################################################

## We will work with some data from the Panel Study of Income Dynamics (PSID), longest running longitudinal household survey in the world.
## Beginning in 1968 with 5,000 families, the PSID has since followed individuals across generations and collects survey data every two years. 
## In this cleaned version of some of the PSID variables, each row is a grandchild (g3_*) who we have attached to some variables from their
## parents (g2_*) and their grandparents (g1_*). 
psid <- fread('https://raw.githubusercontent.com/ngraetz/soc5811/refs/heads/main/data/psid.csv')

## 1. Create an indicator variable with a character class (e.g., "more"/"less") for whether grandchildren had a 
##    grandparent with a high school degree or less (g1_edu_cat).

## 2. Create a density plot of grandchildren home value percentile (g3_house_value_percentile). Plot two overlapping
##    densities by assigning the "fill" aesthetic to your indicator variable above. Note that 0 = non-owner.  
##    Hint: Increase the transparency of the densities using the "alpha" argument in geom_density() (e.g., alpha=0.4). 

## 2. What is the average home value percentile of grandchildren whose parents had a high school degree or less?
##    What about grandchildren whose parents had more than a high school degree?

## 3. Is the difference between means above statistically significant? Use a linear regression model to estimate
##    a p-value for the difference between these means and state your answer in terms of the null hypothesis. 

## 4. Fit a linear regression model predicting grandchild home value percentile (g3_house_value_percentile)
##    as a function of grandparent home value percentile (g1_house_value_percentile). 

## 5. Interpret the coefficient on grandparent home value percentile.

## 6. Is this coefficient estimate statistically significant at the p<0.05 level? What is the null hypothesis
##    at which this p-value is being calculated?

## 5. We'll soon begin thinking about the final project assignment, which will be due at the end of the semester.
##    I will post several datasets that can be used for this project, but you're also free to use any data you want.
##    To help me think about which datasets might be most relevant for you, please write 2-3 sentences about what sort
##    of topics you might be interested in for your final paper. Think about characterizing the relationship between
##    two quantitative variables, but don't worry at this point whether the necessary data already exists or not.  

