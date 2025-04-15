validate <- function(df_list){
  df<-bind_rows(df_list)
  
  x <- summary(df)
  
  cols <- colSums(is.na(df))
  
  y <- str(df)
  
  print(c(x, cols, y))
  
  print(df)
}