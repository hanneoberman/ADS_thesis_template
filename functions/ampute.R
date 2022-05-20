# ampute the complete data
ampute_data <- function(
    dat,
    mis_mech = "MCAR",
    mis_prop = 0.25
) {
  # create a list of amputed data objects 
  # for each of the mechanisms and proportions
  amps <- purrr::map(mis_mech, function(mm) {
    purrr::map(mis_prop, function(mp) {
      # ampute the data
      mice::ampute(dat, mech = mm, prop = mp) 
    }) 
  }) %>% 
    # unlist just make sure the proportions 
    # are not nested within the meachnisms
    unlist(recursive = FALSE)
  # output
  return(amps)
}