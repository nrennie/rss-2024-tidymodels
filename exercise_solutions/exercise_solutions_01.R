
# Load R packages ---------------------------------------------------------

library(openintro)
library(dplyr)
library(tidyr)
library(tidymodels)
tidymodels_prefer()


# Load data ---------------------------------------------------------------

View(resume)

resume_model_data <- resume |> 
  mutate(
    across(-c(years_college, years_experience), factor)
  ) |> 
  drop_na()


# Split into training and testing -----------------------------------------

set.seed(20240904)
resume_split <- initial_split(resume_model_data, prop = 0.8)
resume_train <- training(resume_split)
resume_test <- testing(resume_split)

# Create cross validation folds
resume_folds <- vfold_cv(resume_train, v = 10)

# Build a recipe ----------------------------------------------------------

resume_recipe <- recipe(received_callback ~ ., data = resume_train) |> 
  step_dummy(all_factor_predictors())

wf <- workflow() |> 
  add_recipe(resume_recipe)
