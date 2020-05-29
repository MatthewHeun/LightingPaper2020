require(ggplot2)
require(cowplot)
require(MKHthemes)

# Plotting the various luminosity functions, action spectra and response curves

nfunction <- ggplot(data = Luminosity_functions, aes(x= Wavelength, y=NoWeighting)) +
  geom_line() +
  scale_y_continuous(limits = c(0, 1)) +
  labs(title = 'No Weighting', y = 'Normalised Response',x = 'Wavelength') +
  xy_theme(base_size = 8)

pfunction <- ggplot(data = Luminosity_functions, aes(x= Wavelength, y=PhotopicLuminosityFunction)) +  # I have adopted the default theme function here to test reducing title sizes, does this work in MKH's xy_theme?
  geom_line() + 
  labs(title = 'Photopic Luminosity Function', y = 'Normalised Response',x = 'Wavelength') +
  xy_theme(base_size = 8)

ufunction <- ggplot(data = Luminosity_functions, aes(x= Wavelength, y=UniversalLuminosityFunction)) +
  geom_line() + 
  labs(title = 'Universal Luminosity Function', y = 'Normalised Response',x = 'Wavelength') +
  xy_theme(base_size = 8)

vspectrum <- ggplot(data = Luminosity_functions, aes(x= Wavelength, y=VisibleSpectrum)) +
  geom_line() + 
  labs(title = 'Visible Spectrum', y = 'Normalised Response',x = 'Wavelength') +
  xy_theme(base_size = 8)

chloroa <- ggplot(data = Luminosity_functions, aes(x= Wavelength, y=Chlorophyll_a)) +
  geom_line() + 
  labs(title = 'Chlorophyll A', y = 'Normalised Response',x = 'Wavelength') +
  xy_theme(base_size = 8)

chlorob <- ggplot(data = Luminosity_functions, aes(x= Wavelength, y=Chlorophyll_b)) +
  geom_line() + 
  labs(title = 'Chlorophyll B', y = 'Normalised Response',x = 'Wavelength') +
  xy_theme(base_size = 8)

photosyn <- ggplot(data = Luminosity_functions, aes(x= Wavelength, y=PhotosynthesisActionSpectrum)) +
  geom_line() + 
  labs(title = 'Photosynthesis Action Spectrum', y = 'Normalised Response',x = 'Wavelength') +
  xy_theme(base_size = 8)

melanopsin <- ggplot(data = Luminosity_functions, aes(x= Wavelength, y=Melanopsin)) +
  geom_line() +
  labs(title = 'Melanopic Luminosity Function', y = 'Normalised Response',x = 'Wavelength') +
  xy_theme(base_size = 8)

# Plotting the spectral power distribution of the INC Globe A19 lamp, and associated valuable portions of the spectrum

