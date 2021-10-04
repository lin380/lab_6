
# ABOUT ------------------------------------------------------------------------

# Functions

get_compressed_data <- function(url, target_dir, force = FALSE) {
  # Function:
  # Download a compressed file and decompress its contents

  # Get the extension of the target file
  ext <- tools::file_ext(url)
  # Check to see if the target file is a compressed file
  if(!ext %in% c("zip", "gz", "tar")) stop("Target file given is not supported")
  # Check to see if the data already exists
  if(!dir.exists(target_dir) | force == TRUE) { # if data does not exist, download/ decompress
    cat("Creating target data directory \n") # print status message
    dir.create(path = target_dir, recursive = TRUE, showWarnings = FALSE) # create target data directory
    cat("Downloading data... \n") # print status message
    temp <- tempfile() # create a temporary space for the file to be written to
    utils::download.file(url = url, destfile = temp) # download the data to the temp file
    # Decompress the temp file in the target directory
    if(ext == "zip") {
      utils::unzip(zipfile = temp, exdir = target_dir, junkpaths = TRUE) # zip files
    } else {
      utils::untar(tarfile = temp, exdir = target_dir) # tar, gz files
    }
    cat("Data downloaded! \n") # print status message
  } else { # if data exists, don't download it again
    cat("Data already exists \n") # print status message
  }
}

plot_tweet_langs <- function(tweets) {
  # Function:
  # Plot tweets from the US on a map with colored points for languages

  library(tidyverse, quietly = TRUE) # to manipulate data and plot

  langs <-
    rtweet::langs %>% # languages-code dataset
    rename(lang = alpha) # rename column before merge

  tweets_langs <- left_join(tweets, langs) # merge tweets and langs to get full language names

  states_map <- map_data("state") # get US map of states

  p <- ggplot() + # base plot
    geom_polygon(data = states_map, # map data
                 aes(x = long, y = lat, group = group), fill = "#cccccc", color = "black") + # set background/ lines
    labs(title = "Tweets in the USA", subtitle = "Coded for language") # labels

  p + # add to previous base plot
    geom_point(data = tweets_langs, # tweet data with lat and lng coordinates and languages
               aes(x = lng, y = lat, group = 1, color = english), # map lat and lng and color for language names
               alpha = 1, size = 1.5) + # transparency and size of points
    labs(color = "Languages") # labels
}

