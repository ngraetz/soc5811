###########################################################################################################
## Assignment 1
library(tidyverse)  ## Functions for dealing with tabular data.
library(data.table) ## Functions for dealing with tabular data.
library(ggplot2)    ## Functions for data visualization.
library(tidycensus) ## Functions for loading aggregate Census data directly from the Census website.
library(tigris)     ## Functions for loading shapefiles directly from the Census website.
library(sf)         ## Functions for shapefiles
###########################################################################################################

psid <- readRDS("C:/Users/ngraetz/Dropbox/Penn/papers/psid/data/imputed_input_data_oct19.RDS")
psid <- psid[[1]]
psid <- psid[[1]][[1]]
psid <- as.data.table(psid)

write.csv(all_gens, 'C:/Users/ngraetz/Dropbox/Minnesota/repos/soc5811/data/psid.csv', row.names=F)

## 1. 

all_gens[, hs_or_less := ifelse(g1_edu_cat %in% c('less_hs','hs'),'less','more')]
ggplot(data=all_gens,
       aes(x=g3_house_value_percentile,
           fill=hs_or_less)) + 
  geom_density(alpha=0.2) + 
  theme_bw()

all_gens[, mean(g3_house_value_percentile), by='hs_or_less']
  

summary(lm(g3_house_value_percentile~hs_or_less, data=all_gens))

summary(lm(g3_house_value_percentile~g1_house_value_quintile, data=all_gens))



## 2. We'll soon begin thinking about the final project assignment, which will be due at the end of the semester.
##    I will post several datasets that can be used for this project, but you're also free to use any data you want.
##    To help me think about which datasets might be most relevant for you, please write 2-3 sentences about what sort
##    of topics you might be interested in for your final paper. Think about characterizing the relationship between
##    two quantitative variables, but don't worry at this point whether the necessary data already exists or not.  

