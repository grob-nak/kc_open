#'
#'
#'
new_company_clean <- function(output){
  
  
  # Details ---------------------------------------------------------------
  updateTextInput(
    inputId = "company_name", value = ""
  )
  
  updateSelectInput(
    inputId = "company_poc_title", selected = TITLE_OPTIONS[1]
  )
  
  updateTextInput(
    inputId = "company_poc_fname", value = ""
  )
  
  updateTextInput(
    inputId = "company_poc_lname", value = ""
  )
  
  
  # Contact Info ----------------------------------------------------------
  updateTextInput(
    inputId = "company_poc_phone", value = ""
  )
  
  updateTextInput(
    inputId = "company_poc_email", value = ""
  )
  
  updateTextInput(
    inputId = "company_poc_dep", value = ""
  )
  
  updateTextInput(
    inputId = "company_website", value = ""
  )
  
  # Clean errors ----------------------------------------------------------
  new_company_clean_err(output)
  
}

### Be kind to everyone ###