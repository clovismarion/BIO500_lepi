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
source("fonctions/load.R")
source("fonctions/clean.R")
source("fonctions/valider.R")
source("fonctions/division.R")
source("fonctions/Donnee_Quebec.R")

# Pipeline
list(
  tar_target(
    df_list, 
    load_csv_files(exclude_file = "taxonomie.csv", combine = F)
  ),   
  tar_target(
    clean_data, 
    clean(df_list)
  ),   
  tar_target(
    raw_data, 
    validate(clean_data)
  ),   
  tar_target(
    df_site, 
    list_data(data = raw_data, cols = c("lat", "lon"), id_name = "site")
  ),   
  tar_target(
    df_infos, 
    list_data(data = df_site$data_with_id, cols = c("original_source", "creator", "title", "publisher", "intellectual_rights", "license", "owner"), id_name = "infos")
  ),   
  tar_target(
    df_obs, 
    list_data(data = df_infos$data_with_id, cols = c("obs_unit", "obs_variable", "obs_value"), id_name = "obs")
  ),   
  tar_target(
    df_main, 
    list_data(data = df_obs$data_with_id, cols = c("observed_scientific_name", "year_obs", "day_obs", "time_obs", "dwc_event_date"), id_name = "main")
  ),   
  tar_target(
    df_site_qc, 
    quebec(site = df_site$site_table)
  ))
