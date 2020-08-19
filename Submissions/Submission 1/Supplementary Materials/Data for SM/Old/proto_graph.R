# I need to:
# 1 - Plot the chosen weighting functions in the first column
# 2 - Plot the unweighted chosen lamps in the top row, one lamp type per column
# 3 - Plot the chosen lamps weighted by each chosen weighting function in the rows below, superimposed on the unweighted lamps
# 4 - Fill either the weighted lamp area or unweighted lamp area with a visible spectrum color gradient matched to wavelengths

# MKHthemes::xy_theme() I'm not sure whether MKHthemes xy_theme is suited to facet_grid formatting

# library(ggplot2)
# library(forcats)
# library(dplyr)

# Changes the first column name of the 'weighted_responses_df' dataframe from "Wavelength [nm]" to "Wavelength" so the "aes()" arguement in ggplot works
# is there a way to retain the name "Wavelength [nm]"?

colnames(weighted_responses_df)[1] <- "Wavelength"

# This currently plots two lamps ("lamp_inc_globe_a19" & "lamp_led_phil_a19") and two weighting functions ("wf_nw" & wf_ca")
# How do i add make the first column a geom_line plot of the weighting function?


# Selecting weighting functions and lamps.
# Plots will be done in the same order as these character vectors are specified.

wf_list <- c("wf_ca", "wf_nw")
lamp_list <- c("lamp_led_phil_a19", "lamp_inc_globe_a19")


# Preparing ready-to-plot dataframe based on user-defined wf_list and lamp_list

# weighted_responses_plot <- weighted_responses_df %>%
#   filter(wf_name %in% wf_list, lamp_name %in% lamp_list) %>%
#   mutate(lamp_name = as.factor(lamp_name),
#          wf_name = as.factor(wf_name),
#          lamp_name = fct_relevel(.f = lamp_name, lamp_list),
#          wf_name = fct_relevel(.f = wf_name, wf_list))


weighted_responses_to_be_plotted <- weighted_responses_df %>%
  dplyr::filter(wf_name %in% wf_list, lamp_name %in% lamp_list) %>%
  dplyr::mutate(lamp_name = factor(lamp_name, levels = lamp_list),
                wf_name = factor(wf_name, levels = wf_list))

# levels(weighted_responses_plot$lamp_name); levels(weighted_responses_plot$wf_name)


# Now, plotting

val_light_comp <- ggplot2::ggplot(data = weighted_responses_to_be_plotted, 
                                  mapping = aes(x = Wavelength)) +
  ggplot2::geom_area(aes(y = radiative_flux, fill = "Radiant Flux")) +
  ggplot2::geom_area(aes(y = weighted_radiant_flux, fill = "Weighted Radiant Flux"), show.legend = TRUE) +
  ylab("Radiative flux") +
  scale_y_continuous(sec.axis = sec_axis(~ . / max(.))) +
  geom_line(aes(y = normalized_response * max(radiative_flux), col = "WF"), linetype = 2, size = 0.3) +
  scale_color_manual(values = c("WF" = "black")) +
  scale_fill_manual(values = c("Radiant Flux" = "blue", "Weighted Radiant Flux" = "red")) +
  theme_light() +
  theme(legend.position = "bottom") +
  labs(fill = "", colour = "")

val_light_comp + facet_grid(rows = vars(wf_name), cols = vars(lamp_name))

