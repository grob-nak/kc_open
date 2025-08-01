db_create_tables <- function(con){
  
  # Donors table
  donors <- readxl::read_excel("data/mock_database.xlsx", sheet = "Donor")
  dbWriteTable(SQL_CON, "donors", donors)
  
  # Donations table
  donations <- readxl::read_excel("data/mock_database.xlsx", sheet = "Donation")
  dbWriteTable(SQL_CON, "donations", donations)
  
  # Raffles table
  raffles <- readxl::read_excel("data/mock_database.xlsx", sheet = "Events")
  dbWriteTable(SQL_CON, "events", raffles)
  
}
