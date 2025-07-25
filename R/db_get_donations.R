
db_get_donations <- function(con){
  
  donors_table <- dbGetQuery(con, "SELECT * FROM donations")
  return(donors_table)
}