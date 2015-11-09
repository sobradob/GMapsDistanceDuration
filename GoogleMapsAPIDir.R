#distance calucations
#### This script uses RCurl and RJSONIO to download data from Google's API



#define api key as: api<-"YOURAPI"
#the function assumes address input in following dataframe:
#lat1,lng1,lat2,lng2

DistDur <- function(address,mode,time="",return.call = "json", sensor = "false") {
  library(RCurl)
  library(RJSONIO)
  address1<-paste(address[,1],address[,2], sep=" ")
  address2<-paste(address[,3],address[,4], sep=" ")
  root <- "https://maps.googleapis.com/maps/api/directions/"
  u <- paste(root, return.call, "?origin=", address1, "&destination=",address2,"&departure_time=",time,"&mode=",mode,"&key=",api,sep = "")
  for (a in 1:length(u)){
    url<-URLencode(u[a])
    doc <- getURL(url)
    doc<-gsub("\\\\", "\\", doc)
    x <- fromJSON(doc,simplify = FALSE)
    dist<-0
    dura<-0
    for (i in 1:length(x$routes[[1]]$legs[[1]]$steps))
    {
      dist<-x$routes[[1]]$legs[[1]]$steps[[i]]$distance$value+dist
      dura<-x$routes[[1]]$legs[[1]]$steps[[i]]$duration$value+dura
    }
    address$dura[a]<-dura
    address$dist[a]<-dist
  }
  return(address)
}


