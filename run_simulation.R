# simulation script

# packages
library(dplyr)
library(mvtnorm)
library(mice)
library(miceadds)

# functions
miceadds::source.all("./functions")

# randomness
set.seed(1)

# parameters
n_obs <- 200
betas <- c(-0.5, -0.1, 0.1, 0.5)

# generate data
generate_data(n_obs, betas)

# ampute data
ampute_data(dat)
