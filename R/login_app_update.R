#' Update UI after login
#'
#' @description Update Shiny UI with menu elements after a successful login.
#'
#' @param session Shiny session.
#' @param session_values A reactiveValues object.
#' @param output Shiny output.
#' @param js Shiny javascript.
login_app_update <- function(session, session_values, output, js){
  
  # Update sidebar menu options
  output$post_auth_menus <- renderMenu(ui_sidebar_menus)
  
  
  # Update login tab
  ## Render login info box
  output$login_status_window <- renderUI({
    box(
      width = 12, status = "success", solidHeader = TRUE, title = "Logged in",
      p(paste0("Hello ", session_values$username, "! Welcome back.")),
      p("Last successful login on --- .")
    )
  })
  
  ## Hide login box
  js$collapse("login_box")
  
  ## Clean login auth form
  updateTextInput(session = session, inputId = "username", value = "")
  updateTextInput(session = session, inputId = "user_pwd", value = "")
  output$login_message <- renderText("")
  
  return(NULL)
}

### Be kind to everyone ###