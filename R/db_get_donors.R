db_get_donors <- function(con){
  
  donors_query <- "
  SELECT a.Id, a.Type, a.Title, a.FirstName, a.MiddleName, a.LastName,
    a.PhoneType1, a.Phone1, a.PhoneType2, a.Phone2, a.PhoneType3, a.Phone3,
    a.email1, a.email2,
    a.CompanyName, a.CompanyContactName, a.CompanyContactNameDepartment,
    a.CompanyContactPhone, a.CompanyWebsite,
    a.Street1, a.City1, a.State1, a.Country1, a.ZipCode1,
    a.Street2, a.City2, a.State2, a.Country2, a.ZipCode2,
    b.FirstName as SpouseFirstName,
    b.MiddleName as SpouseMiddleName,
    b.LastName as SpouseLastName,
    C.AccumulatedDonationValue
  FROM donors AS a
  LEFT JOIN donors AS b ON
    a.SpouseId = b.Id
  LEFT JOIN (
    SELECT donorId, SUM(value) AS AccumulatedDonationValue
    FROM donations
    GROUP BY donorId
  ) AS c ON
    a.Id = c.donorId
  "
  
  
  donors_table <- dbGetQuery(con, donors_query)
  return(donors_table)
}