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
###########################################################################################################

## Let's load data from the 2021 General Social Survey (GSS). For five decades, the General Social Survey 
## has studied the growing complexity of American society. It is the only full-probability, personal-interview 
## survey designed to monitor changes in both social characteristics and attitudes currently being conducted 
## in the United States.
gss <- read_parquet('https://github.com/ngraetz/soc5811/raw/refs/heads/main/data/FinalProjectData/GSS%202021/GSS2021.parquet')

## On the course website, take a look at the codebook for the GSS in "../FinalProjectData/GSS 2021/GSS 2021 Codebook.pdf."
## There are many, many variables in here - a great option for your final project would be to pick a relationship
## to study from these variables, such as the one we'll use for this assignment below.

## 1) Let's take a look at the following question: "We hear a lot of talk these days about liberals and 
##    conservatives. I'm going to show you a seven-point scale on which the political views that people 
##    might hold are arranged from extremely liberal--point 1--to extremely conservative--point 7. Where 
##    would you place yourself on this scale?" We'll refer to this as the "conservative scale" for short.
##    Responses are recorded in variable "polviews". Make a histogram of this variable. What is the most 
##    common (or modal) response? What is the average response?

## 2) Let's next examine this question: "To what extent do you consider yourself a religious person?
##    Are you very religious, moderately religious, slightly religious, or not religious at all?"
##    Responses are recorded in variable "relpersn". Make a histogram of this variable. What is the 
##    most common (or modal) response? What is the average response? Note that 1 = very religious and
##    4 = not religious at all. To avoid confusion, let's flip the scale so that 4 = very religious, etc.
##    We'll then refer to this as the "religious scale" for short. 
gss <- gss %>% 
  mutate(conservative=recode(as.numeric(relpersn),
                             `1`=4,
                             `2`=3,
                             `3`=2,
                             `4`=1))

## 3) Though both variables above are based on scales with a discrete number of responses, let's treat 
##    both as continuous variables for this question and all following questions. What is the association
##    between religious identification and liberal/conservative identification? State this in the following
##    terms: "I [do/don't] find evidence of a statistically significant relationship between religious
##    identification and political identification ([p-value]). A one unit increase in the religious scale 
##    is associated with a [coefficient] unit increase in the conservative scale." 

## 4) It's possible that age is a confounder of this relationship; in other words, if we are truly interested
##    in isolating the effect of religious identification on conservative identification, our estimate association
##    will be biased if age affects both religious identification and conservative identification. Add age to the model
##    (the variable is called "age") and interpret our target association again, in similar terms as above.

## 5) It's possible that our target association is not simply confounded by age, but the effect also varies by age
##    (i.e., age acts as a "moderator" of our target relationship). Fit the same model, but include an interaction term
##    for religious identification and age. Interpret the main effect for religious identification in words. 

## 6) Let's shift our age variable so that 0 = the average age. We can use the scale() function to do this easily.
##    Fit the model again using this new "age_centered" variable instead of the raw "age" variable. Interpret the
##    main effect for religious identification in words, as we did in the previous question.
gss <- gss %>%
  mutate(age_centered=scale(age))

## 7) Interpret the interaction term from our model in the previous question, where we are interacting conservative*age_centered.
##    State this in the following terms: "The association between religious identification [increases/decreases] by [coefficient]
##    for every standard deviation increase in age. We find that this interaction [is/isn't] statistically significant ([p-value])."

## 8) Can you think of other possible confounders of our target relationship between religious identification and conservative identification?
##    Don't worry about trying to find a variable capturing these in the GSS, just think of one or two possibilities.

