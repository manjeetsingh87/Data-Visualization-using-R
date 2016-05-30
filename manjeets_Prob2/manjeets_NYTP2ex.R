library(foreign)
library(ggplot2)
library(plyr)
library(doBy)
#code reference - http://stackoverflow.com/questions/5319839/read-multiple-csv-files-into-separate-data-frames
## create and view an object with file names and full paths
(f <- file.path("http://stat.columbia.edu/~rachel/datasets/", c("nyt1.csv", "nyt2.csv", "nyt3.csv", "nyt4.csv")))
merged_data <- lapply(f, read.csv)
#if necessary, assign names to data.frames
names(merged_data) <- c("ny1","ny2","ny3", "ny4")
#note the invisible function keeps lapply from spitting out the data.frames to the console
invisible(lapply(names(merged_data), function(x) assign(x,merged_data[[x]],envir=.GlobalEnv)))
#merging data sets ny1, ny2, ny3 and ny4 into a single final data set which I will use for the data analysis
finaldata <- rbind(ny1, ny2, ny3, ny4)

#answer to question 3.1
head(finaldata)
finaldata$agecategory <- cut(finaldata$Age,c(0,18,24,34,44,54,64,120))
# view
summary(finaldata)

site_range <- function(x){c(length(x), min(x), mean(x), max(x))}
summaryBy(Age~agecategory, data =finaldata, FUN=site_range)
# so only signed in users have ages and genders
finaldata_summary <- summaryBy(Gender+Signed_In+Impressions+Clicks~agecategory, data =finaldata)


# answer to question 3.2.1
#impressions plot
ggplot(finaldata, aes(x=Impressions, fill=agecategory))+geom_histogram(binwidth=.2)
ggplot(finaldata, aes(x=agecat, y=Impressions, fill=agecategory))+geom_boxplot()
ggplot(finaldata, aes(x=Impressions, colour=finaldata$agecategory)) + geom_density()

finaldata$hasimps <-cut(finaldata$Impressions,c(0,45,120))
summaryBy(Clicks~hasimps, data =finaldata, FUN=site_range)
# plot of clicks vs impressions
ggplot(subset(finaldata, Impressions>0), aes(x=agecategory, y=(Clicks/Impressions), fill=agecategory)) + geom_bar(stat="identity")
ggplot(subset(finaldata, Clicks>0), aes(x=agecategory, y=(Clicks/Impressions), fill=agecategory)) + geom_bar(stat="identity")

#answer to question 3.2.2 and 3.2.3
#define new variable to segment /categorize the users based on number of clicks
clicks_finalsummary <- summary(finaldata$Clicks)
#reference from http://stackoverflow.com/questions/19261159/r-applying-a-function-to-a-subset-of-a-data-frame
ggplot(finaldata,aes(x=Gender, y=Clicks, colour=finaldata$agecategory)) + geom_jitter()
clicksbygender <- with(finaldata, cbind(X=tapply(Clicks, finaldata$agecategory, mean),Y=tapply(Gender, finaldata$agecategory, mean)))
clicks_bygender_finalsummary <- summary(clicksbygender)

ggplot(finaldata,aes(x=Gender, y=Impressions, colour=finaldata$agecategory)) + geom_jitter()
impressionsbygender <- with(finaldata, cbind(X=tapply(Impressions, finaldata$agecategory, mean),Y=tapply(Gender, finaldata$agecategory, mean)))
impressions_finalsummary <- summary(impressionsbygender)

#answer to question 3.2.4
#Metrics/Measurements/Statistics
library(corrplot)
library(gplots)
site_range2 <- function(x){c(length(x), sum(x))}
finalmetrics_summary <- summaryBy(Age+Gender+Impressions+Clicks~agecategory, data=finaldata, FUN=site_range2)
finaldata_ctr <- transform(finalmetrics_summary, CTR=Clicks.FUN2/Impressions.FUN2)
correlation_data <- data.frame(sapply(finaldata_ctr[,c(1,3,5,7,9)], as.numeric))
corrplot.mixed(corr=cor(correlation_data, use="complete.obs"), upper="ellipse", tl.pos="lt", col= colorpanel(50, "red", "blue", "brown"))
