valider <- function(liste_df){
  df<-bind_rows(liste_df)
  
  x <- summary(df)
  
  cols <- colSums(is.na(df))
  
  y <- str(df)
  
  print(c(x, cols, y))
  
  print(df)
}