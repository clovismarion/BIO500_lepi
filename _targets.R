# ===========================================
# _targets.R file
# ===========================================
# Dépendances
library(targets)
library(rmarkdown)
library(tarchetypes)
tar_option_set(packages = c("MASS", "igraph"))

# Scripts R
source()

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
    data, 
    validate(donnees_propre)
  ),   
  tar_target(
    site, 
    select
  ),
  tar_render(
    name = "markdown.Rmd",
    path = "C:/Users/lapin/Documents/School/Supériorité/8.Hiver 2025/BIO500 - Méthodes en écologie computationnelle/test"
  ))

