source("Data/univX_conversion.R")


# Pulls data fro univX_conversion script
conversion_table <- lamps_in_paper_stats_X

# Identifies column names 
info_ct_colnames <- conversion_table$lamp_type

# Sets the number of decimal places for each column
conversion_table[, "count"] <- round(conversion_table[, "count"],0)

conversion_table[, "mean_conv"] <- round(conversion_table[, "mean_conv"],2)

conversion_table[, "sd_conv"] <- round(conversion_table[, "sd_conv"],2)

# Transposes the combined DF
conversion_table <- as.data.frame(t(conversion_table[,-1]))

# Sets column names 
colnames(conversion_table) <- info_ct_colnames

# Re-orders columns
conversion_table <- conversion_table[,c(3,2,1,4)]

# Re-orders rows
conversion_table <- conversion_table[c(2,3,1), ]

# Set rownames

conversion_table <- magrittr::set_rownames(conversion_table, 
                                            c("Sample size", 
                                              "Mean conversion factor ($\\gammaratavg{}$)", 
                                              "Standard deviation ($\\sigma_{\\gammarat}$)"))  
