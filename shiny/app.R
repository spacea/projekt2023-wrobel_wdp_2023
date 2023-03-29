library(shiny)
library(tidyverse)

ui <- fluidPage(
  pageWithSidebar(
    headerPanel("Movie Explorer"),
    
    #Side bar Panel
    sidebarPanel(
      
      #slider inputs (year and rating)
      sliderInput(inputId = "year", label = "year", min =1920, max = 2020, value = c(1920, 2020),step = 1),
      sliderInput(inputId = "rating", label = "rating", min = 7.6, max = 9.3, value = c(7.6, 9.3),step = 0.1),
      
      h4("Genres"),
      
      #checkbox inputs 
      checkboxInput(inputId = "action", label = "action", value = FALSE),
      checkboxInput(inputId = "animation", label = "animation", value = FALSE),
      checkboxInput(inputId = "comedy", label = "comedy", value = FALSE),
      checkboxInput(inputId = "drama", label = "drama", value = FALSE),
      checkboxInput(inputId = "romance", label = "romance", value = FALSE),
    ),
    
    #main panel
    mainPanel(
      tableOutput("movie_titles")
    )
  )
)

server <- function(input, output, session) {

dataset = read.csv("dataset.csv")
  
  output$movie_titles = renderTable({
    dataset |> 
      filter(between(year, input$year[1],input$year[2]),
             between(rating, input$rating[1],input$rating[2]),
             action == input$action,
             animation == input$animation,
             comedy == input$comedy,
             drama == input$drama,
             romance == input$romance) |> 
      select(title) |> 
      rename(title, Movies = title)
  })
}

shinyApp(ui, server)
