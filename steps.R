activityHistByDay <- function(activity){
        dayTotals <- tapply(activity[,1], activity[,2], sum)
        hist(dayTotals)  
}

activityPlotByInterval <- function(activity){
        intervalMeans<-tapply(activity[,1], activity[,3], mean, na.rm=TRUE)
        intervals<-tapply(activity[,3], activity[,3], mean, na.rm=TRUE)
        plot(intervals,intervalMeans,type="l")  
}

activityMeanAndMedian <- function(activity){
        dayMeans <- tapply(activity[,1], activity[,2], sum)
        aMean <- mean(dayMeans, na.rm=TRUE)
        aMedian <- median(dayMeans, na.rm=TRUE)
        c(aMean, aMedian)
}

activityWhichMax <- function(activity){
        intervals<-tapply(activity[,3], activity[,3], mean, na.rm=TRUE)
        intervalMeans<-tapply(activity[,1], activity[,3], mean, na.rm=TRUE)
        intervals[[which.max(intervalMeans)]]
}

activityFillNAs <- function(activity){
        activitymod<-activity
        intervalMeans <- tapply(activity[,1], activity[,3], mean, na.rm=TRUE)
        replace<-intervalMeans[as.character(activity[!complete.cases(activity),3])]
        activitymod[!complete.cases(activity),1]<-replace
        activitymod
}

dayType <- function(date){
        wd <- weekdays(as.Date(date))
        if (wd=="Saturday"){
          return("weekend")
        }
        if (wd=="Sunday"){
          return("weekend")
        }
        return("weekday")
}

setDayTypes <- function(activity){
        dayTypes <- lapply(activity[,2], dayType)
        activity$dayType<-dayTypes 
        activity
}