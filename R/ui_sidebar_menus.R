#' UI menus rendered after successful login.
#' 
ui_sidebar_menus <- sidebarMenu(
  menuItem(text = "New Donor",
           icon = icon("user"), tabName = "new_donor"),
  menuItem(text = "New Raffle",
           icon = icon("ticket"), tabName = "new_raffle"),
  menuItem(text = "New Donation",
           icon = icon("sack-dollar"), tabName = "new_donation"),
  menuItem(text = "Edit Donor",
           icon = icon("pencil"), tabName = "edit_donor")
)

### Be kind to everyone ###