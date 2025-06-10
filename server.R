# Kindred connect v0.01
# Please, be kind.



server <- function(session, input, output){
  

  # Session reactive values -----------------------------------------------
  session_values <- reactiveValues()
  
  # Login vals
  session_values$auth <- FALSE
  
  # Editable tables
  session_values$donors_table <- db_get_donors(SQL_CON)
  

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

  
  # New donor -------------------------------------------------------------

  ## Donor telephone handler ----------------------------------------------
  observeEvent(input$donor_pnum, {
    
    value <- str_match(
      input$donor_pnum,
      capture('[0-9][0-9][0-9]') %R%
        optional(capture('[0-9][0-9][0-9]')) %R%
        optional(capture('[0-9][0-9][0-9][0-9]'))
      )
    
    
    if(str_length(value[1, 1]) == 10 & !is.na(value[1, 1])) {
      updateTextInput(
        session = session,
        "donor_pnum",
        "Phone",
        value = str_c('(', value[1, 2], ')', ' ', value[1, 3], '-', value[1,4]) )
      
    }
  })
  
  observeEvent(
    input$add_donor_spouse,
    output$donor_spouse_ui <- renderUI(
      ui_donor_spouse
    )
  )
  
  ## Submit New Donor form ------------------------------------------------
  observeEvent(
    input$donor_create,{
      new_donor_create(input, SQL_CON, session_values)
      session_values$donors_table <- db_get_donors(SQL_CON)
    }
  )
  
  

  # Edit donors -----------------------------------------------------------
  
  output$donors_table <- DT::renderDataTable(
    DT::datatable(session_values$donors_table, escape=FALSE, 
                  options = list(
                    pageLength = 20, autoWidth = TRUE,
                    scrollX = TRUE
                  ),
                  editable = "row")
  )
  
  observeEvent(
    input$edit_donnor_submit,{
      
      print(input$donors_table_cell_info)
      # session_values$donors_table <- db_get_donors(SQL_CON)
    }
  )

  
}


### Be kind to everyone ###
