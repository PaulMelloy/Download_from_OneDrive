# Download_from_OneDrive
Provides an R function to download csv files and import them into R from OneDrive shared links

## Getting started

The working function can be found in the ./R directory. Users can clone this repository and use `source("*insert_filepath_here./R/OD_DL_csv.r"")`.

## Method for developing code

The purpose of this project is to create a method that allows users to download files from OneDrive and read them into R.  

First we need to generate a file that will be shared.

```{r CreateDataFile}
x1 <- data.frame(
   A = rnorm(30,5,1.23),
   B = runif(30,1,10),
   C = rpois(30,5)
   )

write.csv(x1 , file = "data/Data_file.csv", row.names = FALSE)
dim(read.csv("./data/Data_file.csv"))
```

Once the file was synced to OneDrive I obtained the following shared link:

Original link
https://usqprd-my.sharepoint.com/:x:/g/personal/username_usq_edu_au/EdPkNrBkMNJMgwPZKajMxXgBMwyMdzz24-Ra6GH0HUCuaQ?e=MzwFXC

replace end with download=1 after ?
https://usqprd-my.sharepoint.com/:x:/g/personal/username_usq_edu_au/EdPkNrBkMNJMgwPZKajMxXgBMwyMdzz24-Ra6GH0HUCuaQ?download=1

This works!!!!

### Now to make a function

```{r Download_function}
OD_DL_csv <- function(sharedURL, file_name, save2wd = FALSE){

   # Save the shared url 
   URL1 <- unlist(strsplit(sharedURL,"[?]"))[1]
   URL1 <- paste0(URL1,"?download=1") # edit URL to make it a downloadable link
   
   # Download the file to a temp directory using the supplied file name
   curl::curl_download(
      URL1,
      destfile = file.path(tempdir(), file_name),
      mode = "wb"
      )


   # If the user wants it saved to thier working directory this will copy the file
   if(isTRUE(save2wd)){
      file.copy(
         from = paste0(tempdir(),"\\", file_name),
         to = "./")
      }

   # return the CSV as a data.frame
   return(read.csv(paste0(tempdir(), "\\" ,file_name), stringsAsFactors = FALSE))

}


```


### Testing the function

```{r test_function}

test1 <- OD_DL_csv(sharedURL = "https://usqprd-my.sharepoint.com/:x:/g/personal/u8011054_usq_edu_au/EdPkNrBkMNJMgwPZKajMxXgBMwyMdzz24-Ra6GH0HUCuaQ?e=MzwFXC",
          file_name = "testing.csv"
          )

head(test1)


# test copy to directory

test1 <- OD_DL_csv(sharedURL = "https://usqprd-my.sharepoint.com/:x:/g/personal/u8011054_usq_edu_au/EdPkNrBkMNJMgwPZKajMxXgBMwyMdzz24-Ra6GH0HUCuaQ?e=MzwFXC",
          file_name = "testing.csv",
          save2wd = TRUE)

list.files("./")

head(read.csv("testing.csv"))

```

Function is working correctly as of 15/10/2019


