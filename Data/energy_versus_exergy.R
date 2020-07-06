# This script does the energy versus exergy graph for ANY number of lamps

library(ggspectra)
library(ggplot2)
library(dplyr)


lamp_list <- c("lamp_inc_globe_a19_40w", "lamp_hal_globe_r20", "lamp_cfl_es_tw_9", "lamp_led_phil_a19")



x11()
  
  weighted_responses_df %>%
    filter(lamp_name %in% lamp_list) %>%
    
    ggplot(mapping = aes(x = `Wavelength [nm]`)) +
    geom_line(mapping = aes(y = actual_exergy, col = "Exergy"), colour = "red") +
    geom_line(mapping = aes(y = actual_radiant_power, col = "Energy"), colour = "blue") +

    # ggspectra::stat_color(mapping = aes(x = `Wavelength [nm]`, y = actual_exergy),
    #                   geom = "bar",
    #                   # chroma.type = photobiology::cone_fundamentals10.spct,
    #                   # chroma.type = photobiology::ciexyzCC2.spct,
    #                   # chroma.type = photobiology::ciexyzCC2.spct,
    #                   # chroma.type = photobiology::ciexyzCMF2.spct,
    #                   # chroma.type = photobiology::ciexyzCMF10.spct,
    #                   # chroma.type = "CC",
    #                   chroma.type = "CMF",
    #                   size = 0) +   # Eliminates borders
  
  xlab(expression(lambda*" [nm]")) +
  ylab(expression("Spectral radiative energy and exergy, "*phi*" [W/nm]")) +
  scale_x_continuous(limits = c(250, 900), breaks = c(250, 380, 555, 750, 900)) +
  labs(fill = element_blank(), colour = element_blank()) +
  MKHthemes::xy_theme() +
  theme(axis.text.x = element_text(size = rel(0.8), angle = 90),
        axis.text.y = element_text(size = rel(0.8)),
        # Move the facet labels out of the graphs slightly.
        strip.text.x = element_text(margin = margin(b = 2.0)),
        strip.text.y = element_text(margin = margin(l = 2.0))) +
  
  facet_wrap(~lamp_name)

