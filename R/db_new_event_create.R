#'
#'
#'
db_new_event_create <- function(input, con, session_values){
  
  # Stop if not authenticated
  if(!session_values$auth){
    return(NULL)
  }
  
  
  print("TODO Adjust db_new_event_create:")
  # TODO adjust ID autoincrement
  print("TODO adjust ID autoincrement")
  # TODO verify if combination of donor name + phone exists
  print("TODO TODO verify if combination of event name + date")
  
  max_event_id <- dbGetQuery(con, "SELECT MAX(id) as id FROM events")$id[1]
  event_id <- max_event_id + 1
  
  
  new_event_query_base <- "
    INSERT INTO events (
      Id, Name,
      StartedAt, EndedAt,
      CreatedAt, CreatedBy, LastUpdatedBy, LastUpdatedAt, LoadedAt
    )
    VALUES (
      ?id, ?name,
      ?start, ?end,
      ?created_at, ?created_by, ?last_updated_at, ?last_updated_by, ?loaded_at
    )
  "
  new_event_query <- sqlInterpolate(
    con,
    new_event_query_base,
    id = event_id,
    name = input$raffle_name,
    start = input$raffle_start,
    end = input$raffle_end,
    created_at = Sys.time(),
    created_by = session_values$username,
    last_updated_at = Sys.time(),
    last_updated_by = session_values$username,
    loaded_at = Sys.time()
  )
  
  res <- dbExecute(con, new_event_query)
  
}