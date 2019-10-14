OD_DL_csv <- function(sharedURL, file_name, save2wd = FALSE){
   # Save the shared url
   URL1 <- unlist(strsplit(sharedURL,"[?]"))[1]
   URL1 <- paste0(URL1,"?download=1")
   
   curl::curl_download(
      URL1,
      destfile = file.path(tempdir(), file_name),
      mode = "wb"
   )
   
   if(isTRUE(save2wd)){
      file.copy(
         from = paste0(tempdir(),"\\", file_name),
         to = "./")
   }
   
   return(read.csv(paste0(tempdir(), "\\" ,file_name)))
   
}
