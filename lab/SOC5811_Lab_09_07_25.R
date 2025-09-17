#-------------------------------------
# Author: Hyunjae Kwon
# Title: Lab 1 - 09/07/25
#-------------------------------------

#-------------------------------------
# (1) INTRODUCTION TO FUNCTIONS
# (1.1) R can be used as a calculator
5 + 7
6 * 30

# (1.2) Understanding functions
# look up sqrt() function in the Help tab
# sqrt() is a function - the portion inside the parenthesis is called
# an argument. It can also be thought of as an input.
sqrt(80)

# (1.3) Understanding the order of argument values
# default base of log function is e, which denotes natural log
log(100)
# confirm
exp(4.60517)

# you want something else besides e as the base of your log function
log(x=100, base = 10)
# confirm
10*10

# as long as you write out the argument names, the order does not matter
# same result
log(base = 10, x = 100)

# same result
log(100,10)

# different result
log(10,100)
# confirm
sqrt(100)
#-------------------------------------

#-------------------------------------
# (2) INTRODUCTION TO GGPLOT2
# ggplot2 is an essential tool for data visualization
# provides a coherent system for making data visualization
# (2.1) Installing the package
install.packages("ggplot2")
library(ggplot2)

#-------------------------------------
# (2) ggplot2
library(ggplot2)
library(data.table)
mmr_data <- fread("/Users/hyunjaekwon/Downloads/mmr_data.csv")
head(mmr_data)

# explain what the aes function does
# it essentially provides R with the variables you are interested
# in visualizing
plot <- ggplot(data = mmr_data,
               aes(x=maternal_education,
                   y = ldi))

plot <- ggplot(data = mmr_data,
               aes(x=maternal_education,
                   y = ldi))

plot = ggplot(data = mmr_data,
               aes(x=maternal_education,
                   y = ldi))

