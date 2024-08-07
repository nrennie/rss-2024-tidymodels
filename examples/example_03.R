set.seed(20240904)

# Specify model -----------------------------------------------------------

rf_tune_spec <- rand_forest(
  mtry = tune(),
  trees = 100,
  min_n = tune()
) |>
  set_mode("classification") |>
  set_engine("ranger")

# Tune hyperparameters ----------------------------------------------------

rf_grid <- tune_grid(
  add_model(wf, rf_tune_spec),
  resamples = smoke_folds,
  grid = grid_regular(mtry(range = c(5, 10)), # smaller ranges will run quicker
                      min_n(range = c(2, 25)),
                      levels = 3)
)

# Fit model ---------------------------------------------------------------

rf_highest_roc_auc <- rf_grid |>
  select_best(metric = "roc_auc")

final_rf <- finalize_workflow(
  add_model(wf, rf_tune_spec),
  rf_highest_roc_auc
)

# Evaluate ----------------------------------------------------------------

last_fit(final_rf, smoke_split) |>
  collect_metrics()
