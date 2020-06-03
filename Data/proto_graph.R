# I need to:
# 1 - Plot the chosen weighting functions in the first column
# 2 - Plot the unweighted chosen lamps in the top row, one lamp type per column
# 3 - Plot the chosen lamps weighted by each chosen weighting function in the rows below, superimposed on the unweighted lamps
# 4 - Fill either the weighted lamp area or unweighted lamp area with a visible spectrum color gradient matched to wavelengths

# MKHthemes::xy_theme() I'm not sure whether MKHthemes xy_theme is suited to facet_grid formatting


# Changes the first column name of the 'weighted_responses_df' dataframe from "Wavelength [nm]" to "Wavelength" so the "aes()" arguement in ggplot works
# is there a way to retain the name "Wavelength [nm]"?

colnames(weighted_responses_df)[1] <- "Wavelength"

# This currently plots two lamps ("lamp_inc_globe_a19" & "lamp_led_phil_a19") and two weighting functions ("wf_nw" & wf_ca")
# How do i add a second geom_area plot onto the wf_ca row?
# How do i rearrange the order of the columns and rows in facet grid?
# How do i add make the first column a geom_line plot of the weighting function?

val_light_comp <- ggplot2::ggplot(subset(weighted_responses_df, wf_name %in% c("wf_nw", "wf_ca") & lamp_name %in% c("lamp_inc_globe_a19", "lamp_led_phil_a19")), aes(Wavelength, weighted_radiant_flux)) + 
  ggplot2::geom_area(fill = "blue")
val_light_comp + facet_grid(vars(wf_name), vars(lamp_name))






                                 
                                 
