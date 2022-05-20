# simulation script for ADS thesis
# original script by Hanne Oberman

########################
### SETUP SIMULATION ###
########################

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
n_sim <- 2
n_obs <- 200
betas <- c(-0.5, -0.1, 0.1, 0.5)
mis_mech = c("MCAR", "MAR")
mis_prop = c(0.1, 0.25, 0.5)

#################################
### TEST LOWER LEVEL FUCTIONS ###
#################################

# generate data
dat <- generate_complete(n_obs, betas)

# ampute data
amps <- induce_missingness(dat, mis_mech = "MAR", mis_prop = 0.5)

# apply complete case analysis
CCA <- apply_CCA(amps[[1]])

# impute data with MICE
MICE <- apply_MICE(amps[[1]])

# impute data with python
### [YOUR FUNCTION HERE] ###

# evaluate estimates

##################################
### TEST HIGHER LEVEL FUCTIONS ###
##################################

amps <- create_data()
ests <- apply_methods(amps)

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
  ests <- apply_methods(amps)
  # output
  return(ests)
}

######################
### RUN SIMULATION ###
######################


