#' UI menus rendered after successful login.
#' 
ui_sidebar_menus <- sidebarMenu(
  menuItem(text = "Search Donor",
           icon = icon("list-ul"), tabName = "edit_donor"),
  menuItem(text = "Search Donations",
           icon = icon("list-ul"), tabName = "srch_donations"),
  
  menuItem(text = "New Entry",
           icon = icon("pencil"), tabName = "new_entry",
           startExpanded = FALSE,
           menuSubItem(text = "New Individual",
                       icon = icon("user"), tabName = "new_donor"),
           menuSubItem(text = "New Company",
                       icon = icon("building-columns"), tabName = "new_company")
  ),
  menuItem(text = "New Event",
           icon = icon("ticket"), tabName = "new_raffle"),
  menuItem(text = "New Donation",
           icon = icon("sack-dollar"), tabName = "new_donation")
)

### Be kind to everyone ###