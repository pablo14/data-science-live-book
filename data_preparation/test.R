library(caret)
fitControl <- trainControl(method = "cv", 
                           number = 4, 
                           classProbs = TRUE,
                           summaryFunction = twoClassSummary)


fit_gbm_1 <- train(has_flu ~ country, 
                 data = data_country, 
                 method = "gbm", 
                 trControl = fitControl,
                 verbose = FALSE,
                 metric = "ROC")



#plot(roc(predictor = fit_gbm_1$finalModel$pred$CLASSNAME, response = modelObject$pred$obs))

data_country$score=predict(fit_gbm_1, data_country, type = 'prob')[,2]
gain_lift(data_country,str_score = 'score', str_target = 'has_flu')

my_roc=roc(response=data_country$has_flu, predictor=data_country$score);my_roc

##############
data_country$has_flu2=ifelse(data_country$has_flu=="no", 0, 1)
grp2=dplyr::group_by(data_country, country) %>% dplyr::summarise(sum_paid=sum(has_flu2), 
                                                   perc_paid=sum(has_flu2)/sum(data_country$has_flu2), 
                                                   mean_paid=round(mean(has_flu2),3), 
                                                   q_rows=n(), 
                                                   p_rows=round(n()/nrow(data_country),3)) %>%
                                                          arrange(-sum_paid)
grp2

#####################
d=select(grp2, -country, -p_rows)
set.seed(11112)
fit=kmeans(scale(data.frame(d)),8)
fit$centers;fit$size

## Call the function
grp$country_group=paste("group_", fit$cluster, sep = "") 

data_country=merge(data_country, select(grp, country, country_group))


########

#data_country2$score=predict(fit_gbm_2, data_country2, type = 'prob')[,2]
#gain_lift(data_country2,str_score = 'score', str_target = 'has_flu')

#my_roc=roc(response=data_country2$has_flu, predictor=data_country2$score);my_roc

