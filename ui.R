# Kindred connect v0.01
# Please, be kind.


dashboardPage(
  title = "KindredConnect",
  header = dashboardHeader(title = "KindredConnect"),
  skin = "red",

  # Sidebar menu ----------------------------------------------------------
  sidebar = dashboardSidebar(
    sidebarMenu(
      menuItem(text = "Login",
               icon = icon("shield"), tabName = "login"),
      menuItemOutput(outputId = "post_auth_menus")
    )
  ),
  body = dashboardBody(
    useShinyjs(),
    extendShinyjs(text = jscode, functions = "collapse"),
    
    tabItems(
      # Login tab ---------------------------------------------------------
      tabItem(
        tabName = "login",
       fluidPage(
         h1("Login"),
         fluidRow(
           uiOutput(outputId = "login_status_window"),
           box(
             id = "login_box",
             width = 12,
             title = "",
             collapsible = TRUE,
             textInput(
               inputId = "username",
               label = "User Name"
             ),
             passwordInput(
               inputId = "user_pwd",
               label = "Password"
             ),
             actionButton(
               inputId = "submit_login",
               label = "Submit"
             ),
             textOutput(outputId = "login_message")
           )
         ),
         fluidRow(
           uiOutput(outputId = "login_status")
         )
       )
      ),

      # New donor tab -----------------------------------------------------
      tabItem(
        tabName = "new_donor",
        h1("Create New Donor"),
        fluidRow(
          box(
            width = 12,
            title = "Donor Details",
            selectInput(
              inputId = "donor_title",
              label = "Title",
              choices = c("", "Mr.", "Ms.")
            ),
            selectInput(
              inputId = "donor_type",
              label = "Type",
              choices = c("donnor_type1", "donnor_type2")
            ),
            textInput(
              inputId = "donor_fname",
              label = "First Name",
            ),
            textInput(
              inputId = "donor_mname",
              label = "Middle Name"
            ),
            textInput(
              inputId = "donor_lname",
              label = "Last Name"
            ),
            hr(),
            h4("Contact Info"),
            selectInput(
              inputId = "donor_phone_type",
              label = "Phone Type",
              choices = c("ptype1", "ptype2")
            ),
            textInput(
              inputId = "donor_pnum",
              label = "Phone",
              placeholder = "(xxx) xxx-xxxx"
            ),
            textInput(
              inputId = "donor_email",
              label = "Email"
            ),
            hr(),
            h4("Address"),
            textInput(
              inputId = "donor_street",
              label = "Street Address"
            ),
            textInput(
              inputId = "donor_city",
              label = "City"
            ),
            textInput(
              inputId = "donor_state",
              label = "Province / State"
            ),
            textInput(
              inputId = "donor_country",
              label = "Country"
            ),
            textInput(
              inputId = "donor_zip",
              label = "Postal / Zip Code"
            ),
            hr(),
            h4("Company Details"),
            textInput(
              inputId = "donor_company",
              label = "Company Name"
            ),
            textInput(
              inputId = "donor_company_poc",
              label = "Company Point of Contact"
            ),
            textInput(
              inputId = "donor_company_phone",
              label = "Company Telephone Contact",
              placeholder = "(xxx) xxx-xxxx"
            ),
            textInput(
              inputId = "donor_company_dep",
              label = "Company Point of Contact Department"
            ),
            
            hr(),
            h4("Spouse Details"),
            actionButton(
              inputId = "add_donor_spouse",
              label = "Add Spouse"
            ),
            shiny::uiOutput(
              outputId = "donor_spouse_ui"
            ),
            hr(),
            actionButton(
              inputId = "donor_create",
              label = "Save"
            ),
            actionButton(
              inputId = "donor_cancel",
              label = "Cancel"
            )
          )
        )
      ),

      # New raffle tab ----------------------------------------------------
      tabItem(
        tabName = "new_raffle",
        h1("New Raffle"),
        fluidRow(
          box(
            width = 12,
            textInput(
              inputId = "raffle_name",
              label = "Name"
            ),
            dateInput(
              inputId = "raffle_start",
              label = "Start Date", value = Sys.Date()
            ),
            dateInput(
              inputId = "raffle_end",
              label = "End Date", value = Sys.Date()
            ),
            textOutput(
              outputId = "raffle_user_created"
            ),
            hr(),
            actionButton(
              inputId = "raffle_create",
              label = "Save"
            ),
            actionButton(
              inputId = "raffle_cancel",
              label = "Cancel"
            )
          )
        )
      ),
      

      # New donation tab --------------------------------------------------
      tabItem(
        tabName = "new_donation",
        h1("New Donation"),
        fluidRow(
          box(
            width = 12,
            selectInput(
              inputId = "donation_donor",
              label = "Donor Name",
              choices = rep(letters[1:5], each = 5),
              multiple = TRUE
            ),
            selectInput(
              inputId = "donation_category",
              label = "Category",
              choices = c("cat1", "cat2")
            ),
            selectInput(
              inputId = "donation_raffle",
              label = "Raffle Name",
              choices = rep(letters[1:5], each = 5),
              selectize = TRUE
            ),
            textInput(
              inputId = "donation_amount",
              label = "Amount"
            ),
            selectInput(
              inputId = "donation_pay_type",
              label = "Payment Type",
              choices = c("type1", "type2")
            ),
            uiOutput(
              outputId = "donation_user_created"
            ),
            hr(),
            actionButton(
              inputId = "donation_create",
              label = "Save"
            ),
            actionButton(
              inputId = "donation_cancel",
              label = "Cancel"
            )
          )
        )
      ),
      
      
      # Edit donor tab ----------------------------------------------------
      tabItem(
        tabName = "edit_donor",
        h1("Donor List"),
        fluidRow(
          box(
            width = 12,
            DT::dataTableOutput(outputId = "donors_table"),
            actionButton(inputId = "edit_donnor_submit", label = "Submit")
          )
        )
      )
      
      
    )
  )
)


### Be kind to everyone ###
