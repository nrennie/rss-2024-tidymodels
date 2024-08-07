
# Load R packages ---------------------------------------------------------

library(openintro)
library(dplyr)
library(tidymodels)
tidymodels_prefer()


# Load data ---------------------------------------------------------------

View(resume)

resume_model_data <- resume |> 
  mutate(job_ad_id = factor(job_ad_id))


# Split into training and testing -----------------------------------------

set.seed(20240904)
resume_split <- initial_split(resume_model_data, prop = 0.8)
resume_train <- training(resume_split)
resume_test <- testing(resume_split)

# Create cross validation folds
hf_folds <- vfold_cv(resume_train, v = 10)

# Build a recipe ----------------------------------------------------------

resume_recipe <- recipe(received_callback ~ ., data = resume_train)

wf <- workflow() |> 
  add_recipe(resume_recipe)
