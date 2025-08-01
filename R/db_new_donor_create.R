#'
#'
#'
db_new_donor_create <- function(input, con, session_values){
  
  # Stop if not authenticated
  if(!session_values$auth){
    return(NULL)
  }
  
  
  print("TODO Adjust new_donor_create:")
  # TODO adjust ID autoincrement
  print("TODO adjust ID autoincrement")
  # TODO verify if combination of donor name + phone exists
  print("TODO TODO verify if combination of donor name + phone exists")
  
  max_donor_id <- dbGetQuery(con, "SELECT MAX(id) as id FROM donors")$id[1]
  donor_id <- max_donor_id + 1
  
  
  if(session_values$has_spouse){

    # Has spouse - Create main donor --------------------------------------
    spouse_id <- donor_id + 1
    
    new_donor_query_base <- "
    INSERT INTO donors (
      Id, Type,
      Title, FirstName, MiddleName, LastName,
      PhoneType1, Phone1, PhoneType2, Phone2, PhoneType3, Phone3,
      Email1, Email2,
      CompanyName, CompanyContactName,
      CompanyContactNameDepartment, CompanyContactPhone,
      Street1, City1, State1, Country1, ZipCode1,
      Street2, City2, State2, Country2, ZipCode2,
      SpouseID,
      CreatedAt, CreatedBy, LastUpdatedAt, LastUpdatedBy, LoadedAt
    )
    VALUES (
      ?id, ?type,
      ?title, ?fname, ?mname, ?lname,
      ?phone_type1, ?phone1, ?phone_type2, ?phone2, ?phone_type3, ?phone3,
      ?email1, ?email2,
      ?company_name, ?company_contact_name, 
      ?company_contact_dep, ?company_contact_phone,
      ?street1, ?city1, ?state1, ?country1, ?zip_code1,
      ?street2, ?city2, ?state2, ?country2, ?zip_code2,
      ?spouse_id,
      ?created_at, ?created_by, ?last_updated_at, ?last_updated_by, ?loaded_at
    )
    "
    
    new_donor_query <- sqlInterpolate(
      con,
      new_donor_query_base,
      id = donor_id,
      title = input$donor_title,
      fname = input$donor_fname,
      mname = input$donor_mname,
      lname = input$donor_lname,
      type = "Individual",
      phone_type1 = input$donor_phone_type1,
      phone_type2 = input$donor_phone_type2,
      phone_type3 = input$donor_phone_type3,
      phone1 = input$donor_pnum1,
      phone2 = input$donor_pnum2,
      phone3 = input$donor_pnum3,
      email1 = input$donor_email1,
      email2 = input$donor_email2,
      street1 = input$donor_street1,
      city1 = input$donor_city1,
      state1 = input$donor_state1,
      country1 = input$donor_country1,
      zip_code1 = input$donor_zip1,
      street2 = input$donor_street2,
      city2 = input$donor_city2,
      state2 = input$donor_state2,
      country2 = input$donor_country2,
      zip_code2 = input$donor_zip2,
      company_name = input$donor_company,
      company_contact_name = input$donor_company_poc,
      company_contact_dep = input$donor_company_dep,
      company_contact_phone = input$donor_company_phone,
      spouse_id = spouse_id,
      created_at = Sys.time(),
      created_by = session_values$username,
      last_updated_at = Sys.time(),
      last_updated_by = session_values$username,
      loaded_at = Sys.time()
    )
    
    res <- dbExecute(con, new_donor_query)
    
    # Has spouse - Create spouse ------------------------------------------
    if(input$donors_pnum == ""){
      spouse_phone_type <- input$donor_phone_type1
      spouse_pnum <- input$donor_pnum1
    } else {
      spouse_phone_type <- input$donors_phone_type
      spouse_pnum <- input$donors_pnum
    }
    
    if(input$donors_email == ""){
      spouse_email <- input$donor_email1
    } else {
      spouse_email <- input$donors_email
    }
    
    spouse_query_base <- "
    INSERT INTO donors (
      Id, Type,
      Title, FirstName, MiddleName, LastName,
      PhoneType1, Phone1,
      Email1, 
      Street1, City1, State1, Country1, ZipCode1,
      Street2, City2, State2, Country2, ZipCode2,
      SpouseId,
      CreatedAt, CreatedBy, LastUpdatedAt, LastUpdatedBy, LoadedAt
    )
    VALUES (
      ?id, ?type,
      ?title, ?fname, ?mname, ?lname,
      ?phone_type1, ?phone1,
      ?email1, 
      ?street1, ?city1, ?state1, ?country1, ?zip_code1,
      ?street2, ?city2, ?state2, ?country2, ?zip_code2,
      ?spouse_id,
      ?created_at, ?created_by, ?last_updated_at, ?last_updated_by, ?loaded_at
    )
    "
    
    new_spouse_query <- sqlInterpolate(
      con,
      spouse_query_base,
      id = spouse_id,
      type = "Individual",
      title = input$donors_title,
      fname = input$donors_fname,
      mname = input$donors_mname,
      lname = input$donors_lname,
      phone_type1 = spouse_phone_type,
      phone1 = spouse_pnum,
      email1 = spouse_email,
      street1 = input$donor_street1,
      city1 = input$donor_city1,
      state1 = input$donor_state1,
      country1 = input$donor_country1,
      zip_code1 = input$donor_zip1,
      street2 = input$donor_street2,
      city2 = input$donor_city2,
      state2 = input$donor_state2,
      country2 = input$donor_country2,
      zip_code2 = input$donor_zip2,
      spouse_id = donor_id,
      created_at = Sys.time(),
      created_by = session_values$username,
      last_updated_at = Sys.time(),
      last_updated_by = session_values$username,
      loaded_at = Sys.time()
    )
    
    print(new_spouse_query)
    print("Submit spouse donor query")
    res <- dbExecute(con, new_spouse_query)
    
  } else {

    # No spouse - Create donor --------------------------------------------
    new_donor_query_base <- "
    INSERT INTO donors (
      Id, Type,
      Title, FirstName, MiddleName, LastName,
      PhoneType1, Phone1, PhoneType2, Phone2, PhoneType3, Phone3,
      Email1, Email2,
      CompanyName, CompanyContactName,
      CompanyContactNameDepartment, CompanyContactPhone,
      Street1, City1, State1, Country1, ZipCode1,
      Street2, City2, State2, Country2, ZipCode2,
      CreatedAt, CreatedBy, LastUpdatedAt, LastUpdatedBy, LoadedAt
    )
    VALUES (
      ?id, ?type,
      ?title, ?fname, ?mname, ?lname,
      ?phone_type1, ?phone1, ?phone_type2, ?phone2, ?phone_type3, ?phone3,
      ?email1, ?email2,
      ?company_name, ?company_contact_name, 
      ?company_contact_dep, ?company_contact_phone,
      ?street1, ?city1, ?state1, ?country1, ?zip_code1,
      ?street2, ?city2, ?state2, ?country2, ?zip_code2,
      ?created_at, ?created_by, ?last_updated_at, ?last_updated_by, ?loaded_at
    )
    "
    
    new_donor_query <- sqlInterpolate(
      con,
      new_donor_query_base,
      id = donor_id,
      title = input$donor_title,
      fname = input$donor_fname,
      mname = input$donor_mname,
      lname = input$donor_lname,
      type = "Individual",
      phone_type1 = input$donor_phone_type1,
      phone_type2 = input$donor_phone_type2,
      phone_type3 = input$donor_phone_type3,
      phone1 = input$donor_pnum1,
      phone2 = input$donor_pnum2,
      phone3 = input$donor_pnum3,
      email1 = input$donor_email1,
      email2 = input$donor_email2,
      street1 = input$donor_street1,
      city1 = input$donor_city1,
      state1 = input$donor_state1,
      country1 = input$donor_country1,
      zip_code1 = input$donor_zip1,
      street2 = input$donor_street2,
      city2 = input$donor_city2,
      state2 = input$donor_state2,
      country2 = input$donor_country2,
      zip_code2 = input$donor_zip2,
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
    
    # print(new_donor_query)
    res <- dbExecute(con, new_donor_query)
  }
  
  
  return(donor_id)
  
}


### Be kind to everyone ###