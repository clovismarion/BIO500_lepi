
# install.packages("ritis")
library("ritis")

# Recherche code TSN pour "Acer"
itis_acer <- itis_search(q = "nameWOInd:Acer") # nameWOInd est le champ de recherche pour le nom scientifique
head(itis_acer)

# Recherche code TSN pour "Castor canadensis"
itis_castor_canadensis <- itis_search(q = "nameWOInd:Castor\\ canadensis") # On échappe l'espace avec un double backslash

# Fonction pour récupérer le TSN depuis ITIS
Code_tsn <- function(Nom_scientifique) {
  tsn <-itis_search(Nom_scientifique)
  if (!is.null(tsn) && nrow(tsn) > 0) {
    return(tsn)
  } else {
    return(NA)
  }
}
Code_tsn(tax)
# Appliquer la fonction à toutes les lignes du dataframe
# taxonomie$Code_SP <- sapply(taxonomie$observed_scientific_name, Code_tsn)54

# Afficher le dataframe mis à jour
# print(taxonomie)