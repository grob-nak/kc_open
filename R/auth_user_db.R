#' Authenticate user with username and password
#' 
#' @description Authentication with username
#' 
#' @param con A connection to the user login database
#' @param username A string with the username
#' @param user_pwd User password
auth_user_db <- function(con, username, user_pwd){
  
  # TODO remove this debug
  return(list(status = TRUE, username = "admin"))
  
  username_query_base <- "SELECT * FROM users WHERE username = ?username ;"
  username_query <- sqlInterpolate(
    con,
    username_query_base,
    username = username
  )
  
  user_res <- dbGetQuery(con, username_query)
  if(nrow(user_res) == 1){
    encode_pwd <- openssl::sha256(user_pwd, key = SHA_SECRET)
    
    if(user_res$pwd[1] == encode_pwd){
      return(list(status = TRUE, username = user_res$username[1]))
    } else {
      return(list(status = FALSE, message = "wrong_pwd"))
    }
  } else if(nrow(user_res) == 0){
    return(list(status = FALSE, message = "no_user"))
  } else {
    return(list(status = FALSE, message = "internal_error"))
  }
  
}

### Be kind to everyone ###