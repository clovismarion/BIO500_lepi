# install.packages("ritis")
library("ritis")

taxo <- function(df, column_name) {
  unique_names <- unique(df[[column_name]])  # Extract unique names
  unique_names <- gsub(" ", "\\", unique_names)  # Replace space with "\\ "
  
  results <- lapply(unique_names, function(name) {
    query <- paste0("nameWOInd:", name)
    itis_search(q = query)
  })
  
  names(results) <- unique_names  # Assign names to results for reference
  return(results)  # Returns a list of results for each name
}

itis <- taxo(df = taxonomie, column_name = "observed_scientific_name")
