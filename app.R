# A fertility Journey <3

# Library Load-in====
library(shiny) # For making the app


# Defining a simple UI for displaying an image behind a pop-up dialog box===
ui <- fluidPage(id = 'test',
                tags$style('#test {
                             background-color: #000000;}'),
                
    # Modal dialog boxes gives a pop-up dialog box on the shiny app. 
    # Style settings can be adjusted for individual needs. 
    # These options completely hides the visual UNLESS the user clicks the green button
    
    modalDialog(title = "Content Warning",
                tags$head(tags$style(".modal-dialog{ width:50vw}")),
                tags$head(tags$style(".modal-body{ min-height:100%}")),
                tags$head(tags$style(".modal-backdrop{ opacity:1 !important;}")),
                span("The visual on this page mentions topics that may be sensitve or triggering for some like miscarriages, infertility, and pregnancy. If you do not wish to view this material please close this window or press the 'Back' button on your browser to exit."),
                footer = HTML('<button style="position: relative; center: 0%; background-color: #4CAF50;" type="button"  data-dismiss="modal" data-bs-dismiss="modal">Show the Visual (Continue)</button>
                              '),
                size = c("s"),
                easyClose = FALSE,
                fade = TRUE),
    
    
    # Simply placing an externally made image into the shiny UI====
    
    HTML("<center>"), 
    HTML("<img src = 'background.png', alt= 'A Fertility Journey: A rainbow-colored stacked bubble chart with the following text above it: According to the United States Center for Disease Control and Prevention, Infertility is defined as not being able to get pregnant (conceive) after one year (or longer) of unprotected sex. This can create anxiety and stress for individuals that are actively trying to get pregnant and haven't within one year. So much is unknown to the general public about how complicated the scientific process of pregnancy is. 

Most that go through infertility treatment are thrown into a world of exhaustion, anxiety, stress, and bewilderment. No fertility journey is identical. The process can take as little as a few months, or as long as multiple years. The longer an individual is in infertility treatment, the more susceptible they are to developing anxiety, depression, and other mental difficulties. Because this topic is so taboo and data is still lacking in the field, I've decided to create my own. 

After 3 years of actively trying to conceive, mental breakdowns, sleepless nights, and constant medical visits, this is the result of my personal fertility journey... The bubble chart reads: 38 Blood Draws, 31 Ultrasounds, 8 Intrauterine Inseminations, 2 Miscarriages, and 1 baby harris coming November 2022 with an ultrasound picture of Meghan Harris' expected child. '>"),
    HTML("<center>")
)



# Define server logic required====
server <- function(input, output) {
}

# Run the application 
shinyApp(ui = ui, server = server)

