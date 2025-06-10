#'
#'
#'
new_donor_create <- function(input, con, session_values){
  
  # Stop if not authenticated
  if(!session_values$auth){
    return(NULL)
  }
  
  
  # TODO adjust ID autoincrement
  # TODO verify if combination of donor name + phone exists
  
  max_donor_id <- dbGetQuery(con, "SELECT MAX(id) as id FROM donors")$id[1]
  
  new_donor_query_base <- "
  INSERT INTO donors (
    Id,
    Title, FirstName, MiddleName, LastName,
    Type, PhoneType, Phone, Email,
    Street, City, State, Country, ZipCode,
    CompanyName, CompanyContactName,
    CompanyContactNameDepartment, CompanyContactPhone,
    CreatedAt, CreatedBy, LastUpdatedAt, LastUpdatedBy, LoadedAt
  )
  VALUES (
    ?id,
    ?title, ?fname, ?mname, ?lname,
    ?type, ?phone_type, ?phone, ?email,
    ?street, ?city, ?state, ?country, ?zip_code,
    ?company_name, ?company_contact_name, 
    ?company_contact_dep, ?company_contact_phone,
    ?created_at, ?created_by, ?last_updated_at, ?last_updated_by, ?loaded_at
  )
  "
  
  new_donor_query <- sqlInterpolate(
    con,
    new_donor_query_base,
    id = max_donor_id + 1,
    title = input$donor_title,
    fname = input$donor_fname,
    mname = input$donor_mname,
    lname = input$donor_lname,
    type = input$donor_type,
    phone_type = input$donor_phone_type,
    phone = input$donor_pnum,
    email = input$donor_email,
    street = input$donor_street,
    city = input$donor_city,
    state = input$donor_state,
    country = input$donor_country,
    zip_code = input$donor_zip,
    company_name = input$donor_company,
    company_contact_name = input$donor_company_poc,
    company_contact_dep = input$donor_company_dep,
    company_contact_phone = input$donor_company_phone,
    created_at = Sys.time(),
    created_by = session_values$username,
    last_updated_at = Sys.time(),
    last_updated_by = session_values$username,
    loaded_at = Sys.time()
  )
  
  res <- dbExecute(con, new_donor_query)
  
}


### Be kind to everyone ###