# reprodresearch
https://rpubs.com/a1065094/1125146
Attached is the link to access my HTML document as a whole as it is too large for GitHub to process.
---
title: "Penguins"
author: "anon"
date: "2023-12-01"
output:
  html_document:
    df_print: paged
---

## Question 3
C) I was particularly impressed with the cleaning section of the code since the student made use of new inclusions within the code learnt from the session to help improve the cleaning process. I also enjoyed the presence of interactive plots which made me feel like I was getting the necessary information from the graph as a whole since it was easy to see the overall distribution, but also specific detail was available if needed. This helped me then see how they were answering their biological question from the code which is great! I also think an appropriate test was chosen for the type of variables that they were using (ANOVA). I was pleasantly surprised to see a post-hoc test being conducted too! (Tukey HSD).
- <div>Did it run?</div> 
Yes, I downloaded the markdown from the GitHub and ran it in my RStudio. I then found that there was a slight issue with regards to the naming of the chunks within the curly brackets. This would result in an error, where it referred to a zero-length variable name, however the code would work when just the code was ran! Therefore, I ran it in chunks and made sure the notes about the discussion and such would not interfere with the process.

-	<div>Any suggestions?</div>
One suggestion would be to either justify or remove the density function on the interactive violin plot. Although the interaction of the points are very useful to understand the data, it is hard to see how the density provides sufficient information and this has not been mentioned within the comments. Another suggestion would just be to remove the names of chunks within the {r} so the markdown can run all at once. Perhaps it would be useful to have a few more comments on the interpretation of the ANOVA or steps taken in general, because although there were some comments, it would make it more understandable for someone who may not be from a biological background. An AIC could have also been conducted to justify the use of the ANOVA.

-<div>If need to alter, would be easy or not?</div>
I think it would be easy to alter the figures of my partner since there are comments on almost each line or before the code is conducted to give sufficient context. The code is also quite clear and not complex, so it would be straightforward for me! I particularly liked the way a comment clarified how alpha must be altered to have differing transparency so that we can avoid over plotting. 

```{r setup, include=FALSE}
library(pacman)
p_load("palmerpenguins", "dplyr", "janitor", "ggplot2", "tidyverse", "plotly")
# I installed pacman to ensure I can make use of the p_load function, so that I can load multiple packages in at once without repeating the same code, which may make the process more efficient since I am less likely to make a mistake.

head(penguins_raw)
View(penguins_raw)
# I also used the View() function to have a look at the data as a whole to help me guide the cleaning processes as part of the final analysis.
```

```{r}
# To begin with my 'bad' plot is a grouped bar graph to show the distribution of different species on their respective islands. This graph can mislead the reader about the data since the bars are stacked on top of each other so it can give the wrong impression about the mean body mass per species on the island. Stacked bars are quite complex and therefore it is hard to interpret differences between species well and their respective contribution to the overall bar. This misunderstanding is further catalysed when comparing against the islands as one may assume the height of the bar represents the sum rather than the mass per species. Additionally, since mean body mass is used, the variation in the body mass may not be represented well as extreme values will just skew the mean but this would not be clearly visualised and therefore is hard to notice without the raw data.

# Perhaps it would have been better with a piece of code, such as: position = "dodge", within the geom_bar() aesthetics to separate the bars per species on the island. Feel free to add that in and see how the graph looks! It is still not completely clear as the width of the bars are still quite large, but it does help provide a clearer image.

# Additionally, the colours chosen are not accessible since this affects people with red-green colour-blindness, so it would be hard for them to discern the difference between where each species starts and ends, and this is still a problem even when position = “dodge” is added.

# A good plot tends to follow four main rules: clear graphics, accurate magnitude representation, patterns displayed well and clear data display. This graph violates all of them.

ggplot(penguins_raw, aes(x = Island, y = `Body Mass (g)`, fill = Species)) +
  geom_bar(stat = "summary", fun = "mean") +
  labs(title = "Mean Body Mass by Penguin Species Across Islands",
       x = "Island", y = "Mean Body Mass") + scale_fill_manual(values = c("Adelie Penguin (Pygoscelis adeliae)" = "red", "Chinstrap penguin (Pygoscelis antarctica)" = "green", "Gentoo penguin (Pygoscelis papua)" = "blue")) + theme_minimal()
```


