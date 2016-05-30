library(ggplot2)
library(plyr)
library(doBy)
#read the csv data
data1 <- read.csv(url("http://stat.columbia.edu/~rachel/datasets/nyt1.csv"))

head(data1)
data1$agecat <- cut(data1$Age,c(0,18,24,34,44,54,64,120))
# view
summary(data1)

siterange <- function(x){c(length(x), min(x), mean(x), max(x))}
summaryBy(Age~agecat, data =data1, FUN=siterange)
# so only signed in users have ages and genders
detailed_summary <- summaryBy(Gender+Signed_In+Impressions+Clicks~agecat, data =data1)


# answer to question 2.1
#impressions plot
ggplot(data1, aes(x=Impressions, fill=agecat))+geom_histogram(binwidth=.2)
ggplot(data1, aes(x=agecat, y=Impressions, fill=agecat))+geom_boxplot()
ggplot(data1, aes(x=Impressions, colour=data1$agecat)) + geom_density()

data1$hasimps <-cut(data1$Impressions,c(0,45,120))
summaryBy(Clicks~hasimps, data =data1, FUN=siterange)
# plot of clicks vs impressions
ggplot(subset(data1, Impressions>0), aes(x=agecat, y=(Clicks/Impressions), fill=agecat)) + geom_bar(stat="identity")
ggplot(subset(data1, Clicks>0), aes(x=agecat, y=(Clicks/Impressions), fill=agecat)) + geom_bar(stat="identity")

# answer to question 2.2 and 2.3
#define new variable to segment /categorize the users based on number of clicks
clicks_summary <- summary(data1$Clicks)
#reference from http://stackoverflow.com/questions/19261159/r-applying-a-function-to-a-subset-of-a-data-frame
ggplot(data1,aes(x=Gender, y=Clicks, colour=data1$agecat)) + geom_jitter()
clicksbygenderdata <- with(data1, cbind(X=tapply(Clicks, data1$agecat, mean),Y=tapply(Gender, data1$agecat, mean)))
clicks_bygender_summary <- summary(clicksbygenderdata)

ggplot(data1,aes(x=Gender, y=Impressions, colour=data1$agecat)) + geom_jitter()
impressionsbygenderdata <- with(data1, cbind(X=tapply(Impressions, data1$agecat, mean),Y=tapply(Gender, data1$agecat, mean)))
impressions_summary <- summary(impressionsbygenderdata)

# answer to question 2.4
#Metrics/Measurements/Statistics
library(corrplot)
library(gplots)
siterange1 <- function(x){c(length(x), sum(x))}
metrics_summarydata <- summaryBy(Age+Gender+Impressions+Clicks~agecat, data=data1, FUN=siterange1)
data_ctr <- transform(metrics_summarydata, CTR=Clicks.FUN2/Impressions.FUN2)
corr_data <- data.frame(sapply(data_ctr[,c(2,4,6,8,10)], as.numeric))
corrplot.mixed(corr=cor(corr_data, use="complete.obs"), upper="ellipse", tl.pos="lt", col= colorpanel(50, "red", "blue", "brown"))
