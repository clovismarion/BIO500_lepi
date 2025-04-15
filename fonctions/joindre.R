joindre_id <- function(data, df, df_name = deparse(substitute(df))){
  
  colonnes <- c(setdiff(names(df), paste0(df_name, "_id")))
  
  data <- data %>%
    left_join(df, by = colonnes)
  
  return(data)
}

