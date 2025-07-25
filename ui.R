# Kindred connect v0.01
# Please, be kind.


dashboardPage(
  title = "KindredConnect",
  header = dashboardHeader(title = "KindredConnect"),
  skin = "red",

  # Sidebar menu ----------------------------------------------------------
  sidebar = dashboardSidebar(
    sidebarMenu(
      menuItem(text = "User",
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
         # h1("Login"),
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

      # New Entry - New Individual ----------------------------------------
      tabItem(
        tabName = "new_donor",
        h1("Add New Donor - Individual"),
        fluidRow(
          box(
            width = 12,
            title = "Donor Details",
            selectInput(
              inputId = "donor_title",
              label = "Title *",
              choices = TITLE_OPTIONS
            ),
            # selectInput(
            #   inputId = "donor_type",
            #   label = "Type",
            #   choices = c("donnor_type1", "donnor_type2")
            # ),
            textInput(
              inputId = "donor_fname",
              label = "First Name *",
            ),
            textOutput(outputId = "donor_fname_err"),
            textInput(
              inputId = "donor_mname",
              label = "Middle Name"
            ),
            textInput(
              inputId = "donor_lname",
              label = "Last Name *"
            ),
            
            br(),
            hr(),
            h4("Contact Info"),
            selectInput(
              inputId = "donor_phone_type1",
              label = "Phone Type *",
              choices = TELEPHONE_TYPES
            ),
            textInput(
              inputId = "donor_pnum1",
              label = "Phone *",
              placeholder = "(xxx) xxx-xxxx"
            ),
            br(),
            br(),
            selectInput(
              inputId = "donor_phone_type2",
              label = "Phone 2 Type",
              choices = TELEPHONE_TYPES
            ),
            textInput(
              inputId = "donor_pnum2",
              label = "Phone 2",
              placeholder = "(xxx) xxx-xxxx"
            ),
            br(),
            br(),
            selectInput(
              inputId = "donor_phone_type3",
              label = "Phone 3 Type",
              choices = TELEPHONE_TYPES
            ),
            textInput(
              inputId = "donor_pnum3",
              label = "Phone 3",
              placeholder = "(xxx) xxx-xxxx"
            ),
            br(),
            br(),
            textInput(
              inputId = "donor_email1",
              label = "Email *"
            ),
            textInput(
              inputId = "donor_email2",
              label = "Secondary Email"
            ),
            
            br(),
            hr(),
            h4("Main Address"),
            textInput(
              inputId = "donor_street",
              label = "Street Address *"
            ),
            textInput(
              inputId = "donor_city",
              label = "City *"
            ),
            textInput(
              inputId = "donor_state",
              label = "Province / State *"
            ),
            textInput(
              inputId = "donor_country",
              label = "Country *"
            ),
            textInput(
              inputId = "donor_zip",
              label = "Postal / Zip Code *"
            ),
            
            br(),
            hr(),
            h4("Secondary Address"),
            textInput(
              inputId = "donor_street2",
              label = "Street Address"
            ),
            textInput(
              inputId = "donor_city2",
              label = "City"
            ),
            textInput(
              inputId = "donor_state2",
              label = "Province / State"
            ),
            textInput(
              inputId = "donor_country2",
              label = "Country"
            ),
            textInput(
              inputId = "donor_zip2",
              label = "Postal / Zip Code"
            ),
            
            br(),
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
            
            br(),
            hr(),
            h4("Spouse Details"),
            actionButton(
              inputId = "add_donor_spouse",
              label = "Add Spouse"
            ),
            shiny::uiOutput(
              outputId = "donor_spouse_ui"
            ),
            
            br(),
            br(),
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
      
      # New Entry - New Company -------------------------------------------
      tabItem(
        tabName = "new_company",
        h1("Add New Donor - Company"),
        fluidRow(
          box(
            width = 12,
            title = "Company Details",
            textInput(
              inputId = "company_name",
              label = "Company Name *"
            ),
            selectInput(
              inputId = "company_poc_title",
              label = "Point of Contact Title",
              choices = TITLE_OPTIONS
            ),
            textInput(
              inputId = "company_poc",
              label = "Point of Contact Name *"
            ),
            textInput(
              inputId = "company_poc_phone",
              label = "Point of Contact Telephone *",
              placeholder = "(xxx) xxx-xxxx"
            ),
            textInput(
              inputId = "company_poc_dep",
              label = "Point of Contact Department *"
            ),
            textInput(
              inputId = "company_website",
              label = "Company Website"
            ),
            
            hr(),
            actionButton(
              inputId = "company_create",
              label = "Save"
            ),
            actionButton(
              inputId = "company_cancel",
              label = "Cancel"
            )
          )
        )
      ),

      # New raffle tab ----------------------------------------------------
      tabItem(
        tabName = "new_raffle",
        h1("New Event"),
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
            textInput(
              inputId = "donation_category",
              label = "Category"
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
              choices = DONATION_PAY_TYPES
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
            collapsible = TRUE, collapsed = FALSE,
            title = "Quick Start",
            solidHeader = TRUE, status = "danger",
            p("Double click a row to edit."),
            p("Press ctrl + enter to finish editing a row."),
            p("Press the 'Submit' button at the bottom to save changes permanently.")
          )
        ),
        fluidRow(
          box(
            width = 12,
            DT::dataTableOutput(outputId = "donors_table"),
            actionButton(inputId = "edit_donor_submit", label = "Submit")
          )
        )
      ),
      

      # Search donations --------------------------------------------------
      tabItem(
        tabName = "srch_donations",
        h1("Donations"),
        fluidRow(
          box(
            width = 12,
            collapsible = TRUE, collapsed = FALSE,
            title = "Quick Start",
            solidHeader = TRUE, status = "danger",
            p("Double click a row to edit."),
            p("Press ctrl + enter to finish editing a row."),
            p("Press the 'Submit' button at the bottom to save changes permanently.")
          )
        ),
        fluidRow(
          box(
            width = 12,
            DT::dataTableOutput(outputId = "donations_table"),
            actionButton(inputId = "edit_donation_submit", label = "Submit")
          )
        )
      )
      
      
      
    )
  )
)


### Be kind to everyone ###
