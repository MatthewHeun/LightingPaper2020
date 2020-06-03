myPalette <- colorRampPalette(rev(brewer.pal(11, "Spectral")))
sc <- scale_colour_gradientn(colours = myPalette(1253), limits=c(0, 1253))

plot_inc_test <- ggplot(data = INC_Globe_A19, mapping = aes(x=Wavelength, y=RadiativeFlux)) + 
  geom_area() + 
  scale_y_continuous(limits = c(0, 0.125)) +
  scale_colour_gradientn(colours = c("red","yellow","green","lightblue","darkblue"),
                         values = c(1.0,0.8,0.6,0.4,0.2,0)) +
  ggtitle("Test INC Globe A19 SPD")

plot(plot_inc_test)
