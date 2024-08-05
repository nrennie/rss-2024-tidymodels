
# Install R packages ------------------------------------------------------

pkgs <- c(
  "tidymodels", "tidyverse", "glmnet", "vip",
  "ranger", "kernlab", "ggplot2movies"
)
install.packages(pkgs)


# Load the movies data --------------------------------------------

library(ggplot2movies)
data(movies)

model_data <- movies |> 
  # select columns
  select(rating, year, length, votes, Action:Short) |> 
  # good movies are rated more than 8
  mutate(rating = rating >= 8) |> 
  # convert binary to factors
  mutate(across(Action:Short, as.factor))


# Inspect variables -------------------------------------------------------

View(model_data)
barplot(table(model_data$rating))
barplot(table(model_data$Comedy))
hist(model_data$votes)

