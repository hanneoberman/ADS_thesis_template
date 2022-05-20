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
n_obs <- 200
betas <- c(-0.5, -0.1, 0.1, 0.5)

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
ests <- rbind(CCA, MICE)

##################################
### TEST HIGHER LEVEL FUCTIONS ###
##################################

amps <- create_data()
ests <- 

################################
### COMBINE INTO ONE FUCTION ###
################################

######################
### RUN SIMULATION ###
######################
