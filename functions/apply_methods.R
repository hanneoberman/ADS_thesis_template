# functions to apply missing data methods

# complete case analysis
apply_CCA <- function(amp) {
  # list-wise deletion
  est <- na.omit(amp$amp) %>% 
    # fit regression 
    lm(Y ~ X1 + X2 + X3 + X4, .) %>% 
    # clean results
    broom::tidy(conf.int = TRUE) %>% 
    # choose estimates
    select(term, estimate, conf.low, conf.high) %>% 
    # add method name and missingness
    cbind(method = "CCA", mech = amp$mech, prop = amp$prop, .) 
  # output
  return(est)
}

# MICE imputation
apply_MICE <- function(amp) {
  # imputation with MICE
  imp <- mice::mice(amp$amp, method = "norm")
  # fit regression on each imputation
  est <- with(imp, lm(Y ~ X1 + X2 + X3 + X4)) %>% 
    # pool results
    mice::pool() %>% 
    # clean results
    broom::tidy(conf.int = TRUE) %>% 
    # select estimates
    select(term, estimate, conf.low, conf.high) %>% 
    # add method name
    cbind(method = "MICE", mech = amp$mech, prop = amp$prop, .)
  # output
  return(est)
}

# Python imputation
### [YOUR FUNCTION HERE] ###


