

db_new_donation <- function(input, con, session_values){
  
  print("TODO Adjust db_new_company_create:")
  # TODO adjust ID autoincrement
  print("TODO adjust ID autoincrement")
  
  
  max_donation_id <- dbGetQuery(con, "SELECT MAX(id) as id FROM donations")$id[1]
  donation_id <- max_donation_id + 1
  
  for(i in 1:length(input$donation_donor)){
    new_donation_query_base <- "
    INSERT INTO donations (
      Id, DonorId, RaffleId,
      DonatedAt, Value, PaymentType, Type,
      CreatedAt, CreatedBy, LoadedAt
    )
    VALUES (
      ?id, ?donor_id, ?raffle_id,
      ?donated_at, ?value, ?payment_type, ?type,
      ?created_at, ?created_by, ?loaded_at
    )
  "
    new_donation_query <- sqlInterpolate(
      con,
      new_donation_query_base,
      id = donation_id,
      donor_id = input$donation_donor[i],
      raffle_id = input$donation_raffle,
      donated_at = Sys.time(),
      value = input$donation_amount,
      payment_type = input$donation_pay_type,
      type = input$donation_category,
      created_at = Sys.time(),
      created_by = session_values$username,
      loaded_at = Sys.time()
    )
    
    res <- dbExecute(con, new_donation_query)
    
    donation_id <- donation_id + 1
  }
  
  
  return(NULL)
}