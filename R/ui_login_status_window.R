
login_status_window <- function(input, session_values){
  res_ui <- shiny::tagList(
    box(
      width = 12, status = "success", solidHeader = TRUE, title = "Logged in",
      p(paste0("Hello ", session_values$username, "! Welcome back.")),
      p("Last successful login on --- ."),
      actionButton(inputId = "logout", label = "Logout")
    )
  )
  
  return(res_ui)
}