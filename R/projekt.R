library(recommenderlab)
library(ggplot2)                       
library(data.table)
library(reshape2)

movies_data = read.csv("movie_data.csv")

titles = data.frame(movies_data$movie_title)
genres = data.frame(movies_data$genres)
language = data.frame(movies_data$language)
content_rating = data.frame(movies_data$content_rating)
year = data.frame(movies_data$title_year)
imdb = data.frame(movies_data$imdb_score)

# wyznaczanie filmu na podstawie języka
english_movies = movies_data [movies_data$language == "English", ]

# nowy plik csv próby
library(stringr)
library(dplyr)

movie = read.csv("imdb_top_1000.csv")
movie2 = movie [ , c(1, 2, 3, 5, 6, 7, 8, 10, 11)]

# funkcja - daty filmów
rok = function(x){
  filter(movie2, movie2$Released_Year == x)
}

przedzial_czasu = function()
