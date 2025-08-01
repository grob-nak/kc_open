


edit_donations_get_update <- function(ori_dn_table, edt_dn_table, con){
  
  # Find values that were edited
  diff_cols <- which_diff_values(ori_dn_table, edt_dn_table)
  
  
  if(length(diff_cols) > 0){
    # Create query template for interpolations
    dn_update_query_base <- "UPDATE donations SET"
    
    update_str <- sapply(diff_cols, function(x){
      paste0(x, " = ?", x)
    })
    update_str <- paste0(update_str, collapse = ", ")
    
    dn_update_query_base2 <- paste(
      dn_update_query_base,
      update_str, "WHERE Id = ?donation_id")
    
    
    
    print(dn_update_query_base2)
    
    # Prepare updating query
    donation_id <- ori_dn_table$Id[1]
    
    val_names <- c(diff_cols, "donation_id")
    values <- c(edt_dn_table[diff_cols], donation_id)
    names(values) <- val_names
    
    dn_update_query <- sqlInterpolate(
      con,
      dn_update_query_base2,
      .dots = values
    )
    
  } else {
    dn_update_query <- ""
  }
  
  return(dn_update_query)
}