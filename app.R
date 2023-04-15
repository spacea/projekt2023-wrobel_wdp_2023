# install.packages("shiny")
# install.packages("dplyr") 
# install.packages("shinythemes")

library(shiny)
library(dplyr) 
library(shinythemes)

# tabelka danych zawierająca 1000 najlepiej ocenianych filmów na IMDB
movie_data = read.csv("movie_data.csv", stringsAsFactors = FALSE)
recommendations = read.csv("recommendations.csv")

# przygotowanie danych do filtrowania
director_choices = append((unique(sort(movie_data$director))),"All", after = 0) 
star_choices = append((unique(sort(movie_data$star))),"All", after = 0)
genre_choices = append((unique(sort(movie_data$genre))), "All", after = 0)
genre_1_choices = append((unique(sort(movie_data$genre_1))), "All", after = 0)
title_choices = append((unique(sort(movie_data$title))), "", after = 0)

ui = fluidPage("Based on the Top 1000 Movies until 2020", theme = shinytheme("darkly"),
  navbarPage("Movie Recommender",
    tabPanel("Movie Search",
      sidebarLayout(
        sidebarPanel(
          sliderInput("year", "Year", min =1920, max = 2020, 
                      value = c(1920, 2020),step = 1),
          sliderInput("rating", "Rating", min = 7.6, max = 9.3, 
                      value = c(7.6, 9.3),step = 0.1),
          sliderInput("runtime", "Runtime (in minutes)", min = 45, max = 321, 
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
        selectInput("genre_1", "Genres", genre_1_choices, selected = "All"),
        selectInput("movie_number", "Number of random movie:", 1:10, selected = 5),
        helpText("Click to get random movies."),
        actionButton("random", "Get random movies")
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
    
    tabPanel("Our Recommendations",
      mainPanel(
        h2("top 5"), br(),
        h3("rekomendacje basia"),
        tableOutput("basia"), br(),
        h3("rekomendacje ola"),
        tableOutput("ola"), br(),
        h3("rekomendacje natalia"),
        tableOutput("natalia"),
      )
    )
      
  )
)


server <- function(input, output) {

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
    
    m %>% select(title, year, rating, genre, runtime)
    
  })
  
  # funkcja losująca filmy
  observeEvent(input$random, {
      x = sample_n(movie_data, input$movie_number[], replace = TRUE) %>% 
      select(title, genre, overview) 
    output$movie_random = renderTable(x)
  })
  
  # funkcja do wyszukiwania informacji od danym filmie na podstawie tytułu
  output$movie_title = renderUI({
    y = movie_data 
    if(!("" %in% input$title)) { 
      y = y %>% filter(title %in% input$title)
      HTML(paste0(
                   h3(y$title),
                   '<img src="', y$poster, '" width="120" />',
                   h4("Overview"), y$overview, br(), br(), 
                   h4("Genres"), y$genre, br(), br(), 
                   h4("Year"), y$year, br(), br(),
                   h4("Director"), y$director, br(), br(),
                   h4("Actor"), y$star, br(), br(),
                   h4("Runtime"), y$runtime, " min", br(), br(),
                   h4("Rating"), y$rating))
    }
  })
  
  output$basia = renderTable(recommendations[1:5,1:8])
  output$ola = renderTable(recommendations[6:10,1:8])
  output$natalia = renderTable(recommendations[11:15,1:8])
}


shinyApp(ui, server)

