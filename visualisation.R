library(dplyr)

# LAT - LON

Q1lat <- Q1 %>%
  mutate(lat_classe = round(lat, 1)) 

richesse_par_lat <- Q1lat %>%
  group_by(lat) %>%
  summarise(nb_especes = n_distinct(observed_scientific_name))

ggplot(richesse_par_lat, aes(x = lat, y = nb_especes)) +
  geom_line(color = "darkgreen") +
  geom_point(size = 0.8) +
  labs(title = "Richesse spécifique selon la latitude",
       x = "Latitude", y = "Nombre d'espèces distinctes") +
  theme_minimal()+
  geom_vline(xintercept=48, color="red")



Q2lon <- Q2 %>%
  mutate(lon_classe = round(lon, 1)) 

richesse_par_lon <- Q2lon %>%
  group_by(lon) %>%
  summarise(nb_especes = n_distinct(observed_scientific_name))

ggplot(richesse_par_lon, aes(x = lon, y = nb_especes)) +
  geom_line(color = "darkgreen") +
  geom_point(size = 1) +
  labs(title = "Richesse spécifique selon la latitude",
       x = "Longitude", y = "Nombre d'espèces distinctes") +
  theme_minimal()

#------------------------------------

# INAT


Q4 %>%
  count(info_id) %>%
  mutate(proportion = n / sum(n)) %>%
  ggplot(aes(x = factor(info_id), y = proportion, fill = factor(info_id))) +
  geom_col() +
  labs(title = "Proportion d'observations par info_id",
       x = "info_id", y = "Proportion") +
  theme_minimal() +
  theme(legend.position = "none")

inat <- Q4 %>%
  mutate(groupe = case_when(
    info_id == 53 ~ "INaturalist",
    info_id == 1 ~ "eButterfly",
    info_id == 4 ~ "VCE",
    TRUE ~ "autres"
  )) %>%
  count(groupe) %>%
  mutate(proportion = n / sum(n))


barplot(inat$proportion, 
        names.arg = inat$groupe, 
        col = c("#74AC00", "pink", "grey", "yellow3"), 
        ylim = c(0, 0.6))

#---------------------------------------



# Compter les occurrences par espèce
especes_counts <- Q5 %>%
  count(observed_scientific_name, sort = TRUE)

# Garder seulement celles avec plus de 2000 occurrences
especes_2000 <- especes_counts %>%
  filter(n > 2000)

# Barplot
barplot(especes_2000$n,
        names.arg = especes_2000$observed_scientific_name,
        las = 2,                     # rotation des noms d'espèces
        col = "lightgreen",
        main = "Espèces avec plus de 2000 occurrences",
        ylab = "Occurrences",
        cex.names = 0.8)            # taille des noms si ça déborde
#----------
Q3$dwc_event_date <- as.Date(Q3$dwc_event_date, origin = "1970-01-01")
Q3$mois <- format(Q3$dwc_event_date, "%m")  # mois en format "01" à "12"

library(dplyr)

# 1. Extraire le mois (numérique ou nom complet)
Q3 <- Q3 %>%
  mutate(mois = format(dwc_event_date, "%m"))  # ou "%m" si tu veux l'ordre numérique

# 2. Calculer la richesse spécifique par mois
diversite_par_mois <- Q3 %>%
  group_by(mois) %>%
  summarise(nb_especes = n_distinct(observed_scientific_name))


# 4. Barplot

barplot(diversite_par_mois$nb_especes,
        names.arg = diversite_par_mois$mois,
        las = 2,                     # faire pivoter les noms (vertical)
        col = "darkseagreen",
        main = "Diversité d'espèces par mois",
        ylab = "Nombre d'espèces uniques",
        cex.names = 0.8)  
#-------------------

Q3 <- Q3 %>%
  mutate(
    date = as.Date(dwc_event_date),           # Assurer que c'est bien une Date
    annee = format(date, "%Y"),               # Extraire l'année
    mois = format(date, "%m"),                # Extraire le mois sous forme numérique (01, 02, ...)
    mois_nom = month.name[as.numeric(format(date, "%m"))]  # Convertir mois en nom complet
  )

# 3. Fonction pour calculer la diversité par mois pour une année donnée
diversite_par_mois_annee <- function(df, annee_cible) {
  df %>%
    filter(annee == annee_cible) %>%
    group_by(mois_nom) %>%
    summarise(nb_especes = n_distinct(observed_scientific_name)) %>%
    mutate(mois_nom = factor(mois_nom, levels = month.name)) %>%
    arrange(mois_nom)
}

# 4. Appliquer pour 2000 et 1980
div_2000 <- diversite_par_mois_annee(Q3, "2000")
div_1980 <- diversite_par_mois_annee(Q3, "1980")
div_2020 <- diversite_par_mois_annee(Q3, "2020")

# 6. Barplot 2000
barplot(div_2000$nb_especes,
        names.arg = div_2000$mois_nom,  # Utiliser les noms des mois
        las = 2,
        col = "skyblue",
        main = "Diversité par mois - 2000",
        ylab = "Nb d'espèces",
        cex.names = 0.8)

# 7. Barplot 1980
barplot(div_1980$nb_especes,
        names.arg = div_1980$mois_nom,  # Utiliser les noms des mois
        las = 2,
        col = "darkolivegreen3",
        main = "Diversité par mois - 1980",
        ylab = "Nb d'espèces",
        cex.names = 0.8)

# 7. Barplo
barplot(div_2020$nb_especes,
        names.arg = div_2020$mois_nom,  # Utiliser les noms des mois
        las = 2,
        col = "red3",
        main = "Diversité par mois - 2020",
        ylab = "Nb d'espèces",
        cex.names = 0.8)


#---------------------------

# NOMBRE D'OBSERVATION PAR ANNÉE


library(dplyr)
library(ggplot2)

# 1. Extraire l’année
Q3 <- Q3 %>%
  mutate(date = as.Date(dwc_event_date),
         annee = format(date, "%Y"))

# 2. Compter les observations par année
obs_par_annee <- Q3 %>%
  group_by(annee) %>%
  summarise(nb_obs = n()) %>%
  filter(!is.na(annee)) %>%
  arrange(annee)

# 3. Convertir année en numérique si besoin (pour tri + axes)
obs_par_annee$annee <- as.numeric(obs_par_annee$annee)

# 4. Graphique
ggplot(obs_par_annee, aes(x = annee, y = nb_obs)) +
  geom_line(color = "darkgreen") +
  geom_point(color = "forestgreen") +
  labs(title = "Variation du nombre d'observations par année",
       x = "Année", y = "Nombre d'observations") +
  theme_minimal()


#------------------------------


Q2_summarise <- Q2 %>%
  mutate(lat_round = round(lat, 1)) %>%
  group_by(lat_round) %>%
  summarise(nb_obs = n()) %>%
  arrange(lat_round)

# 2. Graphique
ggplot(Q2_summarise, aes(x = lat_round, y = nb_obs)) +
  geom_col(fill = "steelblue") +
  labs(title = "Nombre d'observations selon la latitude",
       x = "Latitude (arrondie à 0.1°)", y = "Nombre d'observations") +
  theme_minimal()
