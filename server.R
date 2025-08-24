# Kindred connect v0.01
# Please, be kind.



server <- function(session, input, output){
  

  # Session reactive values -----------------------------------------------
  session_values <- reactiveValues()
  
  # Login vals
  session_values$auth <- FALSE
  
  # Editable tables
  session_values$donors_table <- db_get_donors(SQL_CON)
  session_values$donors_table_updates <- character(0)
  
  session_values$donations_table <- db_get_donations(SQL_CON)
  session_values$donations_table_updates <- character(0)
  
  
  session_values$events_table <- db_get_events(SQL_CON)
  
  
  # Spouse addition
  session_values$has_spouse <- FALSE
  
  

  # Login -----------------------------------------------------------------
  observeEvent(input$submit_login,{
    # Attempt authentication with server
    auth_res <- auth_user_db(SQL_CON, input$username, input$user_pwd)
    
    if(auth_res$status){
      # Login success
      session_values$auth <- TRUE
      session_values$username <- auth_res$username
      # Update UI
      login_app_update(session, session_values, output, js)
    } else {
      # Login fail - display message
      login_fail(output, auth_res)
    }
  })

  

  # Logout ----------------------------------------------------------------
  observeEvent(input$logout,{
    # Clean vars
    session_values$auth <- FALSE
    session_values$username <- ""
    # Update UI
    logout_app_update(session, session_values, output, js)
  })
  
  
  
  
  # New donor - Individual ------------------------------------------------

  ## Donor telephone handler ----------------------------------------------
  observeEvent(input$donor_pnum1, {
    
    value <- str_match(
      input$donor_pnum1,
      capture('[0-9][0-9][0-9]') %R%
        optional(capture('[0-9][0-9][0-9]')) %R%
        optional(capture('[0-9][0-9][0-9][0-9]'))
      )
    
    
    if(str_length(value[1, 1]) == 10 & !is.na(value[1, 1])) {
      updateTextInput(
        session = session,
        "donor_pnum1",
        "Phone",
        value = str_c('(', value[1, 2], ')', ' ', value[1, 3], '-', value[1,4]) )
      
    }
  })
  
  observeEvent(input$donor_pnum2, {
    
    value <- str_match(
      input$donor_pnum2,
      capture('[0-9][0-9][0-9]') %R%
        optional(capture('[0-9][0-9][0-9]')) %R%
        optional(capture('[0-9][0-9][0-9][0-9]'))
    )
    
    
    if(str_length(value[1, 1]) == 10 & !is.na(value[1, 1])) {
      updateTextInput(
        session = session,
        "donor_pnum2",
        "Phone",
        value = str_c('(', value[1, 2], ')', ' ', value[1, 3], '-', value[1,4]) )
      
    }
  })
  
  observeEvent(input$donor_pnum3, {
    
    value <- str_match(
      input$donor_pnum3,
      capture('[0-9][0-9][0-9]') %R%
        optional(capture('[0-9][0-9][0-9]')) %R%
        optional(capture('[0-9][0-9][0-9][0-9]'))
    )
    
    
    if(str_length(value[1, 1]) == 10 & !is.na(value[1, 1])) {
      updateTextInput(
        session = session,
        "donor_pnum3",
        "Phone",
        value = str_c('(', value[1, 2], ')', ' ', value[1, 3], '-', value[1,4]) )
      
    }
  })
  
  observeEvent(input$donor_company_phone, {
    
    value <- str_match(
      input$donor_company_phone,
      capture('[0-9][0-9][0-9]') %R%
        optional(capture('[0-9][0-9][0-9]')) %R%
        optional(capture('[0-9][0-9][0-9][0-9]'))
    )
    
    
    if(str_length(value[1, 1]) == 10 & !is.na(value[1, 1])) {
      updateTextInput(
        session = session,
        "donor_company_phone",
        "Phone",
        value = str_c('(', value[1, 2], ')', ' ', value[1, 3], '-', value[1,4]) )
      
    }
  })
  
  
  
  ## Donor spouse handlers ------------------------------------------------
  observeEvent(input$add_donor_spouse, {
      output$donor_spouse_ui <- renderUI(
        ui_donor_spouse
      )
      session_values$has_spouse <- TRUE
    })
  
  observeEvent(input$remove_donor_spouse, {
      # Render empty UI
      output$donor_spouse_ui <- renderUI(hr())
      session_values$has_spouse <- FALSE
    })
  
  observeEvent(input$donors_pnum, {
    
    value <- str_match(
      input$donors_pnum,
      capture('[0-9][0-9][0-9]') %R%
        optional(capture('[0-9][0-9][0-9]')) %R%
        optional(capture('[0-9][0-9][0-9][0-9]'))
    )
    
    
    if(str_length(value[1, 1]) == 10 & !is.na(value[1, 1])) {
      updateTextInput(
        session = session,
        "donors_pnum",
        "Phone",
        value = str_c('(', value[1, 2], ')', ' ', value[1, 3], '-', value[1,4]) )
      
    }
  })
  
  
  
  ## Submit New Donor form ------------------------------------------------
  observeEvent(input$donor_create, {
    
    new_donor_val <- new_donor_create_validate_input(input, session_values)
    
    
    if(new_donor_val$valid){
      
      donor_id <- db_new_donor_create(input, SQL_CON, session_values)
      session_values$donors_table <- db_get_donors(SQL_CON)
      # Clean previous inputs
      new_donor_clean(session_values, output)
      
      showModal(
        modalDialog(
          title = "New Donor added successfuly", size = "m"
        )  
      )
      
    } else {
      # Clear previous errors
      new_donor_clean_err(session_values, output)
      # Render errors found during input validation
      print_errors(output, new_donor_val)
    }
  })
  

  ## Cancel new donor -----------------------------------------------------
  observeEvent(input$donor_cancel, {
    new_donor_clean(session_values, output)
    output$donor_spouse_ui <- renderUI(p())
    session_values$has_spouse <- FALSE
  })
  
  

  # New Donor - Company ---------------------------------------------------
  
  ## Donor telephone handler ----------------------------------------------
  observeEvent(input$company_poc_phone, {
    
    value <- str_match(
      input$company_poc_phone,
      capture('[0-9][0-9][0-9]') %R%
        optional(capture('[0-9][0-9][0-9]')) %R%
        optional(capture('[0-9][0-9][0-9][0-9]'))
    )
    
    
    if(str_length(value[1, 1]) == 10 & !is.na(value[1, 1])) {
      updateTextInput(
        session = session,
        "company_poc_phone",
        "Point of Contact Telephone",
        value = str_c('(', value[1, 2], ')', ' ', value[1, 3], '-', value[1,4]) )
      
    }
  })
  
  
  ## Submit New Company form ----------------------------------------------
  observeEvent(input$company_create, {
    new_company_val <- new_company_create_validate_input(input)
    
    if(new_company_val$valid){
      company_id <- db_new_company_create(input, SQL_CON, session_values)
      session_values$donors_table <- db_get_donors(SQL_CON)
      
      showModal(
        modalDialog(
          title = "New Company added successfuly", size = "m"
        )
      )
      
      new_company_clean(output)
      
    } else {
      # Clear previous error messages
      new_company_clean_err(output)
      
      # Render errors found during input validation
      print_errors(output, new_company_val)
    }
  })
  
  ## Cancel new donor -----------------------------------------------------
  observeEvent(input$company_cancel, {
    new_company_clean(output)
  })
  

  
  
  

  # Edit donors -----------------------------------------------------------
  
  output$donors_table <- DT::renderDataTable(
    DT::datatable(session_values$donors_table |> 
                    dplyr::rename(
                      " " = Id,
                      "Donor Type" = Type,
                      "First Name" = FirstName,
                      "Middle Name" = MiddleName,
                      "Last Name" = LastName,
                      "Phone Type 1" = PhoneType1,
                      "Phone 1" = Phone1,
                      "Phone Type 2" = PhoneType2,
                      "Phone 2" = Phone2,
                      "Phone Type 3" = PhoneType3,
                      "Phone 3" = Phone3,
                      "Email 1" = Email1,
                      "Email 2" = Email2,
                      "Company Name" = CompanyName,
                      "Company Contact Name" = CompanyContactName,
                      "Department" = CompanyContactNameDepartment,
                      "Company Phone" = CompanyContactPhone,
                      "Company Webiste" = CompanyWebsite,
                      "Street 1" = Street1,
                      "City 1" = City1,
                      "State 1" = State1,
                      "Contry 1" = Country1,
                      "Zip Code 1" = ZipCode1,
                      "Street 2" = Street2,
                      "City 2" = City2,
                      "State 2" = State2,
                      "Contry 2" = Country2,
                      "Zip Code 2" = ZipCode2,
                      "Spouse First Name" = SpouseFirstName,
                      "Spouse Middle Name" = SpouseMiddleName,
                      "Spouse Last Name" = SpouseLastName,
                      "Total Amount Donated" = AccumulatedDonationValue
                    ), escape=FALSE,
                  selection = "single",
                  class = "display nowrap",
                  options = list(
                    columnDefs = list(list(className = 'dt-center',
                                           targets = '_all')),
                    pageLength = 20, autoWidth = TRUE,
                    scrollX = TRUE
                  ),
                  # editable = list(
                  #   target = "row",
                  #   disable = list(columns = c(0, 1, 29, 30, 31, 32))
                  # ),
                  rownames = FALSE)
  )
  
  
  observeEvent(input$donor_delete, {
    req(input$donors_table_rows_selected) # Ensure rows are selected
    print(input$donors_table_rows_selected)
    
    row_to_delete <- session_values$donors_table[input$donors_table_rows_selected, ]
    
    showModal(modalDialog(
      paste0("Are you sure you want to delete the ",
             row_to_delete$Type, " ",
             row_to_delete$FirstName, " ",
             row_to_delete$LastName, "?"),
      br(),
      actionButton(inputId = "donor_delete_confirm", label = "Yes"),
      actionButton(inputId = "donor_delete_cancel", label = "No")
    ))
  })
  
  
  observeEvent(input$donor_delete_confirm, {
    print("TODO finish deleting the item in donor list")
    # Remove selected rows from the database
    # rv$data <- rv$data[-input$donors_table_rows_selected,]
    # 
    # # Update the datatable using a proxy
    # proxy <- dataTableProxy("donors_table")
    # replaceData(proxy, rv$data, resetPaging = FALSE)
  })
  
  # Track changes made to the table
  observeEvent(input$donors_table_cell_edit, {
    # Get row and cols affected
    edt_row <- input$donors_table_cell_edit$row[1]
    edt_col <- input$donors_table_cell_edit$col + 1 # DT counts from 0
    
    # Get donor ID
    edt_dn_id <- session_values$donors_table$Id[edt_row]
    # Filter original data by ID
    ori_dn_table <- session_values$donors_table |>
      dplyr::filter(Id == edt_dn_id)

    # Find values that were changed
    edt_dn_table <- ori_dn_table
    
    edt_dn_table[, edt_col] <- input$donors_table_cell_edit$value
    
    dn_update_query <- edit_donor_get_update(ori_dn_table, edt_dn_table, SQL_CON)
    if(nchar(dn_update_query) > 0){
      session_values$donors_table_updates <- c(
        session_values$donors_table_updates,
        dn_update_query
      )
    }
  })
  
  # Save changes made to the tables 
  observeEvent(input$edit_donor_submit, {
    
    showModal(
      modalDialog(
        "Updating server..."
      )
    )
    
    # Submit all queries stored
    res <- sapply(
      X = session_values$donors_table_updates,
      FUN = dbExecute,
      conn = SQL_CON
    )
    
    session_values$donors_table <- db_get_donors(SQL_CON)
    
    showModal(
      modalDialog(
        "Update complete!"
      )
    )
  })

  
  # Edit donations --------------------------------------------------------
  
  output$donations_table <- DT::renderDataTable(
    DT::datatable(session_values$donations_table, escape=FALSE, 
                  options = list(
                    pageLength = 20, autoWidth = TRUE,
                    scrollX = TRUE
                  ),
                  editable = "row")
  )
  
  
  # Track changes made to the table
  observeEvent(input$donations_table_cell_edit, {
    # Get row and cols affected
    edtd_row <- input$donations_table_cell_edit$row[1]
    edtd_col <- input$donations_table_cell_edit$col[-1]
    
    # Get donation ID
    edtd_dnt_id <- session_values$donations_table$Id[edtd_row]
    
    # Find values that were changed
    ori_dnt_table <- session_values$donations_table |>
      dplyr::filter(Id == edtd_dnt_id)
    
    edtd_dnt_table <- ori_dnt_table
    
    edtd_dnt_table[, edtd_col] <- input$donations_table_cell_edit$value[-1]
    
    dnt_update_query <- edit_donations_get_update(ori_dnt_table, edtd_dnt_table, SQL_CON)
    if(nchar(dnt_update_query) > 0){
      session_values$donations_table_updates <- c(
        session_values$donations_table_updates,
        dnt_update_query
      )
    }
  })
  
  # Save changes made to the tables 
  observeEvent(input$edit_donation_submit, {
    
    showModal(modalDialog(
        "Updating server..."
    ))
    
    # Submit all queries stored
    res <- sapply(
      X = session_values$donations_table_updates,
      FUN = dbExecute,
      conn = SQL_CON
    )
    
    session_values$donations_table <- db_get_donations(SQL_CON)
    
    showModal(modalDialog(
        "Update complete!"
    ))
    
  })
  

  

  # Edit Events -----------------------------------------------------------
  output$events_table <- DT::renderDataTable({
    
    events_table <- session_values$events_table |> 
      dplyr::filter(Id != 1)
    
    DT::datatable(events_table, escape=FALSE, 
                  class = "display nowrap",
                  options = list(
                    pageLength = 20, autoWidth = TRUE,
                    scrollX = TRUE
                  ),
                  editable = list(
                    target = "row",
                    disable = list(columns = c(0, 7))
                  ),
                  rownames = FALSE)
  })

  
  # New Event -------------------------------------------------------------
  # Create Event
  observeEvent(input$raffle_create, {
    db_new_event_create(input, SQL_CON, session_values)
    
    session_values$events_table <- db_get_events(SQL_CON)
    
    showModal(modalDialog(
        "New Event created"
    ))
    
    new_event_clean()
  })
  
  observeEvent(input$raffle_cancel, {
    new_event_clean()
  })

  
  # New Donation ----------------------------------------------------------

  ## selectInput handlers -------------------------------------------------
  observe({
    donor_names <- paste(
      session_values$donors_table$FirstName,
      session_values$donors_table$LastName
    )
    
    donor_options <- session_values$donors_table$Id
    names(donor_options) <- donor_names
    
    updateSelectInput(
      inputId = "donation_donor",
      choices = donor_options
    )
  })
  
  observe({
    event_options <- session_values$events_table$Id
    names(event_options) <- session_values$events_table$Name
    
    updateSelectInput(
      inputId = "donation_raffle",
      choices = event_options
    )
  })

  
  ## Submit New Donation --------------------------------------------------
  observeEvent(input$donation_create, {
    
    new_donation_val <- new_donation_validate_input(input)
    
    if(new_donation_val$valid){
      db_new_donation(input, SQL_CON, session_values)
      
      showModal(modalDialog(
        "New Donation registered"
      ))
      
      new_donation_clean(output)
    } else {
      new_donation_clean_err(output)
      print_errors(output, new_donation_val)
    }
  })
  

  ## Cancel New Donation ---------------------------------------------------
  observeEvent(input$donation_cancel, {
    new_donation_clean_err(output)
  })
  
  
}


### Be kind to everyone ###
