# pakiety które mogą się przydać
library(recommenderlab)
library(ggplot2)                       
library(data.table)
library(reshape2)

# użyte pakiety
library(stringr)
library(dplyr)

movie_data = read.csv("filmy.csv")

# gatunek

# roku od 1920 do 2020
rok_produkcji = function(rok){
  x = filter(movie_data, movie_data$Released_Year == rok)
  print(x, quote = TRUE, row.names = FALSE)
}

# przedził czasu
przedzial_czasu = function(poczatek_rok, koniec_rok){
  filter(movie_data, movie_data$Released_Year >= poczatek_rok & 
           movie_data$Released_Year <= koniec_rok)
}

# IMDB ocena od 7.6 do 9.3
ocena_filmu = function(ocena){
  filter(movie_data, movie_data$IMDB_Rating == ocena)
}

# IMDB przedział ocen
przedzial_oceny = function(najnizsza, najwyzsza){
  filter(movie_data, movie_data$Released_Year >= najnizsza & 
           movie_data$Released_Year <= najwyzsza)
}

# czas trwania filmu, od 45 do 321
movie_data$Runtime = str_replace_all(movie_data$Runtime, pattern = "[a-zA]+", 
                                     replacement = "")
movie_data$Runtime = as.integer(movie_data$Runtime)

przedzial_czas_trwania = function(x, y){
  filter(movie_data, movie_data$Runtime >= x &
           movie_data$Runtime <= y)
}

