library(DBI)

injection <- function(db_nom, tables, append = FALSE, overwrite = FALSE) {
  for (name in names(tables)) {
    df <- tables[[name]]
    
    dbWriteTable(
      conn = con,
      name = name,
      value = df,
      append = append,
      overwrite = overwrite,
      row.names = FALSE
    )
  }
}
