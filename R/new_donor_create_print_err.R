
new_donor_create_print_err <- function(output, new_donor_val){
  
  mapply(
    FUN = function(field, error_msg) {
      outputId <- paste0(field, "_err")
      output[[outputId]] <- renderText(error_msg)
    },
    field = new_donor_val$errors$field,
    error_msg = new_donor_val$errors$error_msg
  )
  
  
  return(NULL)
}