```{r}
write.csv(penguins_raw, "data/penguins_raw.csv") 
# This is the step to load in the data. It is then converted into a csv file and saved in my R project directory so that anyone can access it which makes it reproducible. This is because it is not saved directly to my computer. penguins_raw is a file within the Palmer penguins data set, which is why I can just use the head function on it. I did this so that I can see what is within the data set, so I can begin considering my hypotheses and how this will shape my graph as it will be a visual representation to answer my question. 

penguinscols <- colnames(penguins_raw)
penguinscols
# In this step, I was finding out what all the column names of the dataset are so that I could use this to streamline my investigation and understand what question I wanted to answer.
# Based on this, I found that the only remaining columns I could work with were: body mass, culmen length or depth, and flipper length. Initially, I wanted to investigate whether body mass varies across islands with species, however I discovered that this was not feasible.
```
```{r}
## Introduction: 
# Does size always correlate with size? Although this sounds like a peculiar question, one may argue this is a valid and pertinent question to ask. This is because this misunderstood principle is often used as preliminary research within the biological field. For example, when understanding neural networks, it is often assumed a bigger brain may correlate with increased intelligence based on an assumption that more connections are formed due to a larger volume. However, based on recent research, this seems to have been strongly opposed, for example: fruit flies, although small have complex neural networks as opposed to the hippopotamus. (Nave et al, 2018) [1].
# Therefore, this was the driving factor for my question, does culmen depth correlate with a larger body mass?
# This was based on what was available on the palmer penguin dataset. I initially set out to see how body mass varies with the species dependent on what island they are on. However, I discovered that there is an uneven distribution of species across the hypothetical islands. Therefore, I chose to look at culmen depth, as based on previous studies done in chicks they found that the dimensions of the beak correlates with body mass (Fahey et al, 2007) [2] I chose not to do culmen length, since depth intrigued me more as it leads one to think that it would help create an increased volume and therefore allow more food to enter within the beak and hence contribute to a heavier body mass. This could be an evolutionary adaptation. Although one may argue that culmen length has a similar function; despite my interests to study depth, I also found most papers tend to focus on length correlations with body mass, therefore wanted to see if a similar trend is found with depth and body mass (McDonald et al, 2003 & Rizzolo et al, 2015). [3,4] I could have also looked at the interaction of depth and length, but I feared this may convolute the data and trends, so I chose to focus on one variable.
# I later also look at the interaction of culmen depth and body mass with the species to see if there are any species-specific trends. 

## Hypothesis:
# Null hypothesis: There will be no significant effect between culmen depth, measured in mm and body mass measured in grams. 
# -	There will be no significant interaction between the correlation between the culmen depth and body mass and the species of the penguin.

# Alternative hypothesis: There will be a significant effect between culmen depth, measured in mm and body mass measured in grams.
# -	There will be a significant interaction between the correlation between the culmen depth and body mass and the species of the penguin.
```

```{r}
source("functions/RRassignmentcleaningfunctions.R")
# This line of code will retrieve my functions I need to clean the data.
```
```{r}
# After this, I decided to clean my data so that it would be easier to work with and for others to also use, with different functions that are clearly labelled. For example, this function renames the columns I will be using for the rest of my analysis. This needs to be done because it makes it easier for the computer to work with, since spaces are difficult and we still want to make it user-friendly readable too.

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
# This second function shows us how we shortened the species names to remove their scientific names, as this also makes it easier for the user and the computer to deal with to reduce errors.
penguinscleaner <- shorten_species(penguinsclean)

# One of my final steps of cleaning the data, was to remove any columns or rows that had the value NA since this would disrupt any downstream graph producing processes. As you can see, we are also not making continual updates to one dataset, but rather producing improved versions of datasets each time, if you refer to the function R script, so we do end up with a final cleaned dataset.
removingnas <- function(penguinscleaner) {
  penguinscleaner %>%
    filter(!is.na(body_mass_g)) %>%
    filter(!is.na(culmen_depth_mm)) %>%
    filter(!is.na(Species))
}
penguinscleanest <- removingnas(penguinscleaner)

#If using the source file, you can go straight from the raw to cleanest without intermediate datasets to show the process.
penguins_cleanest <- penguins_raw %>% renamingcols() %>% 
                                      shorten_species()%>% 
                                        removingnas()
View(penguins_cleanest)

# I loaded in the R script which has the functions within it to help clean the data.

# I could then load this clean data into the same directory so it can accessible for all.
# write.csv(penguins_cleanest, "data/penguins_cleanest.csv")

# This step is used to subset the data to just get the relevant columns I am working with.
massanddepth <- penguins_cleanest[, c("body_mass_g", "culmen_depth_mm", "Species")]

View(massanddepth)
```    


