library(shiny)
library(bslib)

# Define UI for application that draws a histogram
ui <- fluidPage(id = 'test',
                tags$style('#test {
                             background-color: #000000;
              }'),
              
    
    modalDialog(title = "Content Warning",
                tags$head(tags$style(".modal-dialog{ width:50vw}")),
                tags$head(tags$style(".modal-body{ min-height:100%}")),
                tags$head(tags$style(".modal-backdrop{ opacity:1 !important;}")),
                span("The visual on this page mentions topics that may be sensitve or triggering for some like miscarriages, infertility, and pregnancy. If you do not wish to view this material please close this window or press the 'Back' button on your browser to exit."),
                footer = HTML('<button style="position: relative; center: 0%; background-color: #f44336;" onclick="self.close()" style = >DON\'T Show the Visual (Close)</button>
                               <button style="position: relative; center: 0%; background-color: #4CAF50;" type="button"  data-dismiss="modal" data-bs-dismiss="modal">Show the Visual (Continue)</button>
                              '),
                size = c("s"),
                easyClose = FALSE,
                fade = TRUE),
    
    
    
    
    # Show a plot of the generated distribution

        HTML("<center>"),     img(src = "background.png", width = "660px", height = "1000px" ),  HTML("<center>")
    )



# Define server logic required to draw a histogram
server <- function(input, output) {

}

# Run the application 
shinyApp(ui = ui, server = server)
