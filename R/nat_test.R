library(shiny)
library(tidyverse) 

movie_data = read.csv("movie_data.csv", stringsAsFactors = FALSE)
random = movie_data = read.csv("movie_data.csv", stringsAsFactors = FALSE)

director_choices = append((unique(movie_data$director)),"All", after = 0) 
star_choices = append((unique(movie_data$star)),"All", after = 0)
genre_choices = append((unique(sort(movie_data$genre))), "All", after = 0)

ui <- fluidPage(
  titlePanel("Movie Recommender"), 
  
  sidebarLayout(
    
    sidebarPanel( 
      sliderInput("year", "Year", min =1920, max = 2020, value = c(1920, 2020),step = 1),
      sliderInput("rating", "Rating", min = 7.6, max = 9.3, value = c(7.6, 9.3),step = 0.1),
      sliderInput("runtime", "Runtime", min = 45, max = 321, value = c(45, 321),step = 1),
      hr(),
      selectInput("genres", "Genres", genre_choices, selected = "All", multiple = TRUE),
      selectInput("director","Director", director_choices, selected = "All", multiple = TRUE),
      selectInput("star","Actor",star_choices, selected = "All", multiple = TRUE),
      hr(),
      actionButton("losowy", "Random movie"),
    ),
    
    mainPanel(
      tableOutput("movie_titles"),
      tableOutput("movie_random")
    )
  )
)

server <- function(input, output) { 

  observeEvent(input$losowy, {
    
    x = sample(random$title, 1)
    output$movie_random = renderTable(x)
  
  })
  
  output$movie_titles = renderTable({ 
    m = movie_data %>% 
      filter(between(year, input$year[1],input$year[2])) %>% 
      filter(between(rating, input$rating[1],input$rating[2])) %>%
      filter(between(runtime, input$runtime[1],input$runtime[2]))
    
    
    if(!("All" %in% input$genre)) { 
      m = m %>% filter(genre %in% input$genre) 
    }
    
    if (!("All" %in% input$director)) { 
      m = m %>% filter(director %in% input$director)
    }
    
    if (!("All" %in% input$star)) { 
      m = m %>% filter(star %in% input$star)
    }
      
    m %>% select("title")
  })
        
}

shinyApp(ui, server)
