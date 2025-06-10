ui_donor_spouse <- shiny::tagList(
  selectInput(
    inputId = "donors_title",
    label = "Title",
    choices = c("Mr.", "Ms.")
  ),
  selectInput(
    inputId = "donors_type",
    label = "Type",
    choices = c("donnor_type1", "donnor_type2")
  ),
  textInput(
    inputId = "donors_fname",
    label = "First Name",
  ),
  textInput(
    inputId = "donors_mname",
    label = "Middle Name"
  ),
  textInput(
    inputId = "donors_lname",
    label = "Last Name"
  ),
  hr(),
  h4("Spouse Contact Info"),
  selectInput(
    inputId = "donors_phone_type",
    label = "Phone Type",
    choices = c("ptype1", "ptype2")
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
  hr(),
  h4("Spouse Address"),
  textInput(
    inputId = "donors_street",
    label = "Street Address"
  ),
  textInput(
    inputId = "donors_city",
    label = "City"
  ),
  textInput(
    inputId = "donors_state",
    label = "Province / State"
  ),
  textInput(
    inputId = "donors_country",
    label = "Country"
  ),
  textInput(
    inputId = "donors_zip",
    label = "Postal / Zip Code"
  )
)
