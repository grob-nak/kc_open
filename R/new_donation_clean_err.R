

new_donation_clean_err <- function(output){
  # Clean errors ----------------------------------------------------------
  err_fields <- c(
    "donation_donor_err",
    "donation_amount_err"
  )
  
  lapply(
    X = err_fields,
    FUN = function(x){
      output[[x]] <- renderText("")
    }
  )
}