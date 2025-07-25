#'
#'
#'
new_donor_create_validate_input <- function(input, session_values){
  
  errors <- data.frame(
    field = "",
    error_msg = ""
  )
  
  # Validate fields -------------------------------------------------------
  
  # Personal info
  if(gsub(" ", "", input$donor_fname) == ""){
    errors <- rbind(errors, c("donor_fname", "First Name required"))
  }
  
  if(gsub(" ", "", input$donor_lname) == ""){
    errors <- rbind(errors, c("donor_lname", "Last Name required"))
  }
  
  # Contact info
  donor_pnum1 <- gsub(" ", "", input$donor_pnum1)
  if(donor_pnum1 == ""){
    errors <- rbind(errors, c("donor_pnum1", "Phone required"))
  } else if(!grepl("[(][0-9]{3}[)][0-9]{3}[-][0-9]{4}", donor_pnum1)){
    errors <- rbind(errors, c("donor_pnum1", "Incerrect Phone format"))
  }
  
  if(input$donor_email1 == ""){
    errors <- rbind(errors, c("donor_email1", "Email required"))
  } else if(!grepl(".+[@][a-zA-Z]+[.][a-zA-Z]+$", input$donor_email1)){
    errors <- rbind(errors, c("donor_email1", "Incerrect Email format"))
  }
  
  # Address
  if(gsub(" ", "", input$donor_street) == ""){
    errors <- rbind(errors, c("donor_street", "Street Name required"))
  }
  
  if(gsub(" ", "", input$donor_city) == ""){
    errors <- rbind(errors, c("donor_city", "City Name required"))
  }
  
  if(gsub(" ", "", input$donor_state) == ""){
    errors <- rbind(errors, c("donor_state", "State Name required"))
  }
  
  if(gsub(" ", "", input$donor_country) == ""){
    errors <- rbind(errors, c("donor_country", "Country required"))
  }
  
  if(gsub(" ", "", input$donor_zip) == ""){
    errors <- rbind(errors, c("donor_zip", "Postal Code required"))
  }
  
  
  # Spouse info
  if(session_values$has_spouse){
    if(gsub(" ", "", input$donors_fname) == ""){
      errors <- rbind(errors, c("donors_fname", "First Name required"))
    }
    
    if(gsub(" ", "", input$donors_lname) == ""){
      errors <- rbind(errors, c("donors_lname", "Last Name required"))
    }
  }
  
  
  print(errors)
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
