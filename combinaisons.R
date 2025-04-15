library(dplyr)

combinaisons <- function(df, df_name = deparse(substitute(df))) {
  
  # Enlève les informations double
  y <- df %>%
    distinct()
  
  # Génère une colomne ID
  id_col_name <- paste0(df_name, "_id")
  
  # Ajoute des ID dans la colonne ID
  y[[id_col_name]] <- seq_len(nrow(y))
  
  return(y)
}
