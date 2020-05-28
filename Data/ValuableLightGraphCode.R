require(ggplot2)
require(cowplot)
require(MKHthemes)

# Plotting the various luminosity functions, action spectra and response curves

nfunction <- ggplot(data = Luminosity_functions, aes(x= Wavelength, y=NoWeighting)) +
  geom_line() +
  scale_y_continuous(limits = c(0, 1)) +
  xy_theme() + 
  ggtitle("No Weighting")

pfunction <- ggplot(data = Luminosity_functions, aes(x= Wavelength, y=PhotopicLuminosityFunction)) +  # I have adopted the default theme function here to test reducing title sizes, does this work in MKH's xy_theme?
  geom_line() + 
  labs(title = 'Photopic Luminosity Function', y = 'Normalised Response',x = 'Wavelength') +
  theme(                                                       # text = element_text(color = "black", family = 'Helvetica Neue')
         plot.title = element_text(size = 10, color = 'Black')
        ,axis.title = element_text(size = 5, color = 'Black')
        ,axis.title.y = element_text(size = 5, color = 'Black'))

ufunction <- ggplot(data = Luminosity_functions, aes(x= Wavelength, y=UniversalLuminosityFunction)) +
  geom_line() + 
  xy_theme() + 
  ggtitle("Universal Luminosity Function")

vspectrum <- ggplot(data = Luminosity_functions, aes(x= Wavelength, y=VisibleSpectrum)) +
  geom_line() + 
  xy_theme() + 
  ggtitle("Visible Spectrum")

chloroa <- ggplot(data = Luminosity_functions, aes(x= Wavelength, y=Chlorophyll_a)) +
  geom_line() + 
  xy_theme() + 
  ggtitle("Chlorophyll A")

chlorob <- ggplot(data = Luminosity_functions, aes(x= Wavelength, y=Chlorophyll_b)) +
  geom_line() + 
  xy_theme() + 
  ggtitle("Chlorophyll B")

melanopsin <- ggplot(data = Luminosity_functions, aes(x= Wavelength, y=Melanopsin)) +
  geom_line() + 
  xy_theme() + 
  ggtitle("Melanopsin")

# Plotting the spectral power distribution of the INC Globe A19 lamp, and associated useful portions of the spectrum

plot_a <- ggplot(data = INC_Globe_A19, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme() +
  # scale_color_gradient(RColorBrewer::brewer.pal(11, "Spectral")) + 
  ggtitle("INC Globe A19 SPD")

plot_b <- ggplot(data = INC_Globe_A19, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") +
  geom_area(data = INC_Globe_A19_p, mapping = aes(x=Wavelength, y=PWeightedRadiativeFlux), fill = "red") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme() +
  ggtitle("P-Weighted INC Globe A19 SPD")

plot_c <- ggplot(data = INC_Globe_A19, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") + 
  geom_area(data = INC_Globe_A19_u, mapping = aes(x=Wavelength, y=UWeightedRadiativeFlux), fill = "red") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme() +
  ggtitle("U-Weighted INC Globe A19 SPD")

plot_d <- ggplot(data = INC_Globe_A19, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") + 
  geom_area(data = INC_Globe_A19_v, mapping = aes(x=Wavelength, y=VWeightedRadiativeFlux), fill = "red") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme() +
  ggtitle("V-Weighted INC Globe A19 SPD")

plot_e <- ggplot(data = INC_Globe_A19, mapping = aes(x=Wavelength, y=RadiativeFlux)) + ###
  geom_area(fill = "blue") + 
  geom_area(data = INC_Globe_A19_ca, mapping = aes(x=Wavelength, y=Chlorophyll_aWeightedRadiativeFlux), fill = "red") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme() +
  ggtitle("Chorophyll A Weighted INC Globe A19 SPD")

plot_f <- ggplot(data = INC_Globe_A19, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") + 
  geom_area(data = INC_Globe_A19_cb, mapping = aes(x=Wavelength, y=Chlorophyll_bWeightedRadiativeFlux), fill = "red") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme() +
  ggtitle("Chorophyll B Weighted INC Globe A19 SPD")

plot_g <- ggplot(data = INC_Globe_A19, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") + 
  geom_area(data = INC_Globe_A19_m, mapping = aes(x=Wavelength, y=MelanopsinWeightedRadiativeFlux), fill = "red") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme() +
  ggtitle("Melanopsin Weighted INC Globe A19 SPD")

# Plotting the spectral power distribution of the LED Phillips BR30 lamp, and associated useful portions of the spectrum

plot_h <- ggplot(data = LED_Phillips_BR30, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") + 
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme() +
  ggtitle("LED Phillips BR30 SPD")

plot_i <- ggplot(data = LED_Phillips_BR30, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") + 
  geom_area(data = LED_Phillips_BR30_p, mapping = aes(x=Wavelength, y=PWeightedRadiativeFlux), fill = "red") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme() +
  ggtitle("P-Weighted LED Phillips BR30 SPD")

plot_j <- ggplot(data = LED_Phillips_BR30, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") + 
  geom_area(data = LED_Phillips_BR30_u, mapping = aes(x=Wavelength, y=UWeightedRadiativeFlux), fill = "red") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme() +
  ggtitle("U-Weighted LED Phillips BR30 SPD")

plot_k <- ggplot(data = LED_Phillips_BR30, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") + 
  geom_area(data = LED_Phillips_BR30_v, mapping = aes(x=Wavelength, y=VWeightedRadiativeFlux), fill = "red") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme() +
  ggtitle("V-Weighted LED Phillips BR30 SPD")

plot_l <- ggplot(data = LED_Phillips_BR30, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") + 
  geom_area(data = LED_Phillips_BR30_ca, mapping = aes(x=Wavelength, y=Chlorophyll_aWeightedRadiativeFlux), fill = "red") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme() +
  ggtitle("Chlorophyll A Weighted LED Phillips BR30 SPD")

plot_m <- ggplot(data = LED_Phillips_BR30, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") + 
  geom_area(data = LED_Phillips_BR30_cb, mapping = aes(x=Wavelength, y=Chlorophyll_bWeightedRadiativeFlux), fill = "red") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme() +
  ggtitle("Chlorophyll B Weighted LED Phillips BR30 SPD")

plot_n <- ggplot(data = LED_Phillips_BR30, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") + 
  geom_area(data = LED_Phillips_BR30_m, mapping = aes(x=Wavelength, y=MelanopsinWeightedRadiativeFlux), fill = "red") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme() +
  ggtitle("Melanopsin Weighted LED Phillips BR30 SPD")

# Compiling the individual plots into a composite graph

plot_grid(nfunction, plot_a, plot_h, vspectrum, plot_d, plot_k, pfunction, plot_b, plot_i, melanopsin, plot_g, plot_n, ufunction, plot_c, plot_j, chloroa, plot_e, plot_l, chlorob, plot_f, plot_m, ncol = 3, labels = "AUTO")


# scale_fill_manual(values = colorRampPalette(brewer.pal(11, "Spectral"))(1253)) +
# scale_fill_manual(values = "spectral")
# scale_color_gradient(low = 'greenyellow', high = 'forestgreen') +
