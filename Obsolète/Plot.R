

library(ggplot2)
library(dplyr)

# Graph nb espèces par année pour Q3
df <- Q3 %>%
  distinct(year_obs, observed_scientific_name) %>%
  count(year_obs)


barplot(df$n,
        names.arg = df$year_obs,
        col = "lightcoral",
        las = 2,
        main = "Nombre d'espèces de lépidoptères par année",
        xlab = "Année",
        ylab = "Nombre d'espèces")

#Graphique nb observations/années pour Q3

df_obs <- Q3 %>%
  count(year_obs) %>%
  arrange(year_obs)  # TRÈS important

barplot(df_obs$n,
        names.arg = df_obs$year_obs,
        col = "lightcoral",
        las = 2,
        main = "Nombre total d'observations par année",
        xlab = "Année",
        ylab = "Nombre d'observations")