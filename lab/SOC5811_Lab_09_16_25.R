###################################
# Lab #2
# Hyunjae Kwon
# 09/16/25
###################################

# ----------------------------------------------------------------------
# It's good practice to load all the required packages in the beginning
library(data.table)
library(readr)
library(ggplot2)
library(readxl)
# ----------------------------------------------------------------------

# ----------------------------------------------------------------------
# (1) Understanding the logics of R
# (1.1) arrow sign and equal sign can be used interchangeably
example <- 2 + 2
example = 2 + 2

# (1.2) what are the basic attribues of the object example?
class(example)
length(example)

# (1.3) vectors can hold more than one element.
# this is a flat vector because it is one dimensional
example <- c(4,6,7)
class(example)
length(example)

# (1.4) vectors are indexed, starting from 1
example[1]
example[2]
example[3]

# (1.5) type mismatch
example_character <- "red"
example_character

example + example_character

# Earlier, I said that the arrow signs and equal signs
# can be used interchangeably. But, in some instances,
# using the equal sign instead of the arrow sign
# can lead to results you don't want
example_data <- data.frame(
  beverages = c("espresso","latte", "cappuccino"),
  price = c(3.50, 5.75, 5.00)
)

# vs
example_data <- data.frame(
  beverages <- c("espresso","latte", "cappuccino"),
  price <- c(3.50, 5.75, 5.00)
)
# why this works differently
# when R sees this, before creating the dataframe
# because it sees the arrow signs, it stores the vectors
# to the appropriate objects. So, if you check your
# environment, you can see that beverages and price have been
# created as individual objects. R then creates a dataframe
# but data frame function does not get the information on 
# the name of the variables, only the values.

# ----------------------------------------------------------------------
# (2) Understanding tabular data

# (2.1) importing datasets into R
mmr_data <- fread("/Users/hyunjaekwon/Downloads/mmr_data.csv")
# mmr_data is a tabular data (it has rows and columns)

# (2.2) endless ways to import
# fread is the fastest
cps_2024 <- fread("/Users/hyunjaekwon/Downloads/cps_00005.csv")

# read.csv is slower because it loads the entire dataset into memory at once
# read.csv is from base R
cps_2024 <- read.csv("/Users/hyunjaekwon/Downloads/cps_00005.csv")

# read_csv is faster thaqn read.csv but slower than fread
# read_csv is from the readr pacakage
cps_2024 <- read_csv("/Users/hyunjaekwon/Downloads/cps_00005.csv")

# one year cross sectional data isn't that big in size (~23 mb)
# example of importing a big dataset (~184 mb)
# (1) fread
cps_2018_2024 <- fread("/Users/hyunjaekwon/Downloads/cps_00006.csv")

# vs (2) read.csv
cps_2018_2024 <- read.csv("/Users/hyunjaekwon/Downloads/cps_00006.csv")

# vs (3) read_csv
cps_2018_2024 <- read_csv("/Users/hyunjaekwon/Downloads/cps_00006.csv")

# ----------------------------------------------------------------------
# (3) understanding ggplot
# (3.1) example 1 - mmr data
figure1 <- ggplot(data = mmr_data,
  aes(
    x = maternal_education,
    y = mmr
  )
) + geom_point()

figure1

# (3.2) example 2 - cps data
# demonstrate the concept of outliers
figure1 <- ggplot(data = cps_2024,
                  aes(
                    x = UHRSWORKT,
                    y = INCTOT
                  )
) + geom_point()

figure1

# Going back to the point Nick made in class:
# An important part of learning R is learning 
# how to ask questions.
# Example: To do something like the line of code below,
# you can ask Google the following question:
# "How do I subset a dataframe using condition applied
# to a column using base R in R?"
cps_2024_wo_outliers <- cps_2024[cps_2024$INCTOT != 999999999 & cps_2024$INCTOT != 999999998 &
                                   cps_2024$UHRSWORKT != 997 & cps_2024$UHRSWORKT != 999,]

# (3.3) Understanding sub-setting
# dataframe[row,column]
cps_2024[1,1]
cps_2024[1,2]
cps_2024[1,3]

cps_2024_u_30000 <- cps_2024[INCTOT < 30000,]
cps_2024_u_30000[,INCTOT]

# (3.4) Understanding geoms

# example - geom_point
# What is geom_point doing here?
# Create a scatterplot with the information provided inside
# the foundational layer of your plot
figure1 <- ggplot(data = cps_2024_wo_outliers,
                  aes(
                    x = UHRSWORKT,
                    y = INCTOT
                  )) +
  geom_point()
