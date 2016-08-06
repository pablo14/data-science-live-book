Profiling Data
====


### What is this about? 

Quantity of zeros, NA, Inf, unique values; as well as the data type may lead to a good or bad model. Here an approach to cover the very first step in data modeling. 




```r
## Loading funModeling !
suppressMessages(library(funModeling))
data(heart_disease)
```

### Checking NA, zeros, data type and unique values

```r
my_data_status=df_status(heart_disease)
```

```
##                  variable q_zeros p_zeros q_na p_na q_inf p_inf    type
## 1                     age       0    0.00    0 0.00     0     0 integer
## 2                  gender       0    0.00    0 0.00     0     0  factor
## 3              chest_pain       0    0.00    0 0.00     0     0  factor
## 4  resting_blood_pressure       0    0.00    0 0.00     0     0 integer
## 5       serum_cholestoral       0    0.00    0 0.00     0     0 integer
## 6     fasting_blood_sugar     258   85.15    0 0.00     0     0  factor
## 7         resting_electro     151   49.83    0 0.00     0     0  factor
## 8          max_heart_rate       0    0.00    0 0.00     0     0 integer
## 9             exer_angina     204   67.33    0 0.00     0     0 integer
## 10                oldpeak      99   32.67    0 0.00     0     0 numeric
## 11                  slope       0    0.00    0 0.00     0     0 integer
## 12      num_vessels_flour     176   58.09    4 1.32     0     0 integer
## 13                   thal       0    0.00    2 0.66     0     0  factor
## 14 heart_disease_severity     164   54.13    0 0.00     0     0 integer
## 15           exter_angina     204   67.33    0 0.00     0     0  factor
## 16      has_heart_disease       0    0.00    0 0.00     0     0  factor
##    unique
## 1      41
## 2       2
## 3       4
## 4      50
## 5     152
## 6       2
## 7       3
## 8      91
## 9       2
## 10     40
## 11      3
## 12      4
## 13      3
## 14      5
## 15      2
## 16      2
```
* `q_zeros`: quantity of zeros (`p_zeros`: in percentage)
* `q_inf`:  quantity of infinite values (`p_na`: in percentage)
* `q_na`:  quantity of NA (`p_na`: in percentage)
* `type`: factor or numeric
* `unique`: quantity of unique values

#### Why are these metrics important?
* **Zeros**: Variables with **lots of zeros** may be not useful for modeling, and in some cases it may dramatically bias the model.
* **NA**: Several models automatically exclude rows with NA (**random forest**, for example). As a result, the final model can be biased due to several missing rows because of only one variable. For example, if the data contains only one out of 100 variables with 90% of NAs, the model will be training with only 10% of original rows.
* **Inf**: Infinite values may lead to an unexpected behavior in some functions in R.
* **Type**: Some variables are encoded as numbers, but they are codes or categories, and the models **don't handle them** in the same way.
* **Unique**: Factor/categorical variables with a high number of different values (~30), tend to do overfitting if categories have low representative, (**decision tree**, for example).

#### Filtering unwanted cases
Function `df_status` takes a data frame and returns a the status table to quickly remove unwanted cases.


**Removing variables with high number of NA/zeros**

```r
# Removing variables with 60% of zero values
vars_to_remove=subset(my_data_status, my_data_status$p_zeros > 60)
vars_to_remove["variable"]
```

```
##               variable
## 6  fasting_blood_sugar
## 9          exer_angina
## 15        exter_angina
```

```r
## Keeping all except vars_to_remove 
heart_disease_2=heart_disease[, !(names(heart_disease) %in% vars_to_remove[,"variable"])]
```

**Ordering data by percentage of zeros**

```r
my_data_status[order(-my_data_status$p_zeros), c('variable', 'p_zeros')] 
```

```
##                  variable p_zeros
## 6     fasting_blood_sugar   85.15
## 9             exer_angina   67.33
## 15           exter_angina   67.33
## 12      num_vessels_flour   58.09
## 14 heart_disease_severity   54.13
## 7         resting_electro   49.83
## 10                oldpeak   32.67
## 1                     age    0.00
## 2                  gender    0.00
## 3              chest_pain    0.00
## 4  resting_blood_pressure    0.00
## 5       serum_cholestoral    0.00
## 8          max_heart_rate    0.00
## 11                  slope    0.00
## 13                   thal    0.00
## 16      has_heart_disease    0.00
```

<br>
