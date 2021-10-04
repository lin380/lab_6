# Lab 6: 

<!-- NOTE: 
You can preview this README.md document by clicking the 'Preview' button in the RStudio toolbar. 
-->

## Preparation

- Read/ annotate: [Recipe \#6](https://lin380.github.io/tadr/articles/recipe_6.html). You can refer back to this document to help you at any point during this lab activity.
- Note: do your best to employ what you've learned and use other existing resources (R documentation, web searches, etc.).

## Objectives

- Gain experience working with coding strategies such as control statements, custom functions, and iteration.
- Practice working with direct downloads and API interfaces to acquire data.
- Implement organizational strategies for organizing data in reproducible fashion.

## Instructions

### Setup

1. Create a new R Markdown document. Title it "Lab #6" and provide add your name as the author. 
2. Edit the front matter to have rendered R Markdown documents print pretty tabular datasets.
3. Delete all the material below the front matter.
4. Add a code chunk directly below the header named 'setup' and add the code to load the following packages and any others you end up using in this lab report. Add `message=FALSE` to this code chunk to suppress messages. 
  - tidyverse
  - tadr
  - rtweet

### Tasks

1. Create two level-1 header sections named: "Direct downloads" and "API interfaces".
2. Follow the instructions that follow adding the relevant prose description and code chunks to the corresponding sections.
  - Make sure to provide descriptions of your steps between code chunks and code comments within the code chunks!

#### Direct downloads

The goal in this section will to be to download and decompress a corpus file and save the contents to disk.

- Source the `functions/functions.R` file to load the `get_compressed_data()` function into the current R session.
  - Note that the function appears in the 'Environment' pane in RStudio. 
- In the R Console, check the arguments that the function requires. Use `args()` with the function name as the only argument (do not quote the function name).
  - Describe the arguments of the function and predict what they will do.
- Navigate to the [ACTIVE-ES Corpus v.02](https://github.com/francojc/activ-es/tree/master/activ-es-v.02/corpus). This is part of the [ACTIV-ES Corpus](https://github.com/francojc/activ-es) a comparable Spanish corpus comprised of film dialogue from Argentine, Mexican and Spanish productions.
  - Click on the 'tagged.zip' file. Right-click on the 'Download' button and copy the link address to the .zip file.
- Create and name a code chunk that will download and decompress the .zip file into the `data/original/actives/` directory.
  - Confirm that the .zip file was downloaded into the correct directory.
- Create and name a code chunk to report the directory structure. Include the following code in this code chunk:

```r
fs::dir_tree(recurse = 2)
```

#### API interfaces

The goal in this section will be to interface the Twitter API with the rtweet package. I will use the `stream_tweets()` function to stream live tweets from Twitter for 5 minutes (300 seconds). 

- Read the pre-established Twitter authentication token (`student_token.rds`) and assign it to an object named `student_token`. Use the `read_rds()` function.
- In the R Console, run the following code to test whether the Twitter API is up and working. 

```r
stream_usa <- 
  stream_tweets(lookup_coords("usa"), timeout = 10, token = student_token) # NOT RUN (test in R Console)
```

- Create and name a code chunk. Add the following function to this code chunk. Review what it does and add code comments describing each line. 

```r
stream_usa <- function(file, timeout = 10, token = student_token, force = FALSE) {
  # Function:
  # Stream tweets from the US and save results to a csv file
  
  if(!file.exists(file) | force == TRUE) {
    message("Getting ready to stream.")
    if(!dir.exists(dirname(file))) {
      dir.create(path = dirname(file), showWarnings = FALSE, recursive = TRUE)
      message("Directory created.")
    }
    
    stream <- 
      rtweet::stream_tweets(lookup_coords("usa"), 
                            timeout = timeout, 
                            token = token) %>% 
      lat_lng()
    
    rtweet::save_as_csv(x = stream, file_name = file)
    message("Stream file saved!")
    
  } else {
    message("Stream file already exists. Set 'force = TRUE' to overwrite existing data.")
  }
}
```

- Create and name a code chunk. Run the `stream_usa()` function setting the `file` argument to the path to the file that you want to create and the `timeout` argument to `300`.
- Create and name a code chunk to report the directory structure, as you did in the previous section.
- Create and name a code chunk to read in the .csv file you created. Use the `read_csv()` function and assign the results to `stream_twitter_usa`.
- Create and name a code chunk to source the `functions/functions.R` file for the `plot_tweet_langs()` function (if you have not already). Run the `plot_tweet_langs()` function with our tweets as the only argument.


### Assessment

Add a level-1 section which describes your learning in this lab.

Some questions to consider: 

  - What did you learn?
  - What was most/ least challenging?
  - What resources did you consult? 
  - What more would you like to know about?

## Submission

1. To prepare your lab report for submission on Canvas you will need to Knit your R Markdown document to PDF or Word. 
2. Download this file to your computer.
3. Go to the Canvas submission page for Lab #6 and submit your PDF/Word document as a 'File Upload'. Add any comments you would like to pass on to me about the lab in the 'Comments...' box in Canvas.



<!--

IDEAS: 


- Use the


-->
