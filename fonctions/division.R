library(dplyr)

list_data <- function(data, cols, id_name) {
  # Define new ID column name
  id_col <- paste0("id_", id_name)
  
  # Create distinct ID table with custom name
  id_table <- data %>%
    dplyr::select(dplyr::all_of(cols)) %>%
    distinct() %>%
    mutate(!!id_col := row_number())
  
  # Join new ID column to original data
  data_with_id <- data %>%
    left_join(id_table, by = cols)
  
  # Return a named list with the table named after id_name
  output <- list()
  output[[paste0(id_name, "_table")]] <- id_table
  output$data_with_id <- data_with_id
  
  return(output)
}
