source("Data/univX_conversion.R")

# This script creates a table for the conversion factors calculated in univX_conversion.R

# Pulls data fro univX_conversion script
conversion_table <- lamps_in_paper_stats_X

# Identifies column names 
info_ct_colnames <- conversion_table$lamp_type

# Transposes the combined DF
conversion_table <- as.data.frame(t(conversion_table[,-1]))

# Sets column names 
colnames(conversion_table) <- info_ct_colnames

# Re-orders columns
conversion_table <- conversion_table[,c("INC","HAL","CFL","LED","MH","HPS")]

# Re-orders rows
conversion_table <- conversion_table[c("mean_conv","sd_conv","count"), ]

# Set rownames

conversion_table <- magrittr::set_rownames(conversion_table, 
                                            c("$\\gammaratavg{}$", 
                                              "$\\sigma_{\\gammarat}$",
                                              "$n$"))  

