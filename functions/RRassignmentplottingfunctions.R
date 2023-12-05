# This is my function to create the facet wrapped scatter plots.
speciesscatter <- function(massanddepth) {ggplot(massanddepth, aes(x = body_mass_g, y = culmen_depth_mm, colour = Species)) + 
    geom_point() + 
    geom_smooth(method = lm, formula = y ~ x) + 
    facet_wrap(~Species) + scale_colour_manual(values = c(Adelie = "pink", Gentoo = "gold", Chinstrap = "lightblue"))
}
speciesscatter(massanddepth)

# This is my function to create my initial violin plot.
speciesviolin <- function(massanddepth) {
  pcplot <- ggplot(massanddepth, aes(x = culmen_depth_mm, y = body_mass_g, fill = Species)) +
    geom_violin(trim = FALSE, scale = "width", alpha = 0.6) +
    labs(title = "Violin Plot of Body Mass by Culmen Depth", x = "Culmen Depth (mm)", y = "Body Mass (g)") +
    scale_fill_manual(values = c("Adelie" = "#F799D6", "Chinstrap" = "#50C7C7", "Gentoo" = "#D3DB58")) +
    theme_minimal() +
    geom_point(aes(colour = Species), alpha = 0.4) +  scale_colour_manual(values = c("Adelie" = "#F799D6", "Chinstrap" = "#50C7C7", "Gentoo" = "#D3DB58")) +
    facet_wrap(~Species)
  pcplot
}
speciesviolin(massanddepth)

# I did not create a function to add the boxplot as that is just one more line or for the interactivity sections as it may be clearer to understand how those
# were done based on understanding the code since it is less straightforward and therefore needs comments within the RMD to support it.