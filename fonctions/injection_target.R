library(DBI)
  
  injection <- function(db_nom, carte_table, append = FALSE, overwrite = FALSE) {
    
    con <- dbConnect(SQLite(), dbname = db_nom)
    
    for (sql_table_name in names(carte_table)) {
      df <- carte_table[[sql_table_name]]
      
      dbWriteTable(
        conn = con,
        name = sql_table_name,
        value = df,
        append = append,
        overwrite = overwrite,
        row.names = FALSE
      )
      
      dbDisconnect(con)
    }
  }

  