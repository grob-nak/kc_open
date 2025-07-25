
new_donor_create_print_err <- function(output, new_donor_val){
  
  for(i in 1:nrow(new_donor_val$errors)){
    output[[paste0(new_donor_val$errors$field[i], "_err")]] <- renderText(
      new_donor_val$errors$error_msg[i]
    )
  }
  
  return(NULL)
}