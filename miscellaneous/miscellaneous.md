Miscellaneous
====

### What is this about?

Here are some functions that don't fit in the other sections.





```r
## Loading funModeling !
suppressMessages(library(funModeling))
data(heart_disease)
```


<br>

-----------------------

## Part A) Comparing vectors

**What does it do?**: Get the elements present (and not) between 2 vectors.

**Machine Learning purpose:** It's a common practice to run several times a variable selecting algorithm, getting in every run different variables. _So what are the new variables?_ and, _what are the ones that are not present anymore?_


```r
v1=c("height","weight","age")
v2=c("height","weight","location","q_visits")

res=v_compare(vector_x=v1, vector_y=v2)
```

```
## [1] "Coincident in both: 2"
## [1] "Rows not present in X: 2"
## [1] "Rows not present in Y: 1"
```

```r
# Print the keys (or values) that didn't match
res
```

```
## $present_in_both
## [1] "height" "weight"
## 
## $rows_not_in_X
## [1] "location" "q_visits"
## 
## $rows_not_in_Y
## [1] "age"
```

<br>

-----------------------

## Part B) Sampling training and test data

**What does it do?** Split input data into training and test set, retrieving always same sample by setting the seed.

It's important to encapsulate sampling generation in a function so it will return always the same sample (change the default sample by modifying the `seed` parameter).


```r
# Training and test data. Percentage of training cases default value=80%.
index_sample=get_sample(data=heart_disease, percentage_tr_rows=0.8)

# It returns a TRUE/FALSE vector same length as 'data' param. TRUE represents that that particular will be hold for training data

## Generating the samples
data_tr=heart_disease[index_sample,]
data_ts=heart_disease[-index_sample,] # excluding all rows that belong to training

# percentage_tr_rows: range value from 0.1 to 0.99, default value=0.8 (80 percent of training data)
```

-----------------------

## Part C) Filter variables from data frame by -string- name

Based on the variable names present in `str_input`, it returns the data frame with only the requested columns (`keep=T`), or it deletes the specified ones (`keep=F`).


```r
# Selecting variables
my_data_1=filter_vars(mtcars, str_input=c('mpg', 'cyl'))
colnames(my_data_1)
```

```
## [1] "mpg" "cyl"
```

```r
# Deleting all except desiered variables
my_data_2=filter_vars(mtcars, str_input=c('mpg', 'cyl', 'qsec', 'vs'), keep=FALSE)
colnames(my_data_2)
```

```
## [1] "disp" "hp"   "drat" "wt"   "am"   "gear" "carb"
```
