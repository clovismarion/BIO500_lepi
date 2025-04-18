extract_columns <- function(df, ...) {
  df %>%
    dplyr::select(...)
}

site <- extract_columns(data, lon, lat)
