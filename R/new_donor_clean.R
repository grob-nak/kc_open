#'
#'
#'
new_donor_clean <- function(session_values, output){
  

  # Details ---------------------------------------------------------------
  updateSelectInput(
    inputId = "donor_title", selected = TITLE_OPTIONS[1]
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
    inputId = "donor_phone_type1", selected = TELEPHONE_TYPES[1]
  )
  
  updateSelectInput(
    inputId = "donor_phone_type2", selected = TELEPHONE_TYPES[2]
  )
  
  updateSelectInput(
    inputId = "donor_phone_type3", selected = TELEPHONE_TYPES[2]
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
  
  

  # Spouse details --------------------------------------------------------
  if(session_values$has_spouse){
    
    updateSelectInput(
      inputId = "donors_title", selected = TITLE_OPTIONS[1]
    )
    
    updateTextInput(
      inputId = "donors_fname", value = ""
    )
    
    updateTextInput(
      inputId = "donors_mname", value = ""
    )
    
    updateTextInput(
      inputId = "donors_lname", value = ""
    )
    
    updateSelectInput(
      inputId = "donors_phone_type", selected = TELEPHONE_TYPES[1]
    )
    
    updateTextInput(
      inputId = "donors_pnum", value = ""
    )
    
    updateTextInput(
      inputId = "donors_email", value = ""
    )
  }

  

  # Clean errors ----------------------------------------------------------
  new_donor_clean_err(session_values, output)
  
}

### Be kind to everyone ###