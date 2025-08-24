db_get_events <- function(con){
  
  events_query <- "
  SELECT a.Id, a.Name, a.StartedAt, a.EndedAt,
    a.RaffleDate, a.Prize, a.IsActive,
    b.TotalAmountReceived
  FROM events AS a
  LEFT JOIN (
    SELECT raffleId, SUM(value) as TotalAmountReceived
    FROM donations
    GROUP BY raffleId
  ) AS b ON
    a.Id = b.raffleId
  "
  
  events_table <- dbGetQuery(con, events_query)
  return(events_table)
}