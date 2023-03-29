library("shiny")
library("dplyr")

movies = read.csv("C:/Users/Komputer/Desktop/FILMY PROJEKT/projekt2023-wrobel_wdp_2023/movies.csv")

ui = fluidPage(
  
  titlePanel("MOVIE!"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "Released_Year", label = "Rok produkcji:",
                  min = 1920, max = 2020, value = c(1920, 2020), step = 1),
      sliderInput(inputId = "IMDB_Rating", label = "Ocena filmu:",
                min = 7.6, max = 9.3, value = c(7.6, 9.3), step = 0.1)),
      mainPanel(
        h1("Wynik:"),
        tableOutput(outputId = "filmy"))
  )
)

server = function(input, output, session) {
  
output$filmy =  renderDataTable(iris)({
  dane
    filter(between(Released_Year, input$Released_Year[1],input$Released_Year[2]),
           between(IMDB_Rating, input$IMDB_Rating[1],input$IMDB_Rating[2]))
  
  select(Series_Title)
  rename(Series_Title, Movies = Series_Title)
})
}

shinyApp(ui = ui, server = server)

