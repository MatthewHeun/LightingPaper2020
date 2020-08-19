source("Data/phi_conversion.R")

# This script creates a table with the mean and sd of the exergy-to-energy factor
# for each lamp type.

# Pulls data fro phi_conversion script
phi_table <- phi_p2_mean_by_lamp_type

# Identifies column names 
info_phi_colnames <- phi_table$lamp_type

# Transposes the combined DF
phi_table <- as.data.frame(t(phi_table[,-1]))

# Sets column names 
colnames(phi_table) <- info_phi_colnames

# Re-orders columns
phi_table <- phi_table[,c("INC","HAL","CFL","LED","MH","HPS")]

# Re-orders rows
phi_table <- phi_table[c("mean_phi_p2","sd_phi_p2","count"), ]

# Set rownames
phi_table <- magrittr::set_rownames(phi_table, 
                                           c("$\\bar{\\phi}_{L,pl}$", 
                                             "$\\sigma_{\\phi_{L,pl}}$",
                                             "$n$"))  
