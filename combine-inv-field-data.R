library(tidyverse)

INV_filenames <- list.files(path="//INHS-Bison/ResearchData/Groups/Kaskaskia_CREP/Data/Data_IN/INV", pattern="*.csv")
INV_fullpath=file.path("//INHS-Bison/ResearchData/Groups/Kaskaskia_CREP/Data/Data_IN/INV",INV_filenames)
INV_fulldataset <- do.call("rbind",lapply(INV_fullpath, FUN = function(files){read.csv(files, stringsAsFactors = FALSE)}))
INV_dataset <- INV_fulldataset %>% select(-c(Event_Year,Event_Month, Event_Day))

write.csv(INV_dataset, file= "//INHS-Bison/ResearchData/Groups/Kaskaskia CREP/Data/Data_IN/DB_Ingest/INV_2013.csv")


INV_filenames <- list.files(path="//INHS-Bison/ResearchData/Groups/Kaskaskia_CREP/Data/Data_IN/INV", pattern="*.xlsx")
INV_fullpath=file.path("//INHS-Bison/ResearchData/Groups/Kaskaskia_CREP/Data/Data_IN/INV",INV_filenames)
INV_fulldataset_xl <- do.call("rbind",lapply(INV_fullpath, FUN = function(files){readxl::read_xlsx(files, sheet = 2, col_types = 
                                                                                                     c("text", "text", "date", "skip", "skip","skip", "numeric", "text", "text","text", "text"))}))


INV_dataset_xl <- INV_fulldataset %>% select(-c(Event_Year,Event_Month, Event_Day))