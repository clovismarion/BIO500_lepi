install.packages("ritis")

# Fonction pour récupérer le TSN depuis ITIS
Code_tsn <- function(Nom_scientifique) {
  tsn <- ritis::itis_search(Nom_scientifique)$tsn
  if (!is.null(tsn) && length(tsn) > 0) {
    return(tsn)
  } else {
    return(NA)
  }
}

# Appliquer la fonction à toutes les lignes du dataframe
taxonomie$Code_SP <- sapply(taxonomie$observed_scientific_name, Code_tsn)

# Afficher le dataframe mis à jour
print(taxonomie)