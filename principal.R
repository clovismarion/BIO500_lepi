# Principal
library(dplyr)
library(ritis)
library(RSQLite)

# importer les données
source("fonctions/load.R")
dir <- getwd()
## avoir le fichier comportant les données en csv et nommé "lepidopteres"
df_list <- load_csv_files(path = dir, exclude_file = "taxonomie.csv", combine = F)


# S'assurer de l'uniformité dans la structure des données
source("fonctions/clean.R")
DonneesPropres <- clean(df_list)

# Valider à l'oeil les données
source("fonctions/valider.R")
data <- validate(DonneesPropres)

# Création de dataframes représentant les tables
site <- data %>% select(lat, lon)
info <- data %>% select(original_source, creator, title, publisher, intellectual_rights, license, owner)
taxonomie <- data %>% select(observed_scientific_name)
obs <- data %>% select(obs_unit, obs_variable, obs_value)
main <- data %>% select(observed_scientific_name, year_obs, day_obs, time_obs, dwc_event_date)

  
#Avoir des entiees uniques
source("fonctions/combinaisons.R")
site <- combinaisons(site)
info <- combinaisons(info)
taxonomie <- combinaisons(taxonomie)
obs <- combinaisons(obs)
main <-combinaisons(main)

#joindre les ID au main
source("fonctions/joindre.R")
data <- joindre_id(data, site)
data <- joindre_id(data, info)
data <- joindre_id(data, obs)
data <- joindre_id(data, main)

main <- data %>% select(observed_scientific_name, year_obs, day_obs, time_obs, dwc_event_date, main_id, site_id, info_id, obs_id)


#création des tables
source("RSQLite.R")



