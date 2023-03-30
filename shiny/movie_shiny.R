library(shiny)
library(tidyverse) # zbiór pakietów (dplyr, forcats, ggplot2, lubridate, purrr, readr, stringr, tibble, tidyr)

movie_data = read.csv("movie_data.csv", stringsAsFactors = FALSE)

# ui - część kody opisująca wygląd interfejsu, fluidPage - funkcja która zapewnia dopasowanie interfejsu do rozmiaru przeglądarki 

ui <- fluidPage(
  titlePanel("Movie Recommender"), # tytuł aplikacji
  sidebarLayout( # dzieli strone na część lewą i prawą
    
    sidebarPanel( # panel po lewej stronie z suwaczkami, poniżej opisujemy co się w nim znajduje
      
      # suwaczki dotyczące roku prodkukcji i oceny filmu, inputID - id danych wejściowych podanych przez użytkownika, label - nazwa np. danego suwaczka
      sliderInput(inputId = "year", label = "Year", min =1920, max = 2020, value = c(1920, 2020),step = 1),
      sliderInput(inputId = "rating", label = "Rating", min = 7.6, max = 9.3, value = c(7.6, 9.3),step = 0.1),
      sliderInput(inputId = "runtime", label = "Runtime", min = 45, max = 321, value = c(45, 321),step = 1),
      
      h4("Genres"),
      
      # panel z możliwością odznaczania gatunków filmów
      checkboxInput(inputId = "action", label = "Action", value = FALSE),
      checkboxInput(inputId = "adventure", label = "Adventure", value = FALSE),
      checkboxInput(inputId = "animation", label = "Animation", value = FALSE),
      checkboxInput(inputId = "biography", label = "Biography", value = FALSE),
      checkboxInput(inputId = "comedy", label = "Comedy", value = FALSE),
      checkboxInput(inputId = "crime", label = "Crime", value = FALSE),
      checkboxInput(inputId = "drama", label = "Drama", value = FALSE),
    ),
    
    
    mainPanel( # główny panel "część prawa", na nim pojawia się wynik filtrowania
      tableOutput("movie_titles") # określamy że chcemy jako efekt wyjściowy dostać tabele
    )
  )
)

server <- function(input, output, session) { #część w której opisujemy funkcje, niewidoczny dla użytkownika

  # określamy że efktem wyjściowym będzie tabela zawierająca tytuły filmów
  output$movie_titles = renderTable({
    movie_data %>% # tabela składa się z danych z pliku movie_data.csv
      filter(between(year, input$year[1],input$year[2]),
             between(rating, input$rating[1],input$rating[2]),
             between(runtime, input$runtime[1],input$runtime[2]),
             action == input$action,
             adventure == input$adventure,
             animation == input$animation,
             biography == input$biography,
             comedy == input$comedy,
             crime == input$crime,
             drama == input$drama) %>% 
      select(title) %>% 
      rename(title, Movies = title)
  })
}

shinyApp(ui, server)
