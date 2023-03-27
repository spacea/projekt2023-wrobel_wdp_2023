library(recommenderlab)
library(ggplot2)                       
library(data.table)
library(reshape2)

movies = read.csv("movie_data.csv")

titles = data.frame(movies_data$movie_title)
genres = data.frame(movies_data$genres)
language = data.frame(movies_data$language)
content_rating = data.frame(movies_data$content_rating)
year = data.frame(movies_data$title_year)
imdb = data.frame(movies_data$imdb_score)