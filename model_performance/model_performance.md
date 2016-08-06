Assessing Model Performance
====

**Overview**: Once the predictive model is developed with `training` data, it should be compared with `test` data (which wasn't seen by the model before). Here is presented a wrapper for the **ROC Curve** and **AUC** (area under ROC) and  the **KS** (Kolmogorov-Smirnov).




```r
## Loading funModeling !
suppressMessages(library(funModeling))
data(heart_disease)
```

### Creating the model

```r
## Training and test data. Percentage of training cases default value=80%.
index_sample=get_sample(data=heart_disease, percentage_tr_rows=0.8)

## Generating the samples
data_tr=heart_disease[index_sample,] 
data_ts=heart_disease[-index_sample,]


## Creating the model only with training data
fit_glm=glm(has_heart_disease ~ age + oldpeak, data=data_tr, family = binomial)
```

### ROC, AUC and KS performance metrics

```r
## Performance metrics for Training Data
model_performance(fit=fit_glm, data = data_tr, target_var = "has_heart_disease")
```

![plot of chunk model_perfomance2](figure/model_perfomance2-1.png)

```
## 
## -----------
##  AUC   KS  
## ----- -----
## 0.759 0.406
## -----------
```

```r
## Performance metrics for Test Data
model_performance(fit=fit_glm, data = data_ts, target_var = "has_heart_disease")
```

![plot of chunk model_perfomance2](figure/model_perfomance2-2.png)

```
## 
## -----------
##  AUC   KS  
## ----- -----
## 0.748 0.456
## -----------
```

**Key notes**

* The **higher** the KS and AUC, the **better** the performance is.
    + KS range: from 0 to 1.
    + AUC range: from 0.5 to 1.
* Performance metrics should be **similar** between training and test set.

**Final comments**

* KS and AUC focus on similar aspects: How well the model distinguishes the class to predict.
* ROC and AUC article: https://en.wikipedia.org/wiki/Receiver_operating_characteristic
