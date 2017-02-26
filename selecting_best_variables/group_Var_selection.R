library(caret)
library(funModeling)
library(dplyr)

## setting cross-validation 4-fold
fitControl = trainControl(method = "cv",
                          number = 4,
                          classProbs = TRUE,
                          summaryFunction = twoClassSummary)

  
fit_2a = train(x=select(heart_disease, -heart_disease_severity,-has_heart_disease),
              y = heart_disease$has_heart_disease,
              method = "gbm",
              trControl = fitControl,
              verbose = FALSE,
              metric = "ROC")

fit_2b = train(x=select(heart_disease, chest_pain),
              y = heart_disease$has_heart_disease,
              method = "gbm",
              trControl = fitControl,
              verbose = FALSE,
              metric = "ROC")

fit_2c = train(x=select(heart_disease, max_heart_rate, chest_pain),
               y = heart_disease$has_heart_disease,
               method = "gbm",
               trControl = fitControl,
               verbose = FALSE,
               metric = "ROC")

sprintf("ROC value ", max(fit_2a$results$ROC))
max(fit_2b$results$ROC)
max(fit_2c$results$ROC)


# observed counts for each bin
y = c(4, 2, 3, 0, 2, 4, 0, 0, 2, 100000, 100000)
y = c(4, 2, 3, 0, 2, 4, 0, 0, 2, 2, 2)
y = c(10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10)
library(entropy)
entropy(y, method="ML")
entropy(y, method="MM")
entropy(y, method="Jeffreys")
entropy(y, method="Laplace")
entropy(y, method="SG")
entropy(y, method="minimax")
entropy(y, method="CS")
#entropy(y, method="NSB")
entropy(y, method="shrink")

######
install.packages("mRMRe")
library(mRMRe)
data(cgps)
data.annot <- data.frame(cgps.annot)
data.cgps <- data.frame(cgps.ic50, cgps.ge)

dd <- mRMR.data(data = data.cgps)
mRMR.classic(data = dd, target_indices = c(1), feature_count = 30)

################################################################################
################################################################################
################################################################################
heart_disease$gender=factor(heart_disease$gender, ordered = T)
heart_disease$thal=factor(heart_disease$thal, ordered = T)
heart_disease$fasting_blood_sugar=factor(heart_disease$fasting_blood_sugar, ordered = T)
heart_disease$resting_electro=factor(heart_disease$resting_electro, ordered = T)
heart_disease$exer_angina=factor(heart_disease$exer_angina, ordered = T)
heart_disease$exter_angina=factor(heart_disease$exter_angina, ordered = T)
heart_disease$has_heart_disease=factor(heart_disease$has_heart_disease, ordered = T)
heart_disease[, c(1,4,5,14,12,11,8)] <- sapply(heart_disease[, c(1,4,5,14,12,11,8)], as.numeric)

heart_disease=data.frame(heart_disease)
str(heart_disease)

dd <- mRMR.data(data = heart_disease)
a=mRMR.classic(data = dd, target_indices = c(16), feature_count = 5)
as.numeric(a@filters$`16`)

a2=mRMR.ensemble(data = dd, target_indices = c(16),solution_count = 3, feature_count = 5)
a2@filters$`16`

b=heart_disease[,as.numeric(a@filters$`16`)]


## setting cross-validation 4-fold
fitControl = trainControl(method = "cv",
                          number = 4,
                          classProbs = TRUE,
                          summaryFunction = twoClassSummary)

## creating the model finding the best tunning (mtry parameter)
fit_1 = train(x=select(heart_disease, -has_heart_disease, -heart_disease_severity),
              y = heart_disease$has_heart_disease,
              method = "rf",
              trControl = fitControl,
              verbose = FALSE,
              metric = "ROC")
max(fit_1$results$ROC)

## PROBANDO CON LO QUE ME DICE EL OTRO METODO
fit_2 = train(x=select(heart_disease, -has_heart_disease,as.numeric(a@filters$`16`),-heart_disease_severity),
              y = heart_disease$has_heart_disease,
              method = "rf",
              trControl = fitControl,
              verbose = FALSE,
              metric = "ROC")

max(fit_2$results$ROC)

