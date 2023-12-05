renamingcols <- function(penguins_raw) {
  penguins_raw %>% 
    rename("body_mass_g" = "Body Mass (g)", "culmen_depth_mm" = "Culmen Depth (mm)")
  
}
penguinsclean <- renamingcols(penguins_raw)


shorten_species <- function(penguinsclean) {
  penguinsclean %>%
    mutate(Species = case_when(
      Species == "Adelie Penguin (Pygoscelis adeliae)" ~ "Adelie",
      Species == "Chinstrap penguin (Pygoscelis antarctica)" ~ "Chinstrap",
      Species == "Gentoo penguin (Pygoscelis papua)" ~ "Gentoo"
    ))
}
penguinscleaner <- shorten_species(penguinsclean)


removingnas <- function(penguinscleaner) {
  penguinscleaner %>%
    filter(!is.na(body_mass_g)) %>%
    filter(!is.na(culmen_depth_mm)) %>%
    filter(!is.na(Species))
}
penguinscleanest <- removingnas(penguinscleaner)

penguins_cleanest <- penguins_raw %>% renamingcols() %>% 
                                      shorten_species()%>% 
                                        removingnas()
View(penguins_cleanest)

