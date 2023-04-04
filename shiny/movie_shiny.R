# install.packages("shiny")
# install.packages("tidyverse") 
# install.packages("shinythemes")
# install.packages("shinydashboard")

library(shiny)
library(tidyverse) 
library(shinythemes)

# wczytanie danych

movie_data = read.csv("movie_data.csv", stringsAsFactors = FALSE)
random = read.csv("movie_data.csv", stringsAsFactors = FALSE)


# obiekty, które mają wszystkie możliwe opcje do wyboru w aplikacji
# dodanie możliwości "All"

director_choices = append((unique(sort(movie_data$director))),"All", after = 0) 
star_choices = append((unique(sort(movie_data$star))),"All", after = 0)
genre_choices = append((unique(sort(movie_data$genre))), "All", after = 0)
explorer_choices = append((unique(sort(movie_data$title))), "", after = 0)


# APLIKACJA- WIDOCZNA DLA UŻYTKOWNIKA

ui = fluidPage(theme = shinytheme("darkly"),
  navbarPage("Movie Recommender & More",
    tabPanel("Movie Search",
        sidebarLayout(
        sidebarPanel(
          sliderInput("year", "Year", min =1920, max = 2020, value = c(1920, 2020),step = 1),
          sliderInput("rating", "Rating", min = 7.6, max = 9.3, value = c(7.6, 9.3),step = 0.1),
          sliderInput("runtime", "Runtime", min = 45, max = 321, value = c(45, 321),step = 1),
          helpText("Select or type for one or more elements. Select 'All' for all elements."),
          helpText("If you want to select or type for one or more elements, remove 'All' option."),
          selectInput("genre", "Genres", genre_choices, selected = "All", multiple = TRUE),
          selectInput("director","Director", director_choices, selected = "All", multiple = TRUE),
          selectInput("star","Actor",star_choices, selected = "All", multiple = TRUE)
        ),
                        
        mainPanel(
          tableOutput("movie_titles")
          ))),
             
    tabPanel("Random Movie", 
        sidebarPanel(
          helpText("Click to get 5 movies with unspecified filters."),
          actionButton("losowy", "Get random movies")
        ),
                      
        mainPanel(
          tableOutput("movie_random")
        )),
             
    tabPanel("Movie Information",
        sidebarPanel(
        helpText("Select or type to get information about a movie"),
        selectInput("explorer", "Movie Title", explorer_choices, multiple = FALSE)
        ),
  )
  )
)


# SERWER- NIEWIDOCZNE DLA UŻYTKOWNIKA

server <- function(input, output, session) { # funkcja zakładająca dane wejściowe i wyjściowe 
  
  output$movie_titles = renderTable({ # tabela, która dostarcza dane wyjściowe po wprowadzeniu wejściowych
    m = movie_data %>% 
      filter(between(year, input$year[1],input$year[2])) %>% # filtrowanie danych pomiędzy danymi wejściowymi
      filter(between(rating, input$rating[1],input$rating[2])) %>%
      filter(between(runtime, input$runtime[1],input$runtime[2]))
    
    # filtrowanie na zasadzie warunku
    if(!("All" %in% input$genre)) { 
      m = m %>% filter(genre %in% input$genre) 
    }
    
    if (!("All" %in% input$director)) { 
      m = m %>% filter(director %in% input$director)
    }
    
    if (!("All" %in% input$star)) { 
      m = m %>% filter(star %in% input$star)
    }
    
    m %>% select("title") # zmiana tytułu
    
  })
  
  
  observeEvent(input$losowy, {
    x = random %>%
      sample_n(5) %>% 
      select(title, director, star, genre, year, rating, runtime) 
    output$movie_random = renderTable(x)
  })
  
  
}

# załączenie aplikacji

shinyApp(ui, server)