# maybe you want to see how the relationship between
# maternal education and ldi varies by region
# you can either use color (border color) or fill (fill color)
plot <- ggplot(data = mmr_data,
               aes(x=maternal_education,
                   y = ldi,
                   color = super_region_name)

# you also want each unique region to be represented by a unique shape
# in addition to color, you can specifiy shape in aes
plot <- ggplot(data = mmr_data,
               aes(x=maternal_education,
                   y = ldi,
                   color = super_region_name,
                   shape = super_region_name))

# maybe you want 

# By setting the aes function, now you gave R the core information
# Now, you have to tell R what kind of visualization you want
# There are many options, from bar plots, line graphs, etc.

# scatterplot example #1
plot <- ggplot(data = mmr_data,
               aes(x=maternal_education,
                   y = ldi)) +
  geom_point()
plot

# scatterplot example #2
plot <- ggplot(data = mmr_data,
               aes(x=maternal_education,
                   y = ldi,
                   color = super_region_name)) +
  geom_point()
plot

plot <- ggplot(data = mmr_data,
               aes(x=maternal_education,
                   y = ldi,
                   color = super_region_name))
plot + geom_point()

# scatterplot example #3
plot <- ggplot(data = mmr_data,
               aes(x=maternal_education,
                   y = ldi,
                   color = super_region_name,
                   shape = super_region_name)) +
  geom_point(size=4)
plot

# you can add more than one figure type
# if you specify more than one geom, it layers them on top of each other
plot <- ggplot(data = mmr_data,aes(x = maternal_education,
                                   y = ldi)) +
  geom_point(size=3,color='red') +
  geom_line(lwd=1)
plot

# order matters!
plot <- ggplot(data = mmr_data,aes(x = maternal_education,
                                   y = ldi)) +
  geom_line(lwd=1) +
  geom_point(size=3,color='red')
plot

# aesthetic arguments can also be provided directly
# in geom function
# alpha = 0.5 (50% transparent)
plot <- ggplot(data = mmr_data,
               aes(x = maternal_education,
                  y = ldi)) +
  geom_point(color = 'red',
             size = 2,
             alpha = .5)
plot

# FACETS
# compare A (without facets) and B (with facets)
# A
A <- ggplot(data = mmr_data,
               aes(x = maternal_education,
                   y = ldi,
                   color = super_region_name)) +
  geom_point()
A

# facet_wrap stratifies by the group specified
# in the function
B <- ggplot(data = mmr_data,
               aes(x = maternal_education,
                   y = ldi)) +
  geom_point() +
  facet_wrap(vars(super_region_name))
B


# there are 2 types of facets: facet_wrap and facet_grid
plot <- ggplot(data = mmr_data,
            aes(x = maternal_education,
                y = ldi)) +
  geom_point() +
  facet_wrap(~super_region_name,
             nrow = 3,
             ncol = 2)
plot

# facet_grid forms a grid of panels based on row and
# column facetting variables
plot <- ggplot(data = mmr_data,
            aes(x = maternal_education,
                y = ldi)) +
  geom_point() +
  facet_grid(rows=vars(super_region_name))
plot

plot <- ggplot(data = mmr_data,
            aes(x = maternal_education,
                y = ldi)) +
  geom_point() +
  facet_grid(cols=vars(super_region_name))
plot

plot <- ggplot(data = mmr_data,
            aes(x = maternal_education,
                y = ldi)) +
  geom_point() +
  facet_grid(rows=vars(region_name),
             cols=vars(super_region_name))
plot

A <- ggplot(data = mmr_data,
            aes(x = maternal_education,
                y = ldi)) +
  geom_point() +
  facet_wrap(vars(region_name, super_region_name))
A

# POSITIONS
# adds a small, random amount of noise to the position
# of points in a plot
plot <- ggplot(data = mmr_data,
               aes(x = maternal_education,
                   y = ldi)) +
  geom_point(position="jitter")
plot

# example: barplot
# barplot is particularly useful for
# looking at frequency or count 
# stacked barplot is the default
mmr_data$category <- cut(mmr_data$maternal_education,
                         breaks = c(0,3,6,9,12,Inf))

plot <- ggplot(data = mmr_data,
               aes(x = category,
                   fill = super_region_name)) +
  geom_bar()
plot

# side by side barplot
plot <- ggplot(data = mmr_data,
               aes(x = category,
                   fill = super_region_name)) +
  geom_bar(position="dodge")
plot

# y-axis becomes percentage
# each barplot indicates the distribution of
# super region names in percentage
# all bars stop at 1
plot <- ggplot(data = mmr_data,
               aes(x = category,
                   fill = super_region_name)) +
  geom_bar(position="fill")
plot

# SCALES
# control the deatils of aesthetic mapping
# EXAMPLE 1
# in this example, you tell ggplot that you want
# unique super region groups to be represented by
# unique colors
# you can scale to choose specific colors you want
# you need to provide the exact number of super region groups
plot <- ggplot(data = mmr_data,aes(x = maternal_education,
                                   y = ldi,
                                   color = super_region_name)) +
  geom_point() +
  scale_color_manual(values = c('red','yellow',
                                'blue', 'green',
                                'purple','#31a354'))
plot

# scale_* function is available for different grouping options
# EXAMPLE 2
plot <- ggplot(data = mmr_data,
               aes(x = category,
                   fill = super_region_name)) +
  geom_bar(position="fill") +
  scale_fill_manual(values = c('red','yellow',
                               'blue', 'green',
                               'purple','#31a354'))
plot

# if you don't want to come up with colors on your own
# easier for people with coloblindness
library(viridis)

plot <- ggplot(data = mmr_data,aes(x = maternal_education,
                                  y = ldi,
                                  fill = super_region_name)) +
  geom_point(shape=21,size=5) +
  scale_fill_viridis_d()
plot

plot <- ggplot(data = mmr_data,aes(x = maternal_education,
                                   y = ldi,
                                   fill = super_region_name)) +
  geom_point(shape=21,size=5) +
  scale_fill_viridis_d(option = "plasma")
plot

# LABELS
# EXAMPLE 1
plot <- ggplot(data = mmr_data,aes(x = maternal_education,
                                   y = ldi,
                                   fill = super_region_name)) +
  geom_point(shape=21,size=5) +
  scale_fill_viridis_d() 
plot

plot <- ggplot(data = mmr_data,aes(x = maternal_education,
                                   y = ldi,
                                   fill = super_region_name)) +
  geom_point(shape=21,size=5) +
  scale_fill_viridis_d() +
  labs(title = 'Maternal Education Compared to LDI',
       y = 'LDI',
       x = 'Education',
       fill = 'GBD Super Region')
plot

# THEMES
# how should the label look vs what should the label say
# EXAMPLE 1
# adds black borders/outlines
plot <- ggplot(data = mmr_data,aes(x = maternal_education,
                                   y = ldi,
                                   fill = super_region_name)) +
  geom_point(shape=21,size=5) +
  scale_fill_viridis_d() +
  labs(title = 'Maternal Education Compared to LDI',
       y = 'LDI',
       x = 'Education',
       fill = 'GBD Super Region') +
  theme_bw()
plot

# EXAMPLE 2
# no background annotation
plot <- ggplot(data = mmr_data,aes(x = maternal_education,
                                   y = ldi,
                                   fill = super_region_name)) +
  geom_point(shape=21,size=5) +
  scale_fill_viridis_d() +
  labs(title = 'Maternal Education Compared to LDI',
       y = 'LDI',
       x = 'Education',
       fill = 'GBD Super Region') +
  theme_minimal()
plot

# EXAMPLE 3
plot <- ggplot(data = mmr_data,aes(x = maternal_education,
                                   y = ldi,
                                   fill = super_region_name)) +
  geom_point(shape=21,size=5) +
  scale_fill_viridis_d() +
  labs(title = 'Maternal Education Compared to LDI',
       y = 'LDI',
       x = 'Education',
       fill = 'GBD Super Region') +
  theme_bw() +
  theme(axis.title.x = element_text(size=16))

# RESHAPING
long_data <- fread("/Users/hyunjaekwon/Downloads/ebola_fatalities_sex_country.csv")
wide_data <- dcast(long_data,
                   Country + Age ~ Gender,
                   value.var = "Deaths")

plot <- ggplot(data = wide_data,
               aes(x = Age)) +
  geom_line(aes(y = Male), color = 'blue', lwd=1) +
  geom_line(aes(y = Female), color = 'red', lwd=1) + 
  facet_wrap(~Country) + 
  theme_bw()
plot

long_data <- melt(wide_data, 
                  id.vars = c("Country", "Age"),
                  value.name = "Deaths", 
                  variable.name = "Sex")

plot <- ggplot(data = long_data,
               aes(x = Age,
                   y = Deaths,
                   color = Sex)) +
  geom_line(lwd=1) +
  facet_wrap(~Country) + 
  theme_bw()
plot


