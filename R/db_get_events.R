db_get_events <- function(con){
  
  events_table <- dbGetQuery(con, "SELECT * FROM events")
  return(events_table)
}