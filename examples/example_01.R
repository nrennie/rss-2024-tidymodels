
# Load R packages ---------------------------------------------------------

library(openintro)
library(dplyr)
library(tidymodels)
tidymodels_prefer()


# Load data ---------------------------------------------------------------

View(smoking)

smoke_model_data <- smoking |> 
  select(-c(amt_weekends, amt_weekdays, type)) |> 
  mutate(smoke = if_else(smoke == "Yes", 1, 0))


# Split into training and testing -----------------------------------------

set.seed(20240904)
smoke_split <- initial_split(smoke_model_data)
smoke_train <- training(smoke_split)
smoke_test <- testing(smoke_split)

# choose a different split proportion?
set.seed(20240904)
smoke_split <- initial_split(smoke_model_data, prop = 0.8)
smoke_train <- training(smoke_split)
smoke_test <- testing(smoke_split)

# Create cross validation folds
hf_folds <- vfold_cv(smoke_train, v = 10)

# Build a recipe ----------------------------------------------------------

smoke_recipe <- recipe(smoke ~ ., data = smoke_train) |> 
  step_normalize(age)

wf <- workflow() |> 
  add_recipe(smoke_recipe)
