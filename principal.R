# Principal
library(dplyr)
library(RSQLite)

# importer les données
source("fonctions/chargement_target.R")

## avoir le fichier comportant les données en csv et nommé "lepidopteres"
df_list <- chargement(exclure = "taxonomie.csv", combiner = F)

# S'assurer de l'uniformité dans la structure des données
source("fonctions/nettoyage_target.R")
DonneesPropres <- nettoyage(df_list)

# Valider à l'oeil les données
source("fonctions/valider_target.R")
data <- valider(DonneesPropres)

# Création de dataframes représentant les tables
site <- data %>% 
  select(lat, lon)
info <- data %>% 
  select(original_source, creator, title, publisher, intellectual_rights, license, owner)
obs <- data %>% 
  select(obs_unit, obs_variable, obs_value)
main <- data %>% 
  select(observed_scientific_name, year_obs, day_obs, time_obs, dwc_event_date)

  
#Avoir des entietes uniques
source("fonctions/combinaisons.R")
site <- combinaisons(site)
info <- combinaisons(info)
obs <- combinaisons(obs)
main <-combinaisons(main)

#joindre les ID au main
source("fonctions/joindre.R")
data <- joindre_id(data, site)
data <- joindre_id(data, info)
data <- joindre_id(data, obs)
data <- joindre_id(data, main)

#reformer le main
main <- data %>% 
  select(observed_scientific_name, year_obs, day_obs, time_obs, dwc_event_date, main_id, site_id, info_id, obs_id)

#filtrer pour données du québec
source("fonctions/Donnee_Quebec.R")
site <-quebec(site)
geometry <- site$geometry
site$geometry <- NULL

#création des tables
source("RSQLite.R")