figure1

# Technically, you don't have to define your aesthetics 
# in the first layer. You can also define your aesthetics
# in the geom function.
figure1 <- ggplot(data = cps_2024_wo_outliers) +
  geom_point(aes(x=UHRSWORKT,y=INCTOT))
figure1

# If you are graphing more than one type of graph, you
# can customize each type more easily. But, if you are 
# not looking to give different specifications to
# different types of graphs, then defining aesthetics
# this way can make it look busier than needed.
figure1 <- ggplot(data = cps_2024_wo_outliers) +
  geom_point(aes(x=UHRSWORKT,y=INCTOT)) +
  geom_line(aes(x=UHRSWORKT,y=INCTOT))
figure1

# subsetting to remove outliers in AHRSWORKT
cps_2024_wo_outliers <- cps_2024_wo_outliers[AHRSWORKT != 999,]

# example showing why defining your aesthetics
# in geom objects can be useful
figure1 <- ggplot(data = cps_2024_wo_outliers) +
  geom_point(aes(x=UHRSWORKT,y=INCTOT,color="red")) +
  geom_point(aes(x=AHRSWORKT,y=INCTOT,color="blue"))
figure1

# You want to stratify the plot by SEX
figure1 <- ggplot(data = cps_2024_wo_outliers,
                  aes(
                    x = UHRSWORKT,
                    y = INCTOT,
                    color = SEX
                  )
) + geom_point()

figure1

# (4) understanding data formats
# (4.1) There are two types of shapes: wide or long
long_data <- fread("/Users/hyunjaekwon/Downloads/ebola_fatalities_sex_country.csv")
wide_data <- dcast(long_data,
                   Country + Age ~ Gender,
                   value.var = "Deaths")

# (4.2) Formatting ggplots vary by long data vs wide data
# formatting ggplot when using long data
ggplot(data=long_data,
       aes(x=Age,
           y=Deaths,
           color=Gender)) +
  geom_point()

# formatting ggplot when using wide data
ggplot(data=wide_data) +
  geom_point(aes(x=Age, y=Female, color = "blue")) +
  geom_point(aes(x=Age, y=Male, color = "brown"))


# (n) teaser to tidyverse
# binary variable
head(cps_2024$SEX)
table(cps_2024$SEX)
unique(cps_2024$SEX)

# numerical variable
table(cps_2024$UHRSWORKT)
summary(cps_2024$UHRSWORKT)

# tidyverse is widely used for its readability
cps_2024_f <- cps_2024 %>% filter(SEX == 2)

# This does the same thing as above. But, this
# uses base R instead of tidyverse. This is telling
# R to only include observations where SEX == 2.
cps_2024_f <- cps_2024[cps_2024$SEX == 2,]


# a different dataset
# fread cannot import this becuase xlsx is compressed
# read_excel() is from "readexl" package
gss_2024 <- read_excel("/Users/hyunjaekwon/Downloads/result 2/GSS_2024.xls")

# fepresch: A preschool child is likely to suffer if his or her mother works.
figure <- ggplot(data=gss_2024,
                 aes(x=fepresch)) +
  geom_bar()
figure

# how does fepresch differ by gender
gss_2024_filtered <- gss_2024 %>%
  filter(sex != ".d:  Do not Know/Cannot Choose" &
           sex != ".n:  No answer" &
           sex != ".s:  Skipped on Web" &
           fepresch != ".d:  Do not Know/Cannot Choose" &
           fepresch != ".i:  Inapplicable" &
           fepresch != ".n:  No answer" & 
           fepresch != ".s:  Skipped on Web") %>%
  group_by(sex,fepresch) %>%
  summarise(n=n()) %>%
  mutate(N=sum(n)) %>%
  mutate(percent = n/N)
  
  
figure <- ggplot(data=gss_2024_filtered,
                 aes(x=fepresch,
                     y=percent,
                     fill=sex)) +
  geom_bar(position="dodge", stat = "identity")
figure

# explaining the basic logic of R
ex_obj <- "/Users/hyunjaekwon/Downloads/mmr_data.csv"
class(ex_obj)
length(ex_obj)

ex_df <- fread("/Users/hyunjaekwon/Downloads/mmr_data.csv")
class(ex_df)
# data.table is a subclass of data.frame
# the developers wanted to make data.table
# compatible with the rest of R

# teaser into regression
model1 <- lm(mmr ~ maternal_education, data = mmr_data)

# another type of object!
class(model1)

# attributes of this object
attributes(model1)
length(model1)

# summary of the model
summary(model1)