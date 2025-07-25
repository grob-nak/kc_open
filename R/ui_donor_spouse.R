ui_donor_spouse <- shiny::tagList(
  selectInput(
    inputId = "donors_title",
    label = "Title",
    choices = TITLE_OPTIONS
  ),
  textInput(
    inputId = "donors_fname",
    label = "First Name *",
  ),
  textInput(
    inputId = "donors_mname",
    label = "Middle Name"
  ),
  textInput(
    inputId = "donors_lname",
    label = "Last Name *"
  ),
  
  br(),
  hr(),
  h4("Spouse Contact Info"),
  selectInput(
    inputId = "donors_phone_type",
    label = "Phone Type",
    choices = TELEPHONE_TYPES
  ),
  textInput(
    inputId = "donors_pnum",
    label = "Phone",
    placeholder = "(xxx) xxx-xxxx"
  ),
  textInput(
    inputId = "donors_email",
    label = "Email"
  ),
  # hr(),
  # h4("Spouse Address"),
  # textInput(
  #   inputId = "donors_street",
  #   label = "Street Address"
  # ),
  # textInput(
  #   inputId = "donors_city",
  #   label = "City"
  # ),
  # textInput(
  #   inputId = "donors_state",
  #   label = "Province / State"
  # ),
  # textInput(
  #   inputId = "donors_country",
  #   label = "Country"
  # ),
  # textInput(
  #   inputId = "donors_zip",
  #   label = "Postal / Zip Code"
  # ),
  actionButton(
    inputId = "remove_donor_spouse",
    label = "Remove Spouse"
  )
)
