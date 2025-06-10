#' Update UI with login fail status
#'
#' @param output Shiny server output object.
#' @param auth_res The result from the server authentication.
login_fail <- function(output, auth_res){
  
  if(auth_res$message == "no_user" | auth_res$message == "wrong_pwd"){
    login_message <- "Incorrect user / password combination."
  } else if(auth_res$message == "internal_error"){
    login_message <- "Internal server error. Please, try again."
  } else {
    login_message <- "Unexpected error."
  }
  
  
  output$login_message <- renderText(paste0("Error: ", login_message))
  
}

### Be kind to everyone ###