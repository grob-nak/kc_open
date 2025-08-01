#'
#'
#'
new_event_clean <- function(){
  
  updateTextInput(
    inputId = "raffle_name", value = ""
  )
  
  updateDateInput(
    inputId = "raffle_start", value = Sys.Date()
  )
  
  updateDateInput(
    inputId = "raffle_end", value = Sys.Date()
  )
  
}