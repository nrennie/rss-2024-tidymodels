
# Install R packages ------------------------------------------------------

pkgs <- c(
  "tidymodels", "tidyverse", "glmnet", "vip",
  "ranger", "openintro"
)
install.packages(pkgs)


# Load R packages ---------------------------------------------------------

library(openintro)
library(tidymodels)
tidymodels_prefer()

# Load data ---------------------------------------------------------------

# Data: resume

# Split into training and testing -----------------------------------------

# choose a different split proportion?

# Create cross validation folds

# Build a recipe ----------------------------------------------------------

# Outcome: received_callback
