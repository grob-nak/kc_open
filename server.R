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
      print("TODO: Finish adding new donor")
      # donor_id <- new_donor_create(input, SQL_CON, session_values)
      session_values$donors_table <- db_get_donors(SQL_CON)
      
      modalDialog(
        title = "Donor added successfuly", size = "m"
      )
    } else {
      # Render errors found during input validation
      new_donor_create_print_err(output, new_donor_val)
      print("Some invalid input")
    }
  })
  

  ## Cancel new donor -----------------------------------------------------
  observeEvent(input$donor_cancel, {
    print("TODO: Finish cleaning donor")
    new_donor_clean()
    output$donor_spouse_ui <- renderUI(hr())
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
  
  
  ## Submit New Donor form ------------------------------------------------
  observeEvent(input$company_create, {
    print("TODO: Finish company add logic")
    new_company_val <- new_company_create_validate_input(input)
    
    if(new_company_val$valid){
      company_id <- new_company_create(input, SQL_CON, session_values)
      # session_values$donors_table <- db_get_donors(SQL_CON)
      
      modalDialog(
        title = "Company added successfuly", size = "m"
      )
    }
  })
  
  ## Cancel new donor -----------------------------------------------------
  observeEvent(input$company_cancel, {
    print("TODO: Finish cleaning company")
    new_company_clean()
  })
  

  
  
  

  # Edit donors -----------------------------------------------------------
  
  output$donors_table <- DT::renderDataTable(
    DT::datatable(session_values$donors_table, escape=FALSE, 
                  options = list(
                    pageLength = 20, autoWidth = TRUE,
                    scrollX = TRUE
                  ),
                  editable = "row")
  )
  
  
  # Track changes made to the table
  observeEvent(input$donors_table_cell_edit, {
    # Get row and cols affected
    edt_row <- input$donors_table_cell_edit$row[1]
    edt_col <- input$donors_table_cell_edit$col[-1]
    
    # Get donor ID
    edt_dn_id <- session_values$donors_table$Id[edt_row]
    
    # Find values that were changed
    ori_dn_table <- session_values$donors_table |>
      dplyr::filter(Id == edt_dn_id)

    edt_dn_table <- ori_dn_table
    
    edt_dn_table[, edt_col] <- input$donors_table_cell_edit$value[-1]
    
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
    print("TODO: Finish sending donor updates to server")
    print(session_values$donors_table_updates)
    # Submit all queries stored
    # res <- sapply(
    #   X = session_values$donors_table_updates,
    #   FUN = dbExecute,
    #   conn = SQL_CON
    # )
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
    print("TODO: Finish sending donation updates to server")
    print(session_values$donations_table_updates)
    # Submit all queries stored
    # res <- sapply(
    #   X = session_values$donors_table_updates,
    #   FUN = dbExecute,
    #   conn = SQL_CON
    # )
  })
  
  
  
}


### Be kind to everyone ###
