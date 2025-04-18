# ===========================================
# _targets.R file
# ===========================================
# Dépendances
library(targets)
library(rmarkdown)
library(tarchetypes)
library(dplyr)
tar_option_set(packages = c("MASS", "igraph"))

# Scripts R
source("fonctions/clean.R")
source("fonctions/combinaisons.R")
source("fonctions/Donnee_Quebec.R")
source("fonctions/joindre.R")
source("fonctions/load.R")
source("fonctions/select_columns.R")
source("fonctions/valider.R")

# Pipeline
list(
  tar_target(
    df_list, 
    load_csv_files(exclude_file = "taxonomie.csv", combine = F)
  ),   
  tar_target(
    donnees_propre, 
    clean(df_list)
  ),   
  tar_target(
    data_1, 
    validate(donnees_propre)
  ),   
  tar_target(
    site_1, 
    extraction(data_1, c("lat", "long"))
  ),   
  tar_target(
    site_2, 
    combinaison(site_1)
  ),   
  tar_target(
    data_2, 
    joindre_id(data_1, site_2)
  ),   
  tar_target(
    site, 
    quebec(site_2)
  ),      
  tar_target(
    info_1, 
    extraction(data_1, c("original_source", "creator", "title", "publisher", "intellectual_rights", "license", "owner"))
  ),   
  tar_target(
    info, 
    combinaison(info_1)
  ),   
  tar_target(
    data_3, 
    joindre_id(data_2, info)
  ),   
  tar_target(
    obs_1, 
    extraction(data_1, c("obs_unit", "obs_variable", "obs_value"))
  ),   
  tar_target(
    obs, 
    combinaison(obs_1)
  ),   
  tar_target(
    data_4, 
    joindre_id(data_3, obs)
  ),   
  tar_target(
    main_1, 
    extraction(data_1, c("observed_scientific_name", "year_obs", "day_obs", "time_obs", "dwc_event_date"))
  ),   
  tar_target(
    main, 
    combinaison(main_1)
  ),   
  tar_target(
    data, 
    joindre_id(data_4, main)
  ))

