# function to generate complete data

generate_data <- function(n_obs = 200, betas = c(-0.5, -0.1, 0.1, 0.5)) {
  # create variance-covariance matrix with moderate correlations
  vcov <- matrix(0.3, nrow = 4, ncol = 4)
  diag(vcov) <- 1
  # create predictor space data
  X <- mvtnorm::rmvnorm(n = n_obs, sigma = vcov)
  # multiply each predictor observation by the corresponding beta
  Y <- X %*% betas
  # generate residual error for each observation
  e <- rnorm(n_obs)
  # combine predictors and outcome plus residual
  dat <- data.frame(
    Y = Y + e,
    X
  )
  # output
  return(dat)
}