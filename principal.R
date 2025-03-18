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


## ajouter un ID à chaque observation
data$id <- 1:nrow(data)

# Création de dataframes représentant les tables
geo <- data %>% select(id, lat, lon)
source <- data %>% select(id, original_source, creator, title, publisher, intellectual_rights, license, owner)
date <- data %>% select(id, year_obs, day_obs, time_obs, dwc_event_date)
sp <- data %>% select(id, observed_scientific_name)
autre <- data %>% select(obs_unit, obs_variable, obs_value)
