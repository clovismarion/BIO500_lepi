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
source("fonctions/chargement_target.R")
source("fonctions/nettoyage_target.R")
source("fonctions/valider_target.R")
source("fonctions/liste_donnees_target.R")
source("fonctions/selection_qc_target.R")
source("fonctions/RSQLite_target.R")
source("fonctions/selection_target.R")
source("fonctions/injection_target.R")
source("fonctions/requeteQ1.R")
source("fonctions/requeteQ2.R")
source("fonctions/requeteQ3.R")

# Pipeline
list(
  tar_target(
    liste_df, 
    chargement(exclure = "taxonomie.csv", 
               combiner = F)
  ),   
  tar_target(
    donnees_propres, 
    nettoyage(liste_df)
  ),   
  tar_target(
    donnees_brutes, 
    valider(donnees_propres)
  ),   
  tar_target(
    df_site, 
    liste_donnees(data = donnees_brutes, 
                  cols = c("lat", "lon"), 
                  id_nom = "site")
  ),   
  tar_target(
    df_info, 
    liste_donnees(data = df_site$data_with_id, 
                  cols = c("original_source", "creator", "title", "publisher", "intellectual_rights", "license", "owner"), 
                  id_nom = "infos")
  ),   
  tar_target(
    df_observation, 
    liste_donnees(data = df_info$data_with_id, 
                  cols = c("obs_unit", "obs_variable", "obs_value"), 
                  id_nom = "obs")
  ),   
  tar_target(
    df_main, 
    liste_donnees(data = df_observation$data_with_id, 
                  cols = c("observed_scientific_name", "year_obs", "day_obs", "time_obs", "dwc_event_date"), 
                  id_nom = "principal")
  ),   
  tar_target(
    df_site_qc, 
    selection_qc(site = df_site$site_table)
  ),   
  tar_target(
    creation_tables, 
    table_creation(db_nom = "lepidoptre.db")
  ),  
  tar_target(
    principal, 
    selection(df = df_main$data_with_id, 
              cols = c("observed_scientific_name", "year_obs", "day_obs", "time_obs", "dwc_event_date", "id_principal", "id_site", "id_infos", "id_obs"))
  ),
  tar_target(
    carte_tables, 
    list(main = principal, 
         observaton = df_observation$obs_table,
         info = df_info$infos_table,
         site = df_site_qc)
  ),
  tar_target(
    db_SQL, 
    injection(db_nom = "lepidoptere.db",
              carte_table = carte_tables,
              append = FALSE,
              overwrite = TRUE)
  ),
  tar_target(
    requete_1, 
    req1(db_nom = "lepidoptere.db")
  ),
  tar_target(
    requete_2, 
    req2(db_nom = "lepidoptere.db")
  ),
  tar_target(
    requete_3, 
    req3(db_nom = "lepidoptere.db")
  ))
