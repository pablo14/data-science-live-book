
In this post we

Cross-validation
Boostra

library(caret)

### Getting to the data
data(iris)
input_data = iris[,1:4]
target = iris[,5]

## Setting fixed seed for reproducibility (so you'll get same results). Using Fibonnacci numbers for fun ;)
my_seeds=c(1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765, 10946, 17711, 28657, 46368, 75025, 121393)

## Getting Accuracy metrics with Bootstrapping
fit_rf_bootstrapping = train(input_data,
                            target, 
                            method="rf", 
                            tuneGrid = data.frame(mtry=1),
                            trControl=trainControl(method='boot', seeds=my_seeds))


## Plotting 
resampleHist(fit_rf_bootstrapping)

print(fit_rf_bootstrapping)

mean(fit_rf_bootstrapping$resample$Accuracy)

## Getting Accuracy metrics with Cross-Validation
fit_rf_cv = train(input_data,
                   target,
                   method="rf", 
                   tuneGrid = data.frame(mtry=1),
                   trControl = trainControl(method="cv", number=10, seeds=my_seeds[1:11])
                   )

resampleHist(fit_rf_cv)

fit_rf_cv

mean(fit_rf_cv$resample$Accuracy)
summary(fit_rf_cv$resample$Accuracy)


########
Further reading: 
* More on estimating accuracy with caret <a href="http://machinelearningmastery.com/how-to-estimate-model-accuracy-in-r-using-the-caret-package/">here</a>.
* Comparing different cross-validation techniques using simulations <a href="http://appliedpredictivemodeling.com/blog/2014/11/27/vpuig01pqbklmi72b8lcl3ij5hj2qm">here</a>.
* Want to read a while? Model validation with caret <a href="https://topepo.github.io/caret/model-training-and-tuning.html">official documentation</a>.


library(randomForest)
library(dplyr)
library(caret)

fit_rf=randomForest(has_heart_disease ~ chest_pain + oldpeak + max_heart_rate, heart_disease)

  
  
## Not run: 
data(iris)
TrainData <- iris[,1:4]
TrainClasses <- iris[,5]

fit_rf <- train(has_heart_disease ~ chest_pain + oldpeak + max_heart_rate, 
                data=heart_disease,
                method="rf", 
                trControl = trainControl(classProbs = TRUE),
                tuneGrid = data.frame(mtry=2))

fit_rf$resampledCM

resampleHist(fit_rf$resample)

knnFit$resample



###############
## Not run: 
data(iris)
TrainData <- iris[,1:4]
TrainClasses <- iris[,5]

knnFit <- train(TrainData, TrainClasses, "knn", tuneGrid = data.frame(k=3))
knnFit
resampleHist(knnFit)

a=knnFit$control$index$Resample01
b=knnFit$control$indexOut$Resample01

a_uq=unique(knnFit$control$index$Resample01)
b_uq=unique(knnFit$control$indexOut$Resample01)


# load the library
library(caret)
# load the iris dataset
data(iris)
# define training control
train_control <- trainControl(method="boot", number=100)
# train the model
model <- train(Species~., data=iris, trControl=train_control, method="nb")
# summarize results
print(model)


#######

# load the library
library(caret)
# load the iris dataset
data(iris)
# define training control
train_control <- trainControl(method="cv", number=10)
# fix the parameters of the algorithm
grid <- expand.grid(.fL=c(0), .usekernel=c(FALSE))
# train the model
model <- train(Species~., data=iris, trControl=train_control, method="nb", tuneGrid=grid)
# summarize results
print(model)
