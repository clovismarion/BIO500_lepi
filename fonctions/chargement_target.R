chargement <- function(exclure = NULL, combiner = FALSE) {
  # Chemin des fichiers
  dir <- getwd()
  
  # Lister tous les csv dans le directory
  file_list <- list.files(path = file.path(dir, "lepidopteres"), pattern = ".csv", full.names = TRUE)
  
  #Omettre des fichiers, si précisé
  if (!is.null(exclure)) {
    file_list <- file_list[!basename(file_list) %in% exclure]
  }
  
  # Lier les csv du fichier dans une liste de dataframes
  df_list <- lapply(file_list, read.csv)
  
  # Si combine = T, lier tous les dataframe
  if (combiner) {
    return(bind_rows(df_list))
  } else {
    return(df_list)
  }
}

