


new_donation_validate_input <- function(input){
  
  errors <- data.frame(
    field = "",
    error_msg = ""
  )
  
  if(length(input$donation_donor) == 0){
    errors <- rbind(errors, c("donation_donor", "Donor required"))
  } else if(input$donation_donor[1] == ""){
    errors <- rbind(errors, c("donation_donor", "Donor required"))
  }
  
  if(is.na(as.numeric(input$donation_amount))){
    errors <- rbind(errors, c("donation_amount", "Invalid Amount"))
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

