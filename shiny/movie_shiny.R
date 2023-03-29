library(shiny)
library(tidyverse)

movie_data = read.csv("movie_data.csv")

# ui - część kody opisująca wygląd interfejsu, fluidPage - funkcja która zapewnia dopasowanie interfejsu do rozmiaru przeglądarki 
ui <- fluidPage(
  titlePanel("MOVIE!"), # tytuł aplikacji
  sidebarLayout( # dzieli strone na część lewą i prawą
    
    sidebarPanel( # panel po lewej stronie z suwaczkami, poniżej opisujemy co się w nim znajduje
      
      # suwaczki dotyczące roku prodkukcji i oceny filmu, inputID - id danych wejściowych podanych przez użytkownika, label - 
      sliderInput(inputId = "year", label = "year", min =1920, max = 2020, value = c(1920, 2020),step = 1),
      sliderInput(inputId = "rating", label = "rating", min = 7.6, max = 9.3, value = c(7.6, 9.3),step = 0.1),
      
      h4("Genres"),
      
      # panel z możliwością odznaczania gatunków filmów
      checkboxInput(inputId = "action", label = "action", value = FALSE),
      checkboxInput(inputId = "animation", label = "animation", value = FALSE),
      checkboxInput(inputId = "comedy", label = "comedy", value = FALSE),
      checkboxInput(inputId = "drama", label = "drama", value = FALSE),
      checkboxInput(inputId = "romance", label = "romance", value = FALSE),
    ),
    
    
    mainPanel( # główny panel "część prawa", na nim pojawia się wynik filtrowania
      tableOutput("movie_titles") # określamy że chcemy jako efekt wyjściowy dostać tabele
    )
  )
)

server <- function(input, output, session) { #część w której opisujemy funkcje, niewidoczny dla użytkownika

  # określamy że efktem wyjściowym będzie tabela zawierająca tytuły filmów
  output$movie_titles = renderTable({
    movie_data |> # tabela składa się z danych z pliku movie_data.csv
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
