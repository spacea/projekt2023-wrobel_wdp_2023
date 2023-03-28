library(recommenderlab)
library(ggplot2)                       
library(data.table)
library(reshape2)

# użyte pakiety
library(stringr)
library(dplyr)

movie = read.csv("imdb_top_1000.csv")
movie_data = movie [ , c(1, 2, 3, 5, 6, 7, 8, 10, 11)]

# gatunek

# roku
rok = function(x){
  filter(movie_data, movie_data$Released_Year == x)
}

# przedził czasu
przedzial_czasu = function(y,z){
  filter(movie_data, movie_data$Released_Year >= y & 
           movie_data$Released_Year <= z)
}

# IMDB ocena
ocena = function(x){
  filter(movie_data, movie_data$IMDB_Rating == x)
}
  
przedzial_oceny = function(y,z){
  filter(movie_data, movie_data$Released_Year >= y & 
           movie_data$Released_Year <= z)
}

# czas trwania filmu kk
movie_data$Runtime = str_replace_all(movie_data$Runtime, pattern = "[a-zA]+", replacement = "")

movie_data$Runtime = as.integer(movie_data$Runtime)
