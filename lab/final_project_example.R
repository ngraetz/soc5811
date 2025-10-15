########################
# Name: Hyunjae Kwon
# Title: Final Project Example
########################

# (1) Loading required packages
library(data.table)
library(tidyverse)
library(gtsummary)
library(tableone)
library(marginaleffects)

# (2) Importing dataset
# Note: you have to change the filepath below to where the
# data is located in your computer
atus <- fread("/Users/hyunjaekwon/Downloads/atus_00047.csv")

# (3) Data Cleaning
# (3.1) Creating my analytic sample
# Only interested in parents
table(atus$HH_CHILD)

# creating a sample of parents residing with a child under the age of 18
sample <- atus %>%
  # only parents residing with a child under the age of 18
  filter(HH_CHILD == 1) %>%
  # removing respondents who did not report for any of these variables
  filter(complete.cases(AGE, SEX, RACE, HISPAN, MARST, BPL, EDUC, EMPSTAT,
                        FULLPART, UHRSWORKT, KIDUND1, KID1TO2,
                        KID3TO5, KID6TO12, KID13TO17)) %>%
  # not explicitly NA
  # UHRSWORKT = 9995; usual hours worked varies
  filter(UHRSWORKT != 9995) %>%
  mutate(
    age = as.integer(AGE),
    sex = factor(SEX, levels =c(1,2), labels = c("Male","Female")),
  ) %>%
  mutate(
    race = case_when(
      RACE == 100 & HISPAN == 100 ~ "Non-Hispanic White",
      RACE == 110 & HISPAN == 100 ~ "Non-Hispanic Black",
      RACE == 120 & HISPAN == 100 ~ "American Indian, Alaskan Native",
      (RACE == 131 | RACE == 132) & HISPAN == 100 ~ "Non-Hispanic Asian",
      RACE %in% c(200,201,202,203,210,300,301,310,400,599) ~ "Multiple Races",
      HISPAN %in% c(210,220,230,241,242,243,244,250) ~ "Hispanic"
    ),
    race = as.factor(race),
    married = case_when(
      MARST %in% c(1,2) ~ "married",
      TRUE ~ "not married"
    ),
    married = as.factor(married),
    education = case_when(
      EDUC %in% c(10,11,12,13,14,15,16,17) ~ "Less than HS diploma",
      EDUC %in% c(20,21) ~ "HS diploma, no college",
      EDUC %in% c(30,31,32) ~ "Some college",
      EDUC %in% c(40,41,42,43) ~ "College degree+"
    ),
    college = case_when(
      EDUC >= 10 & EDUC <= 32 ~ "No college degree",
      EDUC >= 40 ~ "College degree"
    ),
    education = as.factor(education),
    employment = case_when(
      FULLPART == 1 ~ "Full time",
      FULLPART == 2 ~ "Part time",
      FULLPART == 99 ~ "Unemployed"
    ),
    employment = as.factor(employment),
    KIDUND1 = factor(KIDUND1, levels =c(0,1), labels = c("No","Yes")),
    KID1TO2 = factor(KID1TO2, levels =c(0,1), labels = c("No","Yes")),
    KID3TO5 = factor(KID3TO5, levels =c(0,1), labels = c("No","Yes")),
    KID6TO12 = factor(KID6TO12, levels =c(0,1), labels = c("No","Yes")),
    KID13TO17 = factor(KID13TO17, levels =c(0,1), labels = c("No","Yes"))
  )

# a quick way to check class of several variables
sapply(sample %>% select(AGE, SEX, RACE, HISPAN, MARST, BPL, EDUC, EMPSTAT,
                         FULLPART, UHRSWORKT, KIDUND1, KID1TO2,
                         KID3TO5, KID6TO12, KID13TO17), class)


# (3) Exploratory Analysis
# (3.1) Summary statistics
# (3.1.1) Time use variables
# Routine housework
summary(sample$routine_housework)
# you could also this, and you would get the same result
mean_rhw <- sample %>%
  summarise(mean = mean(routine_housework, rm.na=TRUE))

sample %>%
  ggplot(aes(x=routine_housework)) +
  geom_density(fill = "lightblue",alpha=0.7) +
  geom_vline(aes(xintercept = mean(routine_housework, rm.na=TRUE)),
             color = "red", linetype = "dashed")

# Childcare
summary(sample$childcare)
sample %>%
  summarise(mean = mean(childcare, rm.na=TRUE))

sample %>%
  ggplot(aes(x=childcare)) +
  geom_density(fill = "lightblue",alpha=0.7) +
  geom_vline(aes(xintercept = mean(childcare, rm.na=TRUE)),
             color = "red", linetype = "dashed")

dist_childcare <- sample %>%
  count(childcare) %>%
  mutate(percent = (n/sum(n))*100) %>%
  arrange(desc(percent))

# (3.1.2) Socio-demographic variables

# There are R packages that can quickly generate a descriptive table
# with a relatively short command!

descriptive <- sample %>% 
  select(routine_housework, primary_childcare, age, sex, race,
         married, education, employment,
         UHRSWORKT, KIDUND1, KID1TO2,
         KID3TO5, KID6TO12, KID13TO17)

# using "tableone" package
CreateTableOne(data = descriptive)

# using "gtsummary" package
tbl_summary(data = descriptive,
            type = all_continuous() ~ "continuous2",
            statistic = all_continuous() ~ "{mean} ({sd})")
# by gender
tbl_summary(data = descriptive,
            by = sex,
            type = all_continuous() ~ "continuous2",
            statistic = all_continuous() ~ "{mean} ({sd})")
# by college degree status
tbl_summary(data = descriptive,
            by = sex,
            type = all_continuous() ~ "continuous2",
            statistic = all_continuous() ~ "{mean} ({sd})")

# by age of child
tbl_summary(data = descriptive,
            by = KIDUND1,
            type = all_continuous() ~ "continuous2",
            statistic = all_continuous() ~ "{mean} ({sd})")

# REGRESSION Analysis
model_hw_1 <- lm(routine_housework ~ sex, data = sample)
summary(model_hw_1)

model_cc_1 <- lm(primary_childcare ~ sex, data = sample)
summary(model_cc_1)

model_hw_2 <- lm(routine_housework ~ college, data = sample)
summary(model_hw_2)

model_cc_2 <- lm(primary_childcare ~ college, data = sample)
summary(model_cc_2)

model_hw_3 <- lm(routine_housework ~ sex + college, data = sample)
summary(model_hw_3)

model_cc_3 <- lm(primary_childcare ~ sex + college, data = sample)
summary(model_cc_3)

model_hw_4 <- lm(routine_housework ~ sex*college, data = sample)
summary(model_hw_4)

plot_predictions(model_hw_4,
                 condition=c("sex","college"))

model_cc_4 <- lm(primary_childcare ~ sex*college, data = sample)
summary(model_cc_4)

plot_predictions(model_cc_4,
                 condition=c("sex","college"))





model3 <- lm(routine_housework ~ KID1TO2, data = sample)
summary(model3)

model4 <- lm(primary_childcare ~ KID1TO2, data = sample)
summary(model4)
