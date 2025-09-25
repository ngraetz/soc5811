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

## 1. We will be examining whether household income varies across working ages for those with a college degree.
##    Filter the data to only individuals who have a college degree or more and are working ages (25-64).
##    All questions below will be in regards to this filtered dataset.
##    Hint: educ %in% c('4 years of college','5+ years of college')
##          age %in% 25:64

## 2. Create a scatter plot of age (x) vs. hhincome (y). 

## 3. Fit the linear regression model: hhincome = B_0 + B_1(age).

## 4. What are the estimated values of the intercept (B_0) and the slope (B_1)? 

## 5. Provide an interpretation of these estimated values for both the intercept and slope.

## 6. Create a new age variable (e.g., age_shift) by shifting the age variable so that a value of 0 in our data corresponds to age 25.

## 7. Fit a new linear regression model with this age_shift variable: hhincome = B_0 + B_1(age_shift).

## 8. Provide an interpretation of the new estimated value for the intercept based on our new model.  

## 9. Based on our fitted regression model, what is the expected difference in household income between an individual aged 30 and 35?

## 10. Based on our fitted regression model, what is the expected difference in household income between an individual aged 50 and 55?

## 11. Based on our fitted regression model, predict the average household income for an individual aged 45. 


