# install.packages("dplyr")
# install.packages("stringr")

library(stringr)
library(dplyr)


#uporzadkowanie danych (odczytanie, wybór kolumn, usunięcie znaków z kolumny 'Runtime')

wszystkie = read.csv("imdb_top_1000.csv")

wszystkie_filmy = wszystkie [c(6, 3, 5, 7, 2, 1, 10, 11)]

wszystkie_filmy$Runtime = str_replace_all(wszystkie_filmy$Runtime, pattern = "[a-zA]+", replacement = "")
wszystkie_filmy$Runtime = as.integer(wszystkie_filmy$Runtime)


# filtrowanie wyników do uzyskania odpowiedniego filmu


  #filtrowanie pierwszego parametru- gatunku

gatunek = function(wybrane_gatunki){
  wszystkie_filmy[wszystkie_filmy$Genre == wybrane_gatunki, ]
}

gatunek("Comedy")


  # filtrowanie z daty

przedzial_czasu = function(poczatek_rok, koniec_rok){
  filter(wszystkie_filmy, wszystkie_filmy$Released_Year >= poczatek_rok & 
           wszystkie$Released_Year <= koniec_rok)
}

przedzial_czasu(1990,1992)
