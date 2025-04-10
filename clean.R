clean <- function(df_liste){
  #appliquer la fonction à tous les dataframes de la liste
  lapply(df_liste, function(df) {
    
    #S'assurer de l'uniformité des noms de colones
    colnames(df) <- c("observed_scientific_name", 
                      "year_obs", 
                      "day_obs", 
                      "time_obs", 
                      "dwc_event_date", 
                      "obs_variable", 
                      "obs_unit", 
                      "obs_value", 
                      "lat", 
                      "lon", 
                      "original_source", 
                      "creator", 
                      "title", 
                      "publisher", 
                      "intellectual_rights", 
                      "license", 
                      "owner")
   
    #appliquer le bon type de variable à la colone
  df$observed_scientific_name <- as.character(df$observed_scientific_name) #noms en caractères
  df$year_obs <- as.integer(df$year_obs) #année en integer
  df$day_obs <- as.integer(df$day_obs) #mois en integer
  df <- df %>% # convertir le moment en format de temps
    mutate( time_obs = ifelse(is.na(time_obs), NA_character_, time_obs),  # Conserver les NA
            #S'assurer du bon format des données de temps
      time_obs = case_when(
        grepl("^\\d{1,2}:\\d{2}:\\d{2}$", time_obs) ~ time_obs, 
        grepl("^\\d{1,2}:\\d{2}$", time_obs) ~ paste0(time_obs, ":00"),  
        TRUE ~ NA_character_
      )
    )
  df$dwc_event_date <- as.Date(df$dwc_event_date) #convertir la date en forat Date
  df$obs_variable <- as.character(df$obs_variable) #en caractère
  df$obs_unit <- as.character(df$obs_unit) #en caractère
  df$lat <- as.numeric(round(df$lat, 4)) #latitude en numérique, avec 4 décimales, pour uniformiser
  df$lon <- as.numeric(round(df$lon, 4)) #longitude en numérique, avec 4 décimales, pour uniformiser
  
  #corrections à appliquer
  # toutes les valeurs non-nulles de obs_variables sont converties en "Presence"
  df$obs_variable <- ifelse(df$obs_variable == "" | is.na(df$obs_variable), "NA", "Presence") 
  
  
  return(df)
    })
}

#Limites choisis pour le Québec
lat_min <- 44.99
lat_max <- 62.00
lon_min <- -79.75
lon_max <- -57.00

#Conserver seulement les données du Québec
lapply(df_list, function(df) {
  df_qc <- subset(df,  
                  df$lat >= lat_min & df$lat <= lat_max &
                    df$lon >= lon_min & df$lon <= lon_max)
})


