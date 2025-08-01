
print_errors <- function(output, validation_res, show_modal = TRUE){
  
  # Display modal
  showModal(modalDialog(
    title = "Error: required fields missing.", size = "m",
    lapply(
      X = validation_res$errors$error_msg,
      FUN = function(x){
        p(x)
      })
  ))
  
  # Render error msgs in text outputs
  mapply(
    FUN = function(field, error_msg) {
      outputId <- paste0(field, "_err")
      output[[outputId]] <- renderText(error_msg)
    },
    field = validation_res$errors$field,
    error_msg = validation_res$errors$error_msg
  )
  
  
  return(NULL)
}