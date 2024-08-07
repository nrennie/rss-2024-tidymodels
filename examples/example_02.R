
# Specify the model -------------------------------------------------------
# use the `logistic_reg` and `set_engine` functions
lasso_tune_spec <- logistic_reg(penalty = tune(), mixture = 1) |>
  set_engine("glmnet")


# Tune the model ----------------------------------------------------------

# Fit lots of values using `tune_grid()`
lasso_grid <- tune_grid(
  add_model(wf, lasso_tune_spec),
  resamples = smoke_folds,
  grid = grid_regular(penalty(), levels = 50)
)

# Choose the best value using `select_best()`
lasso_highest_roc_auc <- lasso_grid |>
  select_best(metric = "roc_auc")


# Fit the final model -----------------------------------------------------
# use the `finalize_workflow` function and `add_model`
final_lasso <- finalize_workflow(
  add_model(wf, lasso_tune_spec),
  lasso_highest_roc_auc
)


# Model evaluation --------------------------------------------------------
# use `last_fit()` and `collect_metrics()`
last_fit(final_lasso, smoke_split) |>
  collect_metrics()

# which variables were most important?
library(ggplot2)
final_lasso |>
  fit(smoke_train) |>
  extract_fit_parsnip() |>
  vip::vi(lambda = lasso_highest_roc_auc$penalty) |>
  mutate(
    Importance = abs(Importance),
    Variable = forcats::fct_reorder(Variable, Importance)
  ) |>
  ggplot(mapping = aes(x = Importance, y = Variable, fill = Sign)) +
  geom_col()

