#'
#'
#'
new_donor_clean_err <- function(session_values, output){
  # Clean errors ----------------------------------------------------------
  err_fields <- c(
    "donor_fname_err",
    "donor_lname_err",
    "donor_pnum1_err",
    "donor_email1_err",
    "donor_street_err",
    "donor_city_err",
    "donor_state_err",
    "donor_country_err",
    "donor_zip_err",
    "donors_fname_err",
    "donors_lname_err"
  )
  
  if(session_values$has_spouse){
    err_fields <- c(
      err_fields,
      "donors_fname_err",
      "donors_lname_err"
    )
  }
  
  
  
  lapply(
    X = err_fields,
    FUN = function(x){
      output[[x]] <- renderText("")
    }
  )
}