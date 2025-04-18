combiner_id <- function(data, cols, df_name = "df") {
  # 1. Extraction des colonnes d'intérêt
  extrait <- data[, cols, drop = FALSE]
  
  # 2. Retrait des doublons et création de l'ID
  extrait_unique <- extrait %>%
    distinct()
  
  id_col_name <- paste0(df_name, "_id")
  extrait_unique[[id_col_name]] <- seq_len(nrow(extrait_unique))
  
  # 3. Jointure pour ajouter l'ID dans les données originales
  data_final <- data %>%
    left_join(extrait_unique, by = cols)
  
  return(list(data = data_final, ids = extrait_unique))
}


