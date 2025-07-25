#'
#'
#'
new_donor_clean <- function(){
  

  # Details ---------------------------------------------------------------
  updateSelectInput(
    inputId = "donor_title", selected = ""
  )
  
  updateSelectInput(
    inputId = "donor_type", selected = ""
  )
  
  updateTextInput(
    inputId = "donor_fname", value = ""
  )
  
  updateTextInput(
    inputId = "donor_mname", value = ""
  )
  
  updateTextInput(
    inputId = "donor_lname", value = ""
  )
  

  # Donation sum ----------------------------------------------------------
  updateTextInput(
    inputId = "donor_donation_cum", value = ""
  )
  

  # Contact Info ----------------------------------------------------------
  updateSelectInput(
    inputId = "donor_phone_type1", selected = ""
  )
  
  updateSelectInput(
    inputId = "donor_phone_type2", selected = ""
  )
  
  updateSelectInput(
    inputId = "donor_phone_type3", selected = ""
  )
  
  updateTextInput(
    inputId = "donor_pnum1", value = ""
  )
  updateTextInput(
    inputId = "donor_pnum2", value = ""
  )
  updateTextInput(
    inputId = "donor_pnum3", value = ""
  )
  
  updateTextInput(
    inputId = "donor_email", value = ""
  )

  # Address ---------------------------------------------------------------
  updateTextInput(
    inputId = "donor_street", value = ""
  )
  
  updateTextInput(
    inputId = "donor_city", value = ""
  )
  
  updateTextInput(
    inputId = "donor_state", value = ""
  )
  
  updateTextInput(
    inputId = "donor_country", value = ""
  )
  
  updateTextInput(
    inputId = "donor_zip", value = ""
  )
  

  # Company Details -------------------------------------------------------
  updateTextInput(
    inputId = "donor_company", value = ""
  )
  
  updateTextInput(
    inputId = "donor_company_poc", value = ""
  )
  
  updateTextInput(
    inputId = "donor_company_phone", value = ""
  )
  
  updateTextInput(
    inputId = "donor_company_dep", value = ""
  )
  
}

### Be kind to everyone ###