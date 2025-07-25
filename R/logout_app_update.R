#' Update UI after login
#'
#' @description Update Shiny UI with menu elements after a successful login.
#'
#' @param session Shiny session.
#' @param session_values A reactiveValues object.
#' @param output Shiny output.
#' @param js Shiny javascript.
logout_app_update <- function(session, session_values, output, js){
  
  # Update sidebar menu options
  output$post_auth_menus <- renderUI({br()})
  
  # Update login tab
  ## Clean login info box
  output$login_status_window <- renderUI({br()})
  
  ## Show login box
  js$collapse("login_box")
  
  ## Clean login auth form
  updateTextInput(session = session, inputId = "username", value = "")
  updateTextInput(session = session, inputId = "user_pwd", value = "")
  output$login_message <- renderText("")
  
  return(NULL)
}

### Be kind to everyone ###