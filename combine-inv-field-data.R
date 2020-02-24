library(tidyverse)

INV_filenames <- list.files(path="//INHS-Bison/ResearchData/Groups/Kaskaskia_CREP/Data/Data_IN/INV", pattern="*.xlsx")
INV_fullpath=file.path("//INHS-Bison/ResearchData/Groups/Kaskaskia_CREP/Data/Data_IN/INV",INV_filenames)
INV_fulldataset_xl <- do.call("rbind",lapply(INV_fullpath, FUN = function(files){readxl::read_xlsx(files, sheet = 2, col_types = 
                                                                                                     c("text", "text", "date", "skip", "skip","skip", "numeric", "text", "text","text", "text"))}))


INV_dataset <- INV_fulldataset_xl %>% 
  na_if(0) %>% 
  drop_na(Jab_Habitat) %>% 
  replace_na(list(Jab_Collector = "Unknown Metzke Crew")) %>% 
  filter(lubridate::year(Event_Date) <=2017)

INV_dataset$Reach_Name <- if_else(str_detect(INV_dataset$Reach_Name, "^[:digit:]"), paste0("kasky", INV_dataset$Reach_Name), INV_dataset$Reach_Name)
INV_dataset$Reach_Name <- if_else(str_detect(INV_dataset$Reach_Name, "kasky"), str_remove_all(INV_dataset$Reach_Name, "[:blank:]"), INV_dataset$Reach_Name)
INV_dataset$PU_Gap_Code <- if_else(str_detect(INV_dataset$PU_Gap_Code, "kasky"), str_remove_all(INV_dataset$PU_Gap_Code, "[:blank:]"), INV_dataset$PU_Gap_Code)
INV_dataset$Jab_Collector <- str_to_lower(INV_dataset$Jab_Collector)
INV_dataset$Jab_Collector<- if_else(str_detect(INV_dataset$Jab_Collector, "bm"), "bmetzke", INV_dataset$Jab_Collector)
INV_dataset$Jab_Collector<- if_else(str_detect(INV_dataset$Jab_Collector, "brian metzke"), "bmetzke", INV_dataset$Jab_Collector)
INV_dataset$Jab_Collector<- if_else(str_detect(INV_dataset$Jab_Collector, "ld"), "ldrake", INV_dataset$Jab_Collector)
INV_dataset$Jab_Collector<- if_else(str_detect(INV_dataset$Jab_Collector, "levi"), "ldrake", INV_dataset$Jab_Collector)
INV_dataset$Event_Date <- as.Date(INV_dataset$Event_Date)

write_excel_csv(INV_dataset, path = "//INHS-Bison/ResearchData/Groups/Kaskaskia_CREP/Data/Data_IN/DB_Ingest/INV_2013-2017.csv") 