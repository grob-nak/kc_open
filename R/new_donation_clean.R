#'
#'
#'
new_donation_clean <- function(output){
  
  updateSelectInput(
    inputId = "donation_donor", selected = ""
  )
  
  updateTextInput(
    inputId = "donation_category", value = ""
  )
  
  updateTextInput(
    inputId = "donation_amount", value = ""
  )
  
  
  new_donation_clean_err(output)
  
}

  