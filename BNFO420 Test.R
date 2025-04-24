# 1. Load required packages
library(lmerTest)
library(lme4)
library(ggplot2)

# 2. Load your dataset
df <- read.csv("C:/Users/cacii/Downloads/covid_births_final_data (3).csv")

# 3. Clean and prep variables
# Convert relevant columns to factors
df$State <- as.factor(df$State)
df$State_Control <- as.character(df$State_Control)
df$State_Control[df$State_Control == "."] <- "Excluded"  # Replace "." with "Excluded"
df$State_Control <- as.factor(df$State_Control)
df$Covid_Year <- as.factor(df$Covid_Year)

df$PretermBirth_Rate <- df$Preterm_Births / df$Total_Births
df$CBirth_Rate <- df$Ceasarean_Births / df$Total_Births
df$NICUBirth_Rate <- df$Nicu_Births / df$Total_Births

# 5. Fit linear mixed model
outputTotal <- lmer(Total_Births ~ State_Control * Covid_Year + (1 | State), data = df)

outputPre <- lmer(Preterm_Births ~ State_Control * Covid_Year + (1 | State), data = df)

outputCsection <- lmer(Ceasarean_Births ~ State_Control * Covid_Year + (1 | State), data = df)

outputNicu <- lmer(Nicu_Births ~ State_Control * Covid_Year + (1 | State), data = df)
  
# 6. View model summary

summary(outputTotal)

summary(outputPre)

summary(outputCsection)

summary(outputNicu)


