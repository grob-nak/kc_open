

diff_values <- function(x, y){
  diff_vals <- mapply(
    FUN = function(x, y){
      if(is.na(x)){
        x <- ""
      }
      
      if(is.na(y)){
        y <- ""
      }
      
      return(x != y)
    },
    x,
    y,
    USE.NAMES = TRUE
  )
  return(diff_vals[diff_vals])
}



### 