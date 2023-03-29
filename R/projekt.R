# pakiety które mogą się przydać
library(recommenderlab)
library(data.table)
library(reshape2)

# użyte pakiety
library(stringr)
library(dplyr)

movies = read.csv("movies.csv")

# gatunek

# roku od 1920 do 2020
rok_produkcji = function(rok){
  x = filter(movies, movie == rok)
  print(x, quote = TRUE, row.names = FALSE)
}

# przedził czasu
przedzial_czasu = function(poczatek_rok, koniec_rok){
  filter(movies, movie_data$Released_Year >= poczatek_rok & 
           movie_data$Released_Year <= koniec_rok)
}

# IMDB ocena od 7.6 do 9.3
ocena_filmu = function(ocena){
  filter(movies, movie_data$IMDB_Rating == ocena)
}

# IMDB przedział ocen
przedzial_oceny = function(najnizsza, najwyzsza){
  filter(movies, movie_data$Released_Year >= najnizsza & 
           movie_data$Released_Year <= najwyzsza)
}

# czas trwania filmu, od 45 do 321
movies$Runtime = str_replace_all(movie_data$Runtime, pattern = "[a-zA]+", 
                                     replacement = "")
movies$Runtime = as.integer(movie_data$Runtime)

przedzial_czas_trwania = function(x, y){
  filter(movies, movie_data$Runtime >= x &
           movie_data$Runtime <= y)
}

