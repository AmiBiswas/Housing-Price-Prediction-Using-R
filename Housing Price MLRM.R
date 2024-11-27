setwd("C:/Users/Administrator/Desktop/ESSENSIALS/IVY/stats+R/Stats+R 2/Project/Housing price")
getwd()

df=read.csv("data.csv")
summary(df)
str(df)

library(dplyr)
df1<-df
df1$street<-NULL # drop the street col
str(df1)

df1$date<-as.Date(df1$date) # change date col to date formate
df2<-df1
df2$city<-as.factor(df2$city)
str(df2)

#change the categorical col to factors
df2$country<-as.factor(df2$country)
df2$statezip<-as.factor(df2$statezip)


#Checking missing values
as.data.frame(colSums(is.na(df2)))
# Calculate the total number of NA values in the data frame 
total_na <- sum(is.na(df2))


#dro date and country col
df2$date<-NULL  
df2$country<-NULL


# boxplot for outliers
ggplot(df2, aes(x = bedrooms, y = price)) +
  geom_boxplot() +
  labs(title = "Box Plot of Housing Prices by Number of Bedrooms",
       x = "Number of Bedrooms",
       y = "Price")


# Identify outliers using IQR 
Q1 <- quantile(df2$price,0.25)
Q3 <- quantile(df2$price,0.75) 
IQR <- Q3 - Q1
Q3
lower_bound <- Q1 - 1.5 * IQR 
upper_bound <- Q3 + 1.5 * IQR

outliers <- df2$price<lower_bound | df2$price > upper_bound
outliers
# Remove outliers
df2_no_ottliers<-df2[!outliers,]
summary(df2_no_ottliers)


str(df2_no_ottliers)
summary(df2_no_ottliers)

# drop both of the col as variance is very less and baised towards one value
df2_no_ottliers$waterfront<-NULL
df2_no_ottliers$view<-NULL


#---------------------------------scaled---------------------------------------------------
df2_no_ottliers
# Ensure the scale function is correctly called
df2_scaled <- scale(df2_no_ottliers[, c(1:11)])

# Convert the scaled data back to a data frame
df2_scaled <- as.data.frame(df2_scaled)

# View the first few rows of the scaled data
head(df2_scaled)


#-----------train test splite------------------------------------------------------------
# Load the caTools package 
library(caTools)# Create a sample split

sample <- sample.split(df2_scaled$price, SplitRatio = 0.7)

# Create training and testing sets
train <- subset(df2_no_ottliers, sample == TRUE)
test <- subset(df2_no_ottliers, sample == FALSE)

# View sizes of training and testing sets 
cat("Training set size:", nrow(train), "\n") 
cat("Testing set size:", nrow(test),"\n")



#------------------------Support Vector Machine Model--------------------------------------------------------------------------

#install.packages("e1071")
library(e1071)

# Support Vector Machine Model
model_svm <- svm(price ~ ., data = train)

# Predict on the test set
predictions <- predict(model_svm, newdata = test)

# Calculate Mean Squared Error (MSE)
mse <- mean((test$price - predictions)^2)
cat("SVM - Mean Squared Error:", mse, "\n")

# Calculate R-squared
rsq <- cor(test$price, predictions)^2
cat("SVM - R-squared:", rsq, "\n")


#---------------------------------------Gradient Boosting Model-------------------------------------------
install.packages("gbm") 
library(gbm)

# Gradient Boosting Model
model <- gbm(price ~ ., data = train, distribution = "gaussian", n.trees = 100, interaction.depth = 3, shrinkage = 0.01, cv.folds = 5)

# Predict on the test set
predictions <- predict(model, newdata = test, n.trees = 100)

# Calculate Mean Squared Error (MSE)
mse <- mean((test$price - predictions)^2)
cat("Gradient Boosting - Mean Squared Error:", mse, "\n")

# Calculate R-squared
rsq <- cor(test$price, predictions)^2
cat("Gradient Boosting - R-squared:", rsq, "\n")



#SVM - Mean Squared Error: 16988466288 
#SVM - R-squared: 0.6406572 

#Gradient Boosting - Mean Squared Error: 23964266841 
#Gradient Boosting - R-squared: 0.6111212

# So we choose SVM as MSE is smaller & R square is higher to 64%.
