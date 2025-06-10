db_get_donors <- function(con){
  
  donors_table <- dbGetQuery(con, "SELECT * FROM donors")
  return(donors_table)
}