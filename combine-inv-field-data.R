library(tidyverse)

INV_filenames <- list.files(path="//INHS-Bison/ResearchData/Groups/Kaskaskia_CREP/Data/Data_IN/INV", pattern="*.xlsx")
INV_fullpath=file.path("//INHS-Bison/ResearchData/Groups/Kaskaskia_CREP/Data/Data_IN/INV",INV_filenames)
INV_fulldataset_xl <- do.call("rbind",lapply(INV_fullpath, FUN = function(files){readxl::read_xlsx(files, sheet = 2, col_types = 
                                                                                                     c("text", "text", "date", "skip", "skip","skip", "numeric", "text", "text","text", "text"))}))


INV_dataset <- INV_fulldataset_xl %>% na_if(0) %>% 
  drop_na(Jab_Habitat) %>% 
  replace_na(list(Jab_Collector = "Unknown Metzke Crew"))
