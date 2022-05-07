# A Fertility Journal #
# This visual is dedicated to my two babies I've unfortunately lost, my support system that has been with me through #
# this entire thing, and my rainbow baby who we're anxiously awaiting for <3 #

# Library Load-In====
library(tidyverse)
library(readxl)
library(showtext)
library(ggtext)
library(ggimage)

# Data Load-In====
data <- read_excel("data/med_data.xlsx")

# Font Load-in====
font_add_google('Shadows Into Light')
font_add_google('Work Sans')
showtext_auto()

# Data Transformation====
summarized_data <- data %>%
  group_by(Event) %>%
  count(name = "Total") %>%
  filter(Total > 1) %>%
  filter(Event != "Office Consultation") %>%
  mutate(Event = case_when(Event == "IUI" ~ "Intrauterine Inseminations",
                           Event == "Bloodwork" ~ "Blood Draws",
                           Event == "Ultrasound" ~ "Ultrasounds",
                           TRUE ~ Event)) %>%
  ungroup() %>%
  add_row(Event = "Miscarriages", Total = 18) %>%
  add_row(Event = "Baby Harris\nComing Nov. 2022", Total = 15) 

# Pulling out actual event values
actual_totals <- sort(summarized_data$Total, decreasing = TRUE)
actual_totals[3:4] = c(2,1)
actual_totals <- sort(actual_totals, decreasing = TRUE)


# Pulling out events for groupings
event_groups <- 1:5

# Adjusting the IUI count for easier readability
summarized_data$Total[summarized_data$Event == "Intrauterine Inseminations"] <- 20

# Adjusting the Miscarriage count for easier readability
summarized_data$Total[summarized_data$Event == "Miscarriages"] <- 17

summarized_data <- summarized_data %>%
  arrange(Total) %>%
  mutate(text = c("The last 3 years have been difficult and traumatizing, but this right here makes it worth it. Deep down, We're terrified to share this good news as me are educated on all the 'bad' things that can happen. At this point in the journey, we are choosing excitment and happiness, and hoping for the best.", 
                  "The hardest things I ever went through in my life. I can't describe the feeling of going through a miscarriage, but it hurts. I never knew that I could experience pain at this level.",
                  "Also known as Artifical Insemination. This is a standard procedure prescribed to patients that present with uneplained infertility. The procedure is done inside a medical office. Sperm is tested and washed before being inserted into the uterus via a catheter.",
                  "Transvaginal ultrasounds are done ALOT. Especially if doing intrauterine inseminations or injectable hormone treatments. Because of this, infertility patients can visually confirm as early as 4-5 weeks that they are pregnant.",
                  "Your blood is drawn ALOT during infertility treatments to measure hormone levels and confirm pregnancy. The amount of blood draws increase if a patient is taking hormonal injections and if pregnancy needs to be confirmed. I've personally experienced something informally called 'Beta Hell' where beta pregnancy hormone levels are continually measured via blood draw every two days after a positive home pregnany test is recieved. If your beta levels are not high enough or not doubling fast enough a miscarriage may be imminent."))
  

# Getting event names
events = rev(summarized_data$Event)

# Setting totals for graphing
event_totals <- summarized_data$Total

# Setting up circle colors
circle_colors <- c("#612884", "#277e9d", "#488e35", "#e3a934", "#b51c14")

# Setting up the background colors
bkgd_colors <- "#000000"

# Border colors
border_colors <- c("#ffffff", rep("#000000",4))

#Equalizers
circle_equalizers <- 38 - event_totals

#Circle sizes
circle_sizes <- event_totals 

# Viz Data====
#Base Circle#
theta <- seq(0,2*pi, length.out = 1000)
circle <- tibble(x = cos(theta),
                 y = sin(theta))

#Creating categories#
all_circles <- pmap_df(list(event_totals,
                            event_groups,
                            circle_colors,
                            circle_equalizers,
                            border_colors), ~circle %>%
                                    mutate(y = y*..1,
                                           x = x*..1,
                                           y = y - ..4,
                                           group = ..2,
                                           fill = ..3,
                                           color = ..5))

# Loading in baby 💓#
baby <- "baby harris.png"

# Putting baby in a data frame #
baby_harris <- tibble(x = 0, 
                      y = -31.5, 
                      image = baby)
                      

final <- all_circles %>%
  ggplot(aes(x = x, y = y, group = rev(group))) +
  theme_void() +
  geom_polygon(fill = all_circles$fill, color = all_circles$color) +
  geom_text(data = summarized_data, aes(x = 0, y = c(30,10,-2.5,-6.5,-18), label = paste(actual_totals, events)),
            family = 'Shadows Into Light', size = c(8,8,4,3.7,7), fontface = "bold", color = rev(border_colors), inherit.aes = FALSE)+
  geom_image(data = baby_harris, aes(x,y, image = image), size = .18, inherit.aes = FALSE)+
  theme(plot.background = element_rect(fill = bkgd_colors),
        plot.title = element_text(family = 'Shadows Into Light', color = "white", size = 50, hjust = .5, vjust = .1),
        plot.subtitle = element_textbox_simple(family = 'Work Sans', color = "white", size = 10, margin = margin(80,10,70,10) )) +
  labs(title = "A Fertility Journey",
       subtitle = " According to the United States Center for Disease Control and Prevention, Infertility is defined as not being able to get pregnant (conceive) after one year (or longer) of\nunprotected sex. This can create anxiety and stress for individuals that are actively trying to get pregnant and haven't within one year. So much is unknown to the general public about how complicated the scientific process of pregnancy is. Most that go through infertility treatment are thrown into a world of exhaustion, anxiety, stress, and bewilderment.\n\nNo fertility journey&nbsp;is identical. The process can take as little as a few months, or as long as multiple years. The longer an individual is in infertility treatment, the more susceptible they are to developing anxiety, depression, and other mental difficulties.\n\nBecause this topic is so taboo and data is still lacking in the field, I've decided to create my own. After 3 years of actively trying to conceive, mental breakdowns, sleepless nights, and constant medical visits, this is the result of my personal fertility journey...")+
  coord_equal()

ggsave("A_Fertility_Journey/www/final_plot.png", final,
       width = 500,
       height = 2000,
       units = "px",
       bg = "#000000")


