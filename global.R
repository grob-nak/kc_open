# Kindred connect v0.01
# Please, be kind.



# Setup libs --------------------------------------------------------------
library(shinydashboard)
library(shiny)
library(shinyjs)

library(stringr)
library(rebus)

library(DBI)

library(DT)

# Called via namespace
# library(RSQLite)
# library(openssl)
# library(dplyr)


# Source aux files --------------------------------------------------------
r_aux_files <- list.files(path = "R",  pattern = "[.][rR]$")

invisible(sapply(
  X = file.path("R", r_aux_files),
  FUN = source
))


# JS custom functions -----------------------------------------------------
jscode <- "
shinyjs.collapse = function(boxid) {
$('#' + boxid).closest('.box').find('[data-widget=collapse]').click();
}
"


# Config connection to SQLite ---------------------------------------------
SQL_CON <- dbConnect(RSQLite::SQLite(), ":memory:")

if(!"users" %in% dbListTables(SQL_CON)){
  # Read user tables to memory
  user_table <- read.csv("data/user_table.csv")
  dbWriteTable(SQL_CON, "users", user_table)
  
  # Read mock tables
  db_create_tables(SQL_CON)
  
}




### Be kind to everyone ###
