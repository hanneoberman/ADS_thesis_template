# simulation script for ADS thesis
# original script by Hanne Oberman
# use ctrl+shift+c to un-comment tests

########################
### SETUP SIMULATION ###
########################

# packages
library(dplyr)
library(mvtnorm)
library(mice)
library(miceadds)
library(purrr)
library(furrr)

# functions
miceadds::source.all("./functions")

# initialize parallel processing
plan(multisession, workers = 2)

# randomness
set.seed(1)

# parameters
n_sim <- 2
n_obs <- 200
betas <- c(-0.5, -0.1, 0.1, 0.5)
mis_mech = c("MCAR", "MAR")
mis_prop = c(0.1, 0.25, 0.5)

# #################################
# ### TEST LOWER LEVEL FUCTIONS ###
# #################################
# 
# # generate data
# dat <- generate_complete(n_obs, betas)
# 
# # ampute data
# amps <- induce_missingness(dat, mis_mech = "MAR", mis_prop = 0.5)
# 
# # apply complete case analysis
# CCA <- apply_CCA(amps[[1]])
# 
# # impute data with MICE
# MICE <- apply_MICE(amps[[1]])
# 
# # impute data with new method
# ### [YOUR FUNCTION HERE] ###
# 
# ##################################
# ### TEST HIGHER LEVEL FUCTIONS ###
# ##################################
# 
# amps <- create_data()
# ests <- apply_methods(amps, betas)

################################
### COMBINE INTO ONE FUCTION ###
################################

simulate_once <- function(n_obs, betas, mis_mech, mis_prop) {
  # generate incomplete data
  amps <- create_data(
    sample_size = n_obs,
    effects = betas,
    mechanisms = mis_mech,
    proportions = mis_prop
  )
  # estimate regression coefficients
  ests <- apply_methods(amps, betas)
  # output
  return(ests)
}

# ################################
# ### TEST SIMULATION FUNCTION ###
# ################################
# 
# ests <- simulate_once(n_obs, betas, mis_mech, mis_prop)

######################
### RUN SIMULATION ###
######################

# repeat the simulation function n_sim times
results_raw <- replicate(
  n_sim, 
  simulate_once(n_obs, betas, mis_mech, mis_prop),
  simplify = FALSE
  )
# save raw results
saveRDS(results_raw, "./Results/raw.RDS")

########################
### EVALUATE RESULTS ###
########################

# calculate bias, coverage rate and CI width
### [YOUR FUNCTION HERE] ###
performance <- evaluate_est(results_raw)

# simulation results across all conditions
performance |> 
  group_by(method) |> 
  summarise(across(c(bias, cov, ciw), mean))

# simulation results split by condition
performance |> 
  group_by(method, mech, prop) |>
  summarise(across(c(bias, cov, ciw), mean))

# simulation results split by condition and regression coefficient
performance |> 
  group_by(method, mech, prop, term) |>
  summarise(across(c(bias, cov, ciw), mean))


