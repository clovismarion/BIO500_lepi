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
    site_, 
    extraction(data_1, c("lat", "lon"))
  ))