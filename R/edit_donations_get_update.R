


edit_donations_get_update <- function(ori_dn_table, edt_dn_table, con){
  
  # Find values that were edited
  diff_cols <- diff_values(ori_dn_table, edt_dn_table)
  
  
  if(length(diff_cols) > 0){
    # Prepare updating query
    donation_id <- ori_dn_table$Id[1]
    cols_to_alter <- names(diff_cols)
    vals_to_alter <- as.vector(diff_cols)
    
    # TODO finish query
    print("Finish editing query in edit_donations_get_update")
    dn_update_query_base <- "UPDATE INTO donations WHERE Id = ?donation_id ;"
    dn_update_query <- sqlInterpolate(
      con,
      dn_update_query_base,
      donation_id = donation_id
    )
    
    
  } else {
    dn_update_query <- ""
  }
  
  return(dn_update_query)
}