```{r}
## Figure 1A.
# Now that our data is adequately clean, we can produce a similar scatter plot.
# In this piece of code, we are initially creating the slider. This will be used to visualise each species at a time, so we need to define them first, assign a colour and then the label to it for each species.
steps <- list(
  list(
    args = list("marker.color", list("pink", "rgba(0,0,0,0)", "rgba(0,0,0,0)")),
    label = "Adelie",
    method = "restyle",
    value = "Adelie"
  ),
  list(
    args = list("marker.color", list("rgba(0,0,0,0)", "gold", "rgba(0,0,0,0)")),
    label = "Gentoo",
    method = "restyle",
    value = "Gentoo"
  ),
  list(
    args = list("marker.color", list("rgba(0,0,0,0)", "rgba(0,0,0,0)", "lightblue")),
    label = "Chinstrap",
    method = "restyle",
    value = "Chinstrap"
  )
)

# Then I created a trace for each one, this just makes use of the filter function and plots only that scatter plot within its own space.
trace_adelie <- massanddepth %>%
  filter(Species == "Adelie") %>%
  plot_ly(x = ~culmen_depth_mm, y = ~body_mass_g, mode = "markers", type = "scatter", marker = list(color = "pink"), showlegend = FALSE) 

trace_gentoo <- massanddepth %>%
  filter(Species == "Gentoo") %>%
  plot_ly(x = ~culmen_depth_mm, y = ~body_mass_g, mode = "markers", type = "scatter", marker = list(color = "gold"), showlegend = FALSE)

trace_chinstrap <- massanddepth %>%
  filter(Species == "Chinstrap") %>%
  plot_ly(x = ~culmen_depth_mm, y = ~body_mass_g, mode = "markers", type = "scatter", marker = list(color = "lightblue"), showlegend = FALSE)

# However, to be able to see them all at once, I needed to make a list so I can display them.
traces <- list(trace_adelie, trace_gentoo, trace_chinstrap)

# Then I place all of these steps together to create an overall scatter plot that is the first part of my exploratory figure, so I can see them all on one graph and relative to each other.
scatterpenguins <- subplot(
  traces, 
  shareX = TRUE, 
  shareY = TRUE, 
  nrows = 3, 
  margin = 0.05
) %>%
  layout(
    title = "Species Scatter Plot",
    sliders = list(
      list(
        active = 1,
        currentvalue = list(prefix = "Species: "),
        pad = list(t = 60),
        steps = steps
      )
    )
  )

scatterpenguins  
```
```{r}
## Figure 1B
# However, I later realised this was not completely effective, so I made use of the facet_wrap() function and fit a smoothing line to understand the general trend better and allow a clearer comparison. So although it is a similar scatter plot, it is arguably clearer. Since it is exploratory, I chose not to relabel the lines.
source("functions/RRassignmentplottingfunctions.R")
speciesscatter <- function(massanddepth) {ggplot(massanddepth, aes(x = body_mass_g, y = culmen_depth_mm, colour = Species)) + 
  geom_point() + 
  geom_smooth(method = lm, formula = y ~ x) + 
  facet_wrap(~Species) + scale_colour_manual(values = c(Adelie = "pink", Gentoo = "gold", Chinstrap = "lightblue"))
}
speciesscatter(massanddepth)
```
![CAPTION](https://github.com/1065094/reprodresearch/blob/5642aba8239518f9871aa1848ae9e78fe541f158/facetwrapped.pdf)

```{r}
#Beginning a statistical test.
#Doing a linear regression and ANOVA to understand interactions.
#Fit an ANOVA model, checking initially if the data is normally distributed and has homogeneity of variance to ensure it can still be conducted. Once checked, we can see it does abide by these and therefore we can conduct the statistical test.
## FIGURE 2A, B & C (ANOVA, Residuals, QQ)
model <- lm(body_mass_g ~ culmen_depth_mm * Species, data = massanddepth)
updatedmodel <- aov(model)
summary(updatedmodel)
plot(model, which = 1)
plot(model, which = 2)
massanddepth <- massanddepth %>%
  mutate(Species = as.factor(Species))

# Linear regression - FIGURE 2D, E & F (R^2 calculations and quartiles from linear regression)
adelier <- massanddepth %>% filter(Species == "Adelie") %>% lm(culmen_depth_mm ~ body_mass_g, data = .)
summary(adelier)
AIC_Adelie <- AIC(adelier)
AIC_Adelie

chinstrapr <- massanddepth %>% filter(Species == "Chinstrap") %>% lm(culmen_depth_mm ~ body_mass_g, data = .)
summary(chinstrapr)
AIC_Chinstrap <- AIC(chinstrapr)
AIC_Chinstrap

gentoor <- massanddepth %>% filter(Species == "Gentoo") %>% lm(culmen_depth_mm ~ body_mass_g, data = .)
summary(gentoor)
AIC_Gentoo <- AIC(gentoor)
AIC_Gentoo

# The species followed by r are named as such since I was mainly interested in the R^2 value. However, I later found relevance to other values from the summary table.

# I conducted an AIC to see if a certain species may explain the relationship between the variables better, and it seems Chinstrap does as it has the lowest AIC but we cannot definitely say that. This also indicates towards the fit and simplicity of the model too and variation between species models in general.

## Stats Method:
# The methods I used to analyse the data was an ANOVA. The reason I did this was to see the interaction between the two variables: body mass and culmen depth with species. Therefore, I fit a linear regression to understand what is happening and then ran an ANOVA. As aforementioned, I checked that it met the necessary assumptions. Since I was looking at the interactions from a linear regression, there was no need to calculate a mean. I also thought it was worth looking at the R^2 value to understand how strongly correlated the two variables were per species.

## Results:
# Looking at Figure 1B, which shows the correlation, it is easy to spot that there is a positive correlation, which could be argued to be strong. There is some scattering of points, and it would be worth conducting a regression test to see if there is significance. 
# If we consider Figure 2C, which is the ANOVA table, you can see, there is significance in the variables alone and in the interaction. We can see that culmen depth significantly interacts with body mass. Therefore, as body mass increases, culmen depth also increases significantly. 
# Similarly, there is increased body mass per species. Although the ANOVA does not directly tell us which species is the ‘largest’, we can see that there is a significant difference between each species in terms of body mass.
# Finally, we can see that the interaction between culmen depth and species is significant.
# However, it is hard to tell if there is a particular species that is skewing the significant interaction and therefore further research can be done to better subset the data to understand if there is a driving species or if it is an equal contribution. All significant values are very significant which is promising. However, it would have been better to include an AIC test to see what type of ANOVA is most appropriate (interaction or two-way), for example: two-way or interactional. It would also be useful to do a post hoc test, like TukeyHSD.
# With regards to Figure 3A/B, this is a violin plot, showing the of the culmen depth with body mass per species and you can see all the points, as well as the boxplot, which shows how I used the exploratory figure and the results from the ANOVA and regression to inform my choice of plot.

```
```{r}
## Figure 3A
# This is a violin plot to show the distribution of the data with the points and boxplot included. I decided to stick to a consistent colour theme. I also adjusted the transparency of the dots, so you can see the overall distribution better. I thought this was a useful visual aid based on the results of the ANOVA, since you can how the points vary around the distribution.

pcplot <- ggplot(massanddepth, aes(x = culmen_depth_mm, y = body_mass_g, fill = Species)) +
  geom_violin(trim = FALSE, scale = "width", alpha = 0.6) +
  labs(title = "Violin Plot of Body Mass by Culmen Depth", x = "Culmen Depth (mm)", y = "Body Mass (g)") +
  scale_fill_manual(values = c("Adelie" = "#F799D6", "Chinstrap" = "#50C7C7", "Gentoo" = "#D3DB58")) +
  theme_minimal() +
  geom_point(aes(colour = Species), alpha = 0.4) +  scale_colour_manual(values = c("Adelie" = "#F799D6", "Chinstrap" = "#50C7C7", "Gentoo" = "#D3DB58")) +
  facet_wrap(~Species)
pcplot
```

```{r}
## Figure 3B
# I then thought it would be useful to further build upon that with a boxplot so you can visualise the quartiles provided by the test also and see how this works in relation to the violin plot. This also helps us detect any outliers well too. I thought this would be appropriate too since I used the ANOVA so I can display the quartile information provided from this and the linear regression tests.
pcplotwbox <- pcplot +
  geom_boxplot(width = 0.2, position = position_dodge(width = 0.75), alpha = 0.8, color = "black")

pcplotwbox

# Rendering the figure so it can be zoomed into and not be pixelated.
library(svglite)
# svglite("Insert file path", width = , height =)
# pcplotwbox
# dev.off()
# Here we have an option for you to save the figure to your computer but in svg format, so that when you zoom it, it still remains clear. To run it remove the hashtags!
```  

```{r}
## FIGURE 3C
# This is a button to make it interactive and turn on the ability to see the points or not. I thought it would be useful to have this option and wanted to apply some new coding skills. However, I faced challenges within this section, as when applying the boxplot layer, each point would become its own boxplot, therefore the interactive layer is only created with pcplot and not pcplotly.
penguininteractive <- ggplotly(pcplot)

# Add a button to toggle the visibility of points
penguininteractive <- penguininteractive %>%
  layout(
    updatemenus = list(
      list(
        type = "buttons",
        buttons = list(
          list(method = "restyle",
               args = list("visible", list(TRUE)),
               label = "Show Points"),
          list(method = "restyle",
               args = list("visible", list(FALSE)),
               label = "Hide Points")
        ),
        showactive = TRUE,
        direction = "down",
        x = 0.1,
        xanchor = "left",
        y = 1.1,
        yanchor = "top"
      )
    )
  )

penguininteractive
#For transparency: plots are named based on penguinscleaner if pc, plotly refers to the package to make it interactive and wbox shows it has a boxplot with it.

## Discussion:
# Therefore, we can see that based on the introduction mentioned at the beginning, the evolutionary theory that increased volume for food will cause an increase in size has significant evidence to support this. However, we cannot tell if this is completely representative as this is assuming that there is sufficient resources to allow the penguin to make full use of the culmen depth available. Additionally, this is not completely representative as the evidence only comes from this one dataset, which refers to penguins; therefore more research needs to be done within other species, but also specifically for culmen depth and not just length! Finally, it would be worth considering if there is a disadvantage to having this correlation, as there may be a trade-off with a larger culmen that we are unaware of. For example, for some male species maximising on sexual displays may impact their immune responses due to a difference in hormones – the handicap theory. One could argue that perhaps there is a sexual basis for this too, a deeper culmen could be more attractive as it indicates the ability to get more food, this is another area that could be further prodded. However, is there a limit to this due to penguin morphology. These are only some of the many things we should consider.

## Conclusion:
# In conclusion, you can see that body mass seems to significantly correlate with culmen depth and therefore may provide evidence for the theory that bigger is better. However, as we know from previous research in other instances, that this is not entirely true. Therefore, further research needs to be conducted to verify that this hypothesis is true in the wider picture. It would also be useful to see if we could do time related studies to see if there has truly been some adaptive evolution for increased culmen depth.
# However, with regards to the bigger picture, it would be useful to see if this significance results in practical implications. For example, could this result in increased survival for the penguin or is there a known ecological advantage for having a larger body mass and culmen depth. Is there a ratio that we could calculate that could be indicative to some extent of penguin fitness as a proxy?

## References:
# 1)	Nave, G., Jung, W. H., Karlsson Linnér, R., Kable, J. W., &#38; Koellinger, P. D. (2018). Are bigger brains smarter? Evidence from a large-scale preregistered study. Psychological Science, 30(1), 43–54. https://doi.org/10.1177/0956797618808470
# 2)	Fahey, A. G., Marchant-Forde, R. M., Cheng, H. W. (2007). Relationship between body weight and beak characteristics in one-day-old white leghorn chicks: Its implications for beak trimming. Poultry Science, 86(7), 1312–1315. https://doi.org/10.1093/ps/86.7.1312
# 3)	McDonald, P. G. (2003). Nestling growth and development in the brown falcon, Falco berigora: An improved ageing formula and field-based method of sex determination. Wildlife Research, 30(4), 411. https://doi.org/10.1071/wr02041
# 4)	Rizzolo, D. J., Schmutz, J. A., Speakman, J. R. (2015). Fast and efficient: Postnatal growth and energy expenditure in an Arctic-breeding waterbird, the Red-throated Loon (Gavia stellata). The Auk, 132(3), 657–670. https://doi.org/10.1642/auk-14-261.1

```




