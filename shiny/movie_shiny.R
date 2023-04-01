# install.packages("shiny")
# install.packages("tidyverse") 

library(shiny)
library(tidyverse) 


# wczytanie danych

movie_data = read.csv("movie_data.csv", stringsAsFactors = FALSE)


# obiekty, które mają wszystkie możliwe opcje do wyboru w aplikacji
# dodanie możliwości "All"

director_choices = append((unique(movie_data$director)),"All", after = 0) 
star_choices = append((unique(movie_data$star)),"All", after = 0)
genre_choices = append((unique(sort(movie_data$genre))), "All", after = 0)


# APLIKACJA- WIDOCZNA DLA UŻYTKOWNIKA

ui <- fluidPage( # dostosowanie do przeglądarki
  titlePanel("Movie Recommender"), 
 
   sidebarLayout( # układ bocznej części aplikacji
    
    sidebarPanel( # zawartość bocznej części
      sliderInput("year", "Year", min =1920, max = 2020, value = c(1920, 2020),step = 1),
      sliderInput("rating", "Rating", min = 7.6, max = 9.3, value = c(7.6, 9.3),step = 0.1),
      sliderInput("runtime", "Runtime", min = 45, max = 321, value = c(45, 321),step = 1),
      selectInput("genres", "Genres", genre_choices, selected = "All", multiple = TRUE),
      selectInput("director","Director", director_choices, selected = "All", multiple = TRUE),
      selectInput("star","Actor",star_choices, selected = "All")
    ),
    
    mainPanel( # zawartość głównej części aplikacji
      tableOutput("movie_titles") 
    )
  )
)


# SERWER- NIEWIDOCZNE DLA UŻYTKOWNIKA

server <- function(input, output) { # funkcja zakładająca dane wejściowe i wyjściowe 
  
  output$movie_titles = renderTable({ # tabela, która dostarcza dane wyjściowe po wprowadzeniu wejściowych
    m = movie_data %>% 
      filter(between(year, input$year[1],input$year[2])) %>%  # filtrowanie danych pomiędzy danymi wejściowymi
      filter(between(rating, input$rating[1],input$rating[2])) %>%
      filter(between(runtime, input$runtime[1],input$runtime[2]))
    
    
    if(!("All" %in% input$genres)) { # 
      m = m %>% filter(genre %in% input$genres) 
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
