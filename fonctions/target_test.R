,   
tar_target(
  site_2, 
  combinaisons(site_1)
),   
tar_target(
  data_2, 
  joindre_id(data_1, site_2)
),   
tar_target(
  site, 
  quebec(site_2)
),      
tar_target(
  info_1, 
  extraction(data_1, c("original_source", "creator", "title", "publisher", "intellectual_rights", "license", "owner"))
),   
tar_target(
  info, 
  combinaisons(info_1)
),   
tar_target(
  data_3, 
  joindre_id(data_2, info)
),   
tar_target(
  obs_1, 
  extraction(data_1, c("obs_unit", "obs_variable", "obs_value"))
),   
tar_target(
  obs, 
  combinaisons(obs_1)
),   
tar_target(
  data_4, 
  joindre_id(data_3, obs)
),   
tar_target(
  main_1, 
  extraction(data_1, c("observed_scientific_name", "year_obs", "day_obs", "time_obs", "dwc_event_date"))
),   
tar_target(
  main, 
  combinaisons(main_1)
),   
tar_target(
  data, 
  joindre_id(data_4, main)
)
