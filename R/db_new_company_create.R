#'
#'
#'
db_new_company_create <- function(input, con, session_values){
  
  # Stop if not authenticated
  if(!session_values$auth){
    return(NULL)
  }
  
  
  print("TODO Adjust db_new_company_create:")
  # TODO adjust ID autoincrement
  print("TODO adjust ID autoincrement")
  # TODO verify if combination of donor name + phone exists
  print("TODO TODO verify if combination of company name + phone exists")
  
  max_company_id <- dbGetQuery(con, "SELECT MAX(id) as id FROM donors")$id[1]
  company_id <- max_company_id + 1
  
  
  new_company_query_base <- "
    INSERT INTO donors (
      Id, Type,
      Title, FirstName, LastName,
      PhoneType1, Phone1, Email1,
      CompanyName, CompanyContactNameDepartment,
      CompanyContactPhone,CompanyWebsite,
      CreatedAt, CreatedBy, LastUpdatedAt, LastUpdatedBy, LoadedAt
    )
    VALUES (
      ?id, ?type,
      ?title, ?fname, ?lname,
      ?phone_type1, ?phone1, ?email1,
      ?company_name, ?company_contact_dep,
      ?company_contact_phone, ?company_webiste,
      ?created_at, ?created_by, ?last_updated_at, ?last_updated_by, ?loaded_at
    )
  "
  new_company_query <- sqlInterpolate(
    con,
    new_company_query_base,
    id = company_id,
    type = "Company",
    title = input$company_poc_title,
    fname = input$company_poc_fname,
    lname = input$company_poc_lname,
    phone_type1 = "Main",
    phone1 = input$company_poc_phone,
    email1 = input$company_poc_email,
    company_name = input$company_name,
    company_contact_dep = input$company_poc_dep,
    company_contact_phone = input$company_poc_phone,
    company_webiste = input$company_website,
    created_at = Sys.time(),
    created_by = session_values$username,
    last_updated_at = Sys.time(),
    last_updated_by = session_values$username,
    loaded_at = Sys.time()
  )
  
  res <- dbExecute(con, new_company_query)
  
}