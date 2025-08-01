#'
#'
#'
new_company_create_validate_input <- function(input){
  
  errors <- data.frame(
    field = "",
    error_msg = ""
  )
  
  # Validate fields -------------------------------------------------------
  
  # Personal info
  if(gsub(" ", "", input$company_name) == ""){
    errors <- rbind(errors, c("company_name", "Company Name required"))
  }
  
  if(gsub(" ", "", input$company_poc_fname) == ""){
    errors <- rbind(errors, c("company_poc_fname", "First Name required"))
  }
  
  if(gsub(" ", "", input$company_poc_lname) == ""){
    errors <- rbind(errors, c("company_poc_lname", "Last Name required"))
  }
  
  # Contact info
  company_num <- gsub(" ", "", input$company_poc_phone)
  if(company_num == ""){
    errors <- rbind(errors, c("company_poc_phone", "Phone required"))
  } else if(!grepl("[(][0-9]{3}[)][0-9]{3}[-][0-9]{4}", company_num)){
    errors <- rbind(errors, c("company_poc_phone", "Incerrect Phone format"))
  }
  
  if(input$company_poc_email == ""){
    errors <- rbind(errors, c("company_poc_email", "Email required"))
  } else if(!grepl(".+[@][a-zA-Z]+[.][a-zA-Z]+$", input$company_poc_email)){
    errors <- rbind(errors, c("company_poc_email", "Incerrect Email format"))
  }
  
  if(gsub(" ", "", input$company_poc_dep) == ""){
    errors <- rbind(errors, c("company_poc_dep", "Department required"))
  }
  
  
  # Remove dummy row
  errors <- errors[-1,]
  
  if(nrow(errors) > 0){
    return(list(
      valid = FALSE,
      errors = errors
    ))
  } else {
    return(list(
      valid = TRUE
    ))
  }
  
}

### Be kind to everyone ###
