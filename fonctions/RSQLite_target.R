library(RSQLite)

table_creation <- function(db_nom){
  
  file.remove(db_nom)
  
  con <- dbConnect(SQLite(), dbname = db_nom)
  
  tbl_observation <- "
CREATE TABLE observation (
  obs_id            INTEGER PRIMARY KEY,
  obs_unit          VARCHAR(40),
  obs_variable      VARCHAR(50),
  obs_value         VARCHAR(200)
);"
  dbSendQuery(con,tbl_observation)
  
  tbl_info <- "
CREATE TABLE info (
  info_id                INTEGER PRIMARY KEY,
  original_source        VARCHAR(200),     
  creator                VARCHAR(100),
  title                  VARCHAR(100),
  publisher              VARCHAR(200),
  intellectual_rights    VARCHAR(200),
  license                VARCHAR(200),
  owner                  VARCHAR(100)
);"
  dbSendQuery(con, tbl_info)
  
  tbl_site_qc <- "
CREATE TABLE site (
  site_id INTEGER PRIMARY KEY,
  lat     REAL(7),
  lon     REAL(7),
  Quebec  BOOLEAN
);"
  dbSendQuery(con, tbl_site_qc)
  
  tbl_main <- "
CREATE TABLE main (
  main_id                       INTEGER PRIMARY KEY,
  observed_scientific_name      VARCHAR(100),
  year_obs                      INTEGER,
  day_obs                       INTEGER,
  time_obs                      TIME,
  dwc_event_date                TEXT,
  obs_id                        INTEGER,
  info_id                       INTEGER,
  site_id                       INTEGER,
  FOREIGN KEY (obs_id) REFERENCES observation(obs_id)
  FOREIGN KEY (info_id) REFERENCES info(info_id)
  FOREIGN KEY (site_id) REFERENCES site(site_id)
);"
  dbSendQuery(con, tbl_main)
  
  dbDisconnect(con)
}
