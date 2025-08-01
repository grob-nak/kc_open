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
  if(gsub(" ", "", input$donor_street1) == ""){
    errors <- rbind(errors, c("donor_street1", "Street Name required"))
  }
  
  if(gsub(" ", "", input$donor_city1) == ""){
    errors <- rbind(errors, c("donor_city1", "City Name required"))
  }
  
  if(gsub(" ", "", input$donor_state1) == ""){
    errors <- rbind(errors, c("donor_state1", "State Name required"))
  }
  
  if(gsub(" ", "", input$donor_country1) == ""){
    errors <- rbind(errors, c("donor_country1", "Country required"))
  }
  
  if(gsub(" ", "", input$donor_zip1) == ""){
    errors <- rbind(errors, c("donor_zip1", "Postal Code required"))
  }
  
  
  # Spouse info
  if(session_values$has_spouse){
    if(gsub(" ", "", input$donors_fname) == ""){
      errors <- rbind(errors, c("donors_fname", "Spouse First Name required"))
    }
    
    if(gsub(" ", "", input$donors_lname) == ""){
      errors <- rbind(errors, c("donors_lname", "Spouse Last Name required"))
    }
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