plot_inc <- ggplot(data = INC_Globe_A19, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme(base_size = 8) +
  ggtitle("INC Globe A19 SPD")

plot_inc_p <- ggplot(data = INC_Globe_A19, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") +
  geom_area(data = INC_Globe_A19_p, mapping = aes(x=Wavelength, y=PWeightedRadiativeFlux), fill = "red") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme(base_size = 8) +
  ggtitle("P-Weighted INC Globe A19 SPD")

plot_inc_u <- ggplot(data = INC_Globe_A19, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") + 
  geom_area(data = INC_Globe_A19_u, mapping = aes(x=Wavelength, y=UWeightedRadiativeFlux), fill = "red") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme(base_size = 8) +
  ggtitle("U-Weighted INC Globe A19 SPD")

plot_inc_v <- ggplot(data = INC_Globe_A19, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") + 
  geom_area(data = INC_Globe_A19_v, mapping = aes(x=Wavelength, y=VWeightedRadiativeFlux), fill = "red") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme(base_size = 8) +
  ggtitle("V-Weighted INC Globe A19 SPD")

plot_inc_ca <- ggplot(data = INC_Globe_A19, mapping = aes(x=Wavelength, y=RadiativeFlux)) + ###
  geom_area(fill = "blue") + 
  geom_area(data = INC_Globe_A19_ca, mapping = aes(x=Wavelength, y=Chlorophyll_aWeightedRadiativeFlux), fill = "red") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme(base_size = 8) +
  ggtitle("Ca-Weighted INC Globe A19 SPD")

plot_inc_cb <- ggplot(data = INC_Globe_A19, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") + 
  geom_area(data = INC_Globe_A19_cb, mapping = aes(x=Wavelength, y=Chlorophyll_bWeightedRadiativeFlux), fill = "red") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme(base_size = 8) +
  ggtitle("Cb-Weighted INC Globe A19 SPD")

plot_inc_m <- ggplot(data = INC_Globe_A19, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") + 
  geom_area(data = INC_Globe_A19_m, mapping = aes(x=Wavelength, y=MelanopsinWeightedRadiativeFlux), fill = "red") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme(base_size = 8) +
  ggtitle("M-Weighted INC Globe A19 SPD")

plot_inc_ph <- ggplot(data = INC_Globe_A19, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") + 
  geom_area(data = INC_Globe_A19_ph, mapping = aes(x=Wavelength, y=PhotosynthWeightedRadiativeFlux), fill = "red") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme(base_size = 8) +
  ggtitle("Ph-Weighted INC Globe A19 SPD")

# Plotting the spectral power distribution of the LED Phillips BR30 lamp, and associated valuable portions of the spectrum

plot_led <- ggplot(data = LED_Phillips_BR30, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") + 
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme(base_size = 8) +
  ggtitle("LED Phillips BR30 SPD")

plot_led_p <- ggplot(data = LED_Phillips_BR30, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") + 
  geom_area(data = LED_Phillips_BR30_p, mapping = aes(x=Wavelength, y=PWeightedRadiativeFlux), fill = "red") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme(base_size = 8) +
  ggtitle("P-Weighted LED Phillips BR30 SPD")

plot_led_u <- ggplot(data = LED_Phillips_BR30, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") + 
  geom_area(data = LED_Phillips_BR30_u, mapping = aes(x=Wavelength, y=UWeightedRadiativeFlux), fill = "red") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme(base_size = 8) +
  ggtitle("U-Weighted LED Phillips BR30 SPD")

plot_led_v <- ggplot(data = LED_Phillips_BR30, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") + 
  geom_area(data = LED_Phillips_BR30_v, mapping = aes(x=Wavelength, y=VWeightedRadiativeFlux), fill = "red") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme(base_size = 8) +
  ggtitle("V-Weighted LED Phillips BR30 SPD")

plot_led_ca <- ggplot(data = LED_Phillips_BR30, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") + 
  geom_area(data = LED_Phillips_BR30_ca, mapping = aes(x=Wavelength, y=Chlorophyll_aWeightedRadiativeFlux), fill = "red") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme(base_size = 8) +
  ggtitle("Ca-Weighted LED Phillips BR30 SPD")

plot_led_cb <- ggplot(data = LED_Phillips_BR30, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") + 
  geom_area(data = LED_Phillips_BR30_cb, mapping = aes(x=Wavelength, y=Chlorophyll_bWeightedRadiativeFlux), fill = "red") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme(base_size = 8) +
  ggtitle("Cb-Weighted LED Phillips BR30 SPD")

plot_led_m <- ggplot(data = LED_Phillips_BR30, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") + 
  geom_area(data = LED_Phillips_BR30_m, mapping = aes(x=Wavelength, y=MelanopsinWeightedRadiativeFlux), fill = "red") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme(base_size = 8) +
  ggtitle("M-Weighted LED Phillips BR30 SPD")

plot_led_ph <- ggplot(data = LED_Phillips_BR30, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area(fill = "blue") + 
  geom_area(data = LED_Phillips_BR30_ph, mapping = aes(x=Wavelength, y=PhotosynthWeightedRadiativeFlux), fill = "red") +
  scale_y_continuous(limits = c(0, 0.125)) +
  xy_theme(base_size = 8) +
  ggtitle("Ph-Weighted LED Phillips BR30 SPD")

# Compiling the individual plots into a composite graph

plot_grid(nfunction, plot_inc, plot_led, vspectrum, plot_inc_v, plot_led_v, pfunction, plot_inc_p, plot_led_p, melanopsin, plot_inc_m, plot_led_m, ufunction, plot_inc_u, plot_led_u, photosyn, plot_inc_ph, plot_led_ph, ncol = 3, labels = "AUTO")

