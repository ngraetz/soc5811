###########################################################################################################
## Assignment 1
library(tidyverse)  ## Functions for dealing with tabular data.
library(data.table) ## Functions for dealing with tabular data.
library(ggplot2)    ## Functions for data visualization.
library(tidycensus) ## Functions for loading aggregate Census data directly from the Census website.
library(tigris)     ## Functions for loading shapefiles directly from the Census website.
library(sf)         ## Functions for shapefiles
library(marginaleffects) ## Functions for making predictions
library(arrow)      ## Functions for loading compressed .parquet files
library(haven)      ## Functions for dealing with labelled variables
library(fixest)     ## Functions for fast estimation of fixed effects models
###########################################################################################################

## Let's load some panel data on 2007-2016 bilateral European trade extracted from Eurostat.
## The panel data are long on our unit of analysis (origin country) and time (year).
## We are interested in estimating the association between geographic distance and
## trade volume.
data(trade)
head(trade)

## 1) Fixed effects: Unit
## Let's use feols() to estimate a model predicting trade volume ("Euros") using distance between origin
## and destination countries ("dist_km") with a fixed effect for our unit of analysis ("Origin").
## Let's also include a fixed effect for product ("Product"), which is the same as including it in the
## model as a categorical variable (but using fixed effects is faster if we don't care about the Product
## coefficients).
trade %>%
  feols(Euros~dist_km | Origin+Product)
## Interpret the coefficient on our target variable: dist_km. 



## 2) Why would we use fixed effects for Origin and Product? How do these change the interpretation of 
## our target research question: the relationship between the distance between two counties and the volume
## of trade between those countries? In other words, what alternative explanations are we ruling out with 
## these fixed effects? 



## 3) Fixed effects: Unit and time
## Let's fit the same model, but add more fixed effects for the destination country ("Destination") and
## the year ("Year"). 
trade %>% 
  feols(Euros~dist_km | Origin+Product+Destination+Year)
## Why would we use fixed effects for Destination and Year? How do these change the interpretation of 
## our target research question: the relationship between the distance between two counties and the volume
## of trade between those countries? In other words, what alternative explanations are we ruling out with 
## these fixed effects? 



## Note: This model specification is called a "gravity model" in macroeconomics and is used as the baseline
## model specification for exploring predictors of bilateral trade and migration flows between countries. 

## 3) We have some flexibility on topics for our last few weeks of class. Are there any 
## particular topics you'd like to cover? These can be topics we have already covered for any reason
## (still confused, or just want some more practice/review) or topics you'd like to learn more
## about (fixed effects, causal inference, etc.). This question is optional and is not part
## of your completion grade on this assignment!
