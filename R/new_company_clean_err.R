#'
#'
#'
new_company_clean_err <- function(output){
  # Clean errors ----------------------------------------------------------
  err_fields <- c(
    "company_name_err",
    "company_poc_title_err",
    "company_poc_fname_err",
    "company_poc_lname_err",
    "company_poc_phone_err",
    "company_poc_email_err",
    "company_poc_dep_err"
  )
  
  lapply(
    X = err_fields,
    FUN = function(x){
      output[[x]] <- renderText("")
    }
  )
}