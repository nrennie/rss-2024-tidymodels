
# Load {tidymodels} -------------------------------------------------------

library(tidymodels)
tidymodels_prefer()


# Split into training and testing -----------------------------------------
# Choose your own proportion for the split!

set.seed(20240902)
movies_split <- initial_split(model_data, prop = 0.7)
movies_train <- training(movies_split)
movies_test <- testing(movies_split)

# Create cross validation folds
# Choose how many splits and how many repeats!
movies_folds <- vfold_cv(movies_train, v = 10, repeats = 2)


# Build a recipe ----------------------------------------------------------

# Use the `recipe()` function and the `step_*() functions`
movies_recipe <- recipe(rating ~ ., data = movies_train) |> 
  step_normalize(c(length, votes))

# create a workflow and add the recipe
movies_wf <- workflow() |> 
  add_recipe(movies_recipe)
