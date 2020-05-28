## INC Globe A19 Lamp

# Calculating the photopically weighted radiative flux

INC_Globe_A19_p <- INC_Globe_A19[,2]*Luminosity_functions[,2]

INC_Globe_A19_p <- cbind(Wavelength_vector, INC_Globe_A19_p)

colnames(INC_Globe_A19_p) <- c("Wavelength", "PWeightedRadiativeFlux")

View(INC_Globe_A19_p)

# Calculating the universally weighted radiative flux

INC_Globe_A19_u <- INC_Globe_A19[,2]*Luminosity_functions[,3]

INC_Globe_A19_u <- cbind(Wavelength_vector, INC_Globe_A19_u)

colnames(INC_Globe_A19_u) <- c("Wavelength", "UWeightedRadiativeFlux")

View(INC_Globe_A19_u)

# Calculating the radiative flux within the visible spectrum

INC_Globe_A19_v <- INC_Globe_A19[,2]*Luminosity_functions[,4]

INC_Globe_A19_v <- cbind(Wavelength_vector, INC_Globe_A19_v)

colnames(INC_Globe_A19_v) <- c("Wavelength", "VWeightedRadiativeFlux")

View(INC_Globe_A19_v)

# Calculating the Chlorophyll_a

INC_Globe_A19_ca <- INC_Globe_A19[,2]*Luminosity_functions[,5]

INC_Globe_A19_ca <- cbind(Wavelength_vector, INC_Globe_A19_ca)

colnames(INC_Globe_A19_ca) <- c("Wavelength", "Chlorophyll_aWeightedRadiativeFlux")

View(INC_Globe_A19_ca)

# Calculating the Chlorophyll_b

INC_Globe_A19_cb <- INC_Globe_A19[,2]*Luminosity_functions[,6]

INC_Globe_A19_cb <- cbind(Wavelength_vector, INC_Globe_A19_cb)

colnames(INC_Globe_A19_cb) <- c("Wavelength", "Chlorophyll_bWeightedRadiativeFlux")

View(INC_Globe_A19_cb)

# Calculating the Melanopsin

INC_Globe_A19_m <- INC_Globe_A19[,2]*Luminosity_functions[,7]

INC_Globe_A19_m <- cbind(Wavelength_vector, INC_Globe_A19_m)

colnames(INC_Globe_A19_m) <- c("Wavelength", "MelanopsinWeightedRadiativeFlux")

View(INC_Globe_A19_m)

## LED Phillips BR30 Lamp

# Calculating the photopically weighted radiative flux

LED_Phillips_BR30_p <- LED_Phillips_BR30[,2]*Luminosity_functions[,2]

LED_Phillips_BR30_p <- cbind(Wavelength_vector, LED_Phillips_BR30_p)

colnames(LED_Phillips_BR30_p) <- c("Wavelength", "PWeightedRadiativeFlux")

View(LED_Phillips_BR30_p)

# Calculating the universally weighted radiative flux

LED_Phillips_BR30_u <- LED_Phillips_BR30[,2]*Luminosity_functions[,3]

LED_Phillips_BR30_u <- cbind(Wavelength_vector, LED_Phillips_BR30_u)

colnames(LED_Phillips_BR30_u) <- c("Wavelength", "UWeightedRadiativeFlux")

View(LED_Phillips_BR30_u)

# Calculating the radiative flux within the visible spectrum

LED_Phillips_BR30_v <- LED_Phillips_BR30[,2]*Luminosity_functions[,4]

LED_Phillips_BR30_v <- cbind(Wavelength_vector, LED_Phillips_BR30_v)

colnames(LED_Phillips_BR30_v) <- c("Wavelength", "VWeightedRadiativeFlux")

View(LED_Phillips_BR30_v)

# Calculating the Chlorophyll_a

LED_Phillips_BR30_ca <- LED_Phillips_BR30[,2]*Luminosity_functions[,5]

LED_Phillips_BR30_ca <- cbind(Wavelength_vector, LED_Phillips_BR30_ca)

colnames(LED_Phillips_BR30_ca) <- c("Wavelength", "Chlorophyll_aWeightedRadiativeFlux")

View(LED_Phillips_BR30_ca)

# Calculating the Chlorophyllb

LED_Phillips_BR30_cb <- LED_Phillips_BR30[,2]*Luminosity_functions[,6]

LED_Phillips_BR30_cb <- cbind(Wavelength_vector, LED_Phillips_BR30_cb)

colnames(LED_Phillips_BR30_cb) <- c("Wavelength", "Chlorophyll_bWeightedRadiativeFlux")

View(LED_Phillips_BR30_cb)

# Calculating the Melanopsin

LED_Phillips_BR30_m <- LED_Phillips_BR30[,2]*Luminosity_functions[,7]

LED_Phillips_BR30_m <- cbind(Wavelength_vector, LED_Phillips_BR30_m)

colnames(LED_Phillips_BR30_m) <- c("Wavelength", "MelanopsinWeightedRadiativeFlux")

View(LED_Phillips_BR30_m)

