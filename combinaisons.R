library(dplyr)

combinaisons <- function(df){
  df <- df %>% distinct()
  
  return(df)
}
