library(tidyverse)


INV <- read_csv("~/Invert_Metadata_Field.csv") %>% select(-c(ID))

INV <- INV %>% 
  filter(lubridate::year(as.Date(Event_Date, format= "%m/%d/%Y%H:%M:%S")) <=2018)

write_excel_csv(INV, path = "//INHS-Bison/ResearchData/Groups/Kaskaskia_CREP/Analysis/Invert/CREP_invert_field_collection_2013-2018.csv") 