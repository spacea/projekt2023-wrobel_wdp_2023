# install.packages("shiny")
# install.packages("tidyverse") 
# install.packages("shinythemes")

library(shiny)
library(tidyverse) 
library(shinythemes)

# tabelka danych zawierająca 1000 najlepiej ocenianych filmów na IMDB
movie_data = read.csv("movie_data.csv", stringsAsFactors = FALSE)

# przygotowanie danych do filtrowania
director_choices = append((unique(sort(movie_data$director))),"All", after = 0) 
star_choices = append((unique(sort(movie_data$star))),"All", after = 0)
genre_choices = append((unique(sort(movie_data$genre))), "All", after = 0)
title_choices = append((unique(sort(movie_data$title))), "", after = 0)

ui = fluidPage(theme = shinytheme("darkly"),
  navbarPage("Movie Recommender",
    tabPanel("Movie Search",
      sidebarLayout(
        sidebarPanel(
          sliderInput("year", "Year", min =1920, max = 2020, 
                      value = c(1920, 2020),step = 1),
          sliderInput("rating", "Rating", min = 7.6, max = 9.3, 
                      value = c(7.6, 9.3),step = 0.1),
          sliderInput("runtime", "Runtime", min = 45, max = 321, 
                      value = c(45, 321),step = 1),
          helpText("Select or type for one or more elements. Select 'All' for 
                   all elements."),
          helpText("If you want to select or type for one or more elements, 
                   remove 'All' option."),
          selectInput("genre", "Genres", genre_choices, selected = "All", 
                      multiple = TRUE),
          selectInput("director","Director", director_choices, 
                      selected = "All", multiple = TRUE),
          selectInput("star","Actor",star_choices, selected = "All", 
                      multiple = TRUE)
        ),
                                     
        mainPanel(
          tableOutput("movie_titles")
        )
      )
    ),
                          
    tabPanel("Random Movie", 
      sidebarPanel(
        helpText("Click to get 5 random movies."),
        actionButton("losowy", "Get random movies")
      ),
      mainPanel(
        tableOutput("movie_random")
      )
    ),
                          
    tabPanel("Movie Information",
      sidebarPanel(
        helpText("Select or type to get more information about a movie"),
        selectInput("title", "Movie Title", title_choices, multiple = FALSE)
      ),
                                   
      mainPanel(
        uiOutput("movie_title")
      )
    ),
  )
)


server <- function(input, output, session) {

# filtrowanie filmów na podstawie: rok premiery, ocena na IMDB, czas trwania, 
# gatunek, reżyser, aktor pierwszoplanowy 
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
  
  # funkcja losująca 5 filmów
  observeEvent(input$losowy, {
    x = movie_data %>%
      sample_n(5) %>% 
      select(title, genre, overview) 
    output$movie_random = renderTable(x)
  })
  
  # funkcja do wyszukiwania informacji od danym filmie na podstawie tytułu
  output$movie_title = renderUI({
    y = movie_data 
    if(!("" %in% input$title)) { 
      y = y %>% filter(title %in% input$title)
      HTML(paste0( h3(y$title), br(), 
                   h4("Overview"), y$overview, br(), br(), 
                   h4("Genres"), y$genre, br(), br(), 
                   h4("Year"), y$year, br(), br(),
                   h4("Director"), y$director, br(), br(),
                   h4("Actor"), y$star, br(), br(),
                   h4("Runtime"), y$runtime, " min", br(), br(),
                   h4("Rating"), y$rating))
    }
  })
  
}

shinyApp(ui, server)

