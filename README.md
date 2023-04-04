[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-8d59dc4de5201274e310e4c54b9627a8934c3b88527886e3b421487c677d23eb.svg)](https://classroom.github.com/a/tauthlex)

# Movie recommender and more
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
