# This function reads the SEA lighting efficiency data in pre-prepared in panel data format.
library(readxl)
sea_lighting_efficiencies <- SEA_lighting_efficiency <- read_excel("Data/SEA_lighting_efficiency.xlsx", 
                                      sheet = "SEA_le_panel")