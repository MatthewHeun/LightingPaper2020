source("Data/phi_conversion.R")


# Pulls data fro phi_conversion script
phi_table <- phi_p2_mean_by_lamp_type

# Identifies column names 
info_phi_colnames <- phi_table$lamp_type

# Transposes the combined DF
phi_table <- as.data.frame(t(phi_table[,-1]))

# Sets column names 
colnames(phi_table) <- info_phi_colnames

# Re-orders columns
phi_table <- phi_table[,c(4,2,3,6,1,5)]

# Re-orders rows
phi_table <- phi_table[c("mean_phi_p2","sd_phi_p2","count"), ]

# Set rownames
phi_table <- magrittr::set_rownames(phi_table, 
                                           c("Mean exergy-to-energy factor ($\\bar{\\phi}_{L,pl}$)", 
                                             "Standard deviation ($\\sigma$)",
                                             "Sample size"))  
