[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-8d59dc4de5201274e310e4c54b9627a8934c3b88527886e3b421487c677d23eb.svg)](https://classroom.github.com/a/tauthlex)

# Movie Recommender & More
Projekt został wykonany w języku R oraz przy pomocy pakietów, które zostaną wymienione później. 

Głównym celem było stworzenie aplikacji, która wyświetla propozycje filmów poprzez filtrowanie w zależności od upodobań osoby korzystającej. Ponadto użytkownik posiada opcję wylosowania pięciu przypadkowych filmów oraz zdobycia informacji o wybranym filmie. 

Baza danych została zaczęrpnięta z serwisu **IMDb** i zawiera 1000 najlepiej ocenianych filmów. 
## Wykorzystane pakiety
* **Shiny**

Ułatwia tworzenie interaktywnych aplikacji internetowych za pomocą języka R. Automatyczne wiązanie danych wejściowych i wyjściowych oraz rozbudowane, gotowe widżety umożliwiają tworzenie pięknych, responsywnych i wydajnych aplikacji przy minimalnym wysiłku.

* **Shiny Themes**

Pakiet zawierający kilka motywów z **Bootswatch**, które działają z aplikacjami Shiny.

* **Tidyverse**

Zestaw pakietów, który ułatwia import, przekształcanie i prezentację danych. Zawiera w sobie pakiety takie jak: **ggplot2**, **dplyr**, **tidyr**, **readr**, **purrr**, **tibble**, **stringr** czy **forcats**.

Pakiety z repozytorium CRAN instalujemy przy użyciu funkcji `install.packages()`
```
install.packages("shiny")
install.packages("tidyverse") 
```

Dołączenie pakietów do R następuje przy użyciu funkcji `library()`
```
library(shiny)
library(tidyverse) 
```
## Funckje i obiekty w kodzie
W celu wczytania danych w formie pliku CSV została użyta funkcja `read.csv`.
```
movie_data = read.csv("movie_data.csv", stringsAsFactors = FALSE)
```

Następnym krokiem było stworzenie obiektów, które mają wszystkie możliwe opcje do wyboru w aplikacji. Przykładowo:
```
director_choices = append((unique(sort(movie_data$director))),"All", after = 0)
```
`append()` tworzy nowy wektor, który poprzez `unique()` wybiera unikalne nazwy z danej kolumny, a dzięki funkcji `sort()` elementy w wektorze są posegregowane alfabetycznie. Na powyższym przykładzie działa to w ten sposób, że gdy reżyser nakręcił dwa filmy, to jego imię pojawi się w wektorze tylko raz, a nie dwa razy. `"All"` jest dodatkowym elementem wektora i przez `after = 0` umiejscawiany jest zawsze na jego początku.

Kolejną częścią kodu jest lista `ui`, która zawiera elementy aplikacji widocznych dla użytkownika. 
* `fluidPage` dostosowuje układ strony, aby wypełnić dostępną szerokość przeglądarki.
* `navbarPage("Movie Recommender & More",` wyświetla tytuł aplikacji
* `tabPanel()` tworzy zakładki w aplikacji, w nim ustalamy jakich widgetów używamy i jakie jest ich przeznaczenie

Za to `server` zawiera kod, który odpowiedzialny za procesy niewidzoczne dla użytkownika.
* `function(input, output, session)` funkcja zakładająca dane wejściowe i wyjściowe
* `output$movie_titles = renderTable()` tabela pokazująca filmy po filtracji
*  `filter(between(year, input$year[1],input$year[2]))` filtrowanie danych pomiędzy danymi wejściowymi
Filtrowanie bazy filmowej następuje na zasadzie warunków. 
* `observeEvent()` funkcja używana do reakcji na zmiany wartości wybranej zmiennej w aplikacji

Na koniec, w celu połączenia `ui` i `serwer` używamy następującej funkcji:
```
shinyApp(ui, server)
```
## Napotkane problemy 
Podczas wykonywania projektu największym wyzwaniem był wcześniejszy brak doświadczenia w pisaniu kody, który starałyśmy się przezwyciężyć szukając informacji w różnych źródłach internetowych od poradników fimowych po przeglądanie kodów innych użytkowników GitHuba.
### Wykonanie
Natalia Wróbel, Aleksandra Sauer, Barbara Sadkowska
geoinformacja rok 1
