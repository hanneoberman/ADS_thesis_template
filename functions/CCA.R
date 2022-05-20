# # complete case analysis
# apply_CCA <- function(amp) {
#   # list-wise deletion
#   est <- na.omit(amp$amp) %>% 
#     # fit regression 
#     lm(Y ~ X1 + X2 + X3 + X4, .) %>% 
#     # clean results
#     broom::tidy(conf.int = TRUE) %>% 
#     # choose estimates
#     select(term, estimate, conf.low, conf.high) %>% 
#     # add method name and missingness
#     cbind(method = "CCA", mech = amp$mech, prop = amp$prop, .) 
#   # output
#   return(est)
# }