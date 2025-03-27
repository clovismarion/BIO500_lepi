# Principal
library(dplyr)

# importer les données
source("load.R")
dir <- getwd()
## avoir le fichier comportant les données en csv et nommé "lepidopteres"
df_list <- load_csv_files(path = dir, exclude_file = "taxonomie.csv", combine = F)


# S'assurer de l'uniformité dans la structure des données
source("clean.R")
DonneesPropres <- clean(df_list)

# Valider à l'oeil les données
source("valider.R")
data <- validate(DonneesPropres)

# Création de dataframes représentant les tables
site <- data %>% select(lat, lon)
info <- data %>% select(original_source, creator, title, publisher, intellectual_rights, license, owner)
taxo <- data %>% select(observed_scientific_name)
obs <- data %>% select(obs_unit, obs_variable, obs_value)
main <- data %>% select(observed_scientific_name, year_obs, day_obs, time_obs, dwc_event_date)


source("combinaisons.R")
site <- combinaisons(site)
info <- combinaisons(info)
taxo <- combinaisons(taxo)
obs <- combinaisons(obs)
main <-combinaisons(main)
