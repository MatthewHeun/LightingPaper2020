R Scripts for the paper

The Energy and Exergy of Light With Application to Societal Exergy Analysis
by
Matthew Kuperus Heun, Zeke Marshall, Emmanuel Aramendia, and Paul E. Brockway
submitted to
Energies

Contents:

univX_conversion.R - This script calculates the conversion factors for moving 
                     from the exergy efficiency of a lamp based on the photopic 
                     luminous weighting function, to the exergy efficiency of a 
                     lamp based on the universal weighting function, for each 
                     lamp type and across all lamp types.

univ_conversion.R - This script calculates the conversion factors for moving from 
                    the energy efficiency of a lamp based on the photopic luminous 
                    weighting function, to the energy efficiency of a lamp based 
                    on the universal weighting function, for each lamp type and 
                    across all lamp types.

spd_metrics_calcs.R - This script calculates the radiant power for each lamp 
                      output and the weighted radiant power for each pair 
                      (lamp, weighting function) taking the integral by wavelength

results_phi_xtable.R - This script creates a table with the mean exergy-to-energy 
                       factor for each combination of lamp and weighting function 
                       used in the analysis.

results_lamp_info.R - This script creates a table for each of the lamps used in 
                      the analysis containing information on each lamp as 
                      supplied in the excel file.

results_etasX_xtable.R - This script creates a table with the mean exergy efficiency
                        for each combination of lamp and weighting function used 
                        in the analysis.

results_etas_xtable.R - This script creates a table with the mean energy efficiency
                        for each combination of lamp and weighting function used 
                        in the analysis.

phi_table.R - This script creates a table with the mean and sd of the exergy-to-energy 
              factor for each lamp type.

phi_conversion.R - This script creates data frames for the exergy-to-energy factor 
                   for each lamps, the mean for each lamp type, and the mean 
                   across all lamps.

conversion_table.R - This script creates a table for the conversion factors 
                     calculated in univX_conversion.R

conv_exact_approx.R - This script constructs a DF which contains information for the
                      three methods of assessing final-to-useful exergy efficiency.
                      Then creates a table containing this information.

AllData.R - This script pulls data from the master_lighting_data.xlsx spreadsheet 
            and builds a data frame containing weighting functions, 
            lamps, and weighted emission spectra.