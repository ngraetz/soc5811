###########################################################################################################
## Assignment 1
library(tidyverse)  ## Functions for dealing with tabular data.
library(data.table) ## Functions for dealing with tabular data.
library(ggplot2)    ## Functions for data visualization.
library(tidycensus) ## Functions for loading aggregate Census data directly from the Census website.
library(tigris)     ## Functions for loading shapefiles directly from the Census website.
library(sf)         ## Functions for shapefiles
library(marginaleffects) ## Functions for making predictions
###########################################################################################################

## We will work with some data from the Panel Study of Income Dynamics (PSID), longest running longitudinal household survey in the world.
## Beginning in 1968 with 5,000 families, the PSID has since followed individuals across generations and collects survey data every two years. 
## In this cleaned version of some of the PSID variables, each row is a grandchild (g3_*) who we have attached to some variables from their
## parents (g2_*) and their grandparents (g1_*). 
psid <- fread('https://raw.githubusercontent.com/ngraetz/soc5811/refs/heads/main/data/psid.csv')

## 1. Multivariable regression: 
##    Let's examine the intergenerational transmission of educational attainment; that is, the association between 
##    grandparent's highest level of attainment (g1_edu_years) and grandchildren's attainment (g3_edu_years). Let's also control for
##    grandparent's home value in estimating this association in this model, and all models below. 
##    Fit a regression model predicting g3_edu_years as function of g3_edu_years, controlling for grandparent's home value (g1_house_value), and 
##    interpret the fitted coefficient for g1_edu_years in words.
##    We can use the following code from marginaleffects to make easy plots of predictions (replace "mod" with what you call your model object below):
##    plot_predictions(mod, condition = 'g1_edu_years')

## 2. Interaction: categorical * continuous
##    Now use an interaction term to test whether the association we interpreted above varies by grandparent race (g1_race), which takes on levels 
##    "white" and "black" in our data. Interpret the relevant coefficient in words.
##    We can use the following code from marginaleffects to make easy plots of predictions (replace "mod" with what you call your model object below):
##    plot_predictions(mod, condition = c('g1_edu_years','g1_race'))

## 3. Interaction: continuous * continuous
##    Test whether the association between grandparent's home value percentile (g1_house_value_percentile) and grandchildren's home value percentile
##    (g3_house_value_percentile) varies by grandparent's educational attainment (g1_edu_years). Interpret the relevant coefficient in words.
##    We can use the following code from marginaleffects to make easy plots of predictions (replace "mod" with what you call your model object below):
##    plot_predictions(mod, condition = c('g1_house_value_percentile','g1_edu_years')) 

