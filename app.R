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
    
    
    # Simply placing an externally made plot into the shiny UI====
    
    HTML("<center>"), 
    HTML("<img src = 'background.png'>"),
    HTML("<center>")
)



# Define server logic required====
server <- function(input, output) {
}

# Run the application 
shinyApp(ui = ui, server = server)

