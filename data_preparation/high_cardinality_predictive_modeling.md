

<img src="http://i.imgur.com/GijXkrp.png" width="800px"> 

# High Cardinality Variable in Predictive Modeling


## What is this about?

As we've seen in the other chapter (<a href="http://livebook.datascienceheroes.com/data_preparation/high_cardinality_descriptive_stats.html" target="blank">Reducing categories in descriptive stats</a>) we keep the categories with the major representativeness, but how about having another variable to predict with it? That is, to predict `has_flu` based on `country`.

Using the last method may destroy the information of the variable, thus it **loses predictive power**. In this chapter we'll go further in the method described above, using an automatic grouping function -`auto_grouping`- surfing through the variable's structure, giving some ideas about how to optimize a categorical variable, but more importantly: encouraging the reader to perform her-his own optimizations.

Other literature named this re-grouping as cardinality reduction or **encoding**.

<br>

**What are we going to review in this chapter?**

* Concept of representativeness of data (sample size).
* Sample size having a target or outcome variable.
* From R: Present a method to help reduce cardinality and profiling categoric variable.
* A practical before-and-after example reducing cardinality and insights extraction.
* How different models such as random forest or a gradient boosting machine deals with categorical variables.

<br>

## But is it necessary to re-group the variable?

It depends on the case, but the quickest answer is yes. In this chapter we will see one case in which this data preparation increases overall accuracy (measuring by the Area Under Roc Curve).

There is a tradeoff between the **representation of the data** (how many rows each category has), and how is each category related to the outcome variable. E.g.: some countries are more prone to cases of flu than others


```r
# Loading funModeling >=1.6 which contains functions to deal with this. 
library(funModeling)
library(dplyr)
```

Profiling `data_country`, which comes inside `funModeling` package (please update to release 1.6.5).

Quick `data_country` profiling (first 10 rows)


```r
# plotting first 10 rows
head(data_country, 10)
```

```
##     person     country has_flu
## 478    478      France      no
## 990    990      Brazil      no
## 606    606      France      no
## 575    575 Philippines      no
## 806    806      France      no
## 232    232      France      no
## 422    422      Poland      no
## 347    347     Romania      no
## 858    858     Finland      no
## 704    704      France      no
```

```r
# exploring data, displaying only first 10 rows
head(freq(data_country, "country"), 10)
```

<img src="figure/high_cardinality_variable-1.png" title="plot of chunk high_cardinality_variable" alt="plot of chunk high_cardinality_variable" width="700px" />

```
##           country frequency percentage cumulative_perc
## 1          France       288      31.65           31.65
## 2          Turkey        67       7.36           39.01
## 3           China        65       7.14           46.15
## 4         Uruguay        63       6.92           53.07
## 5  United Kingdom        45       4.95           58.02
## 6       Australia        41       4.51           62.53
## 7         Germany        30       3.30           65.83
## 8          Canada        19       2.09           67.92
## 9     Netherlands        19       2.09           70.01
## 10          Japan        18       1.98           71.99
```


```r
# exploring data
freq(data_country, "has_flu")
```

<img src="figure/data_preparation_high_cardinality_variable-1.png" title="plot of chunk data_preparation_high_cardinality_variable" alt="plot of chunk data_preparation_high_cardinality_variable" width="600px" />

```
##   has_flu frequency percentage cumulative_perc
## 1      no       827      90.88           90.88
## 2     yes        83       9.12          100.00
```


<br>

## The case 🔍

The predictive model will try to map certain values with certain outcomes, in our case the target variable is binary.

We'll computed a complete profiling of `country` regarding the target variable `has_flu` based on `categ_analysis`. 

Each row represent an unique category of `input` variables. Withing each row you can find attributes that define each category in terms of representativeness and likelihood. 



```r
## `categ_analysis` is available in "funModeling" >= v1.6, please install it before using it.
country_profiling=categ_analysis(data=data_country, input="country", target = "has_flu")

## Printing first 15 rows (countries) out of 70.
head(country_profiling, 15)
```

<img src="country_profiling.png" alt="profiling country for predictive modeling" width="500px">

<br>

* Note 1: _The first column automatically adjusts its name based on `input` variable_
* Note 2: _`has_flu` variable has values `yes` and `no`, `categ_analysis` assigns internally the number **1** to the less representative class, `yes` in this case, in order to calculate the mean, sum and percentage._

These are the metrics returned by `categ_analysis`:

* `country`: name of each category in `input` variable.
* `mean_target`: `sum_target/q_rows`, average number of `has_flu="yes"` for that category. This is the likelihood.
* `sum_target`: quantity of `has_flu="yes"` values are in each category.
* `perc_target`: the same as `sum_target` but in percentage,  `sum_target of each category / total sum_target`. This column sums `1.00`.
* `q_rows`: quantity of rows that, regardless of the `has_flu` variable, fell in that category. It's the distribution of `input`. This column sums the total rows analyzed.
* `perc_rows`: related to `q_rows` it represents the share or percentage of each category. This column sums `1.00`

<br>

### What conclusions can we draw from this?

Reading example based on 1st row, `France`:

* 41 people have flu (`sum_target=41`). These 41 people represent almost 50% of the total people having flu (`perc_target=0.494`).
* Likelihood of having flu in France is 14.2% (`mean_target=0.142`)
* Total rows from France=288 -out of 910-. This is the `q_rows` variable; `perc_rows` is the same number but in percentage.

Without considering the filter by country, we've got:

* Column `sum_target` sums the total people with flu present in data.
* Column `perc_target` sums `1.00` -or 100%
* Column `q_rows` sums total rows present in `data_country` data frame.
* Column `perc_rows` sums `1.00` -or 100%.

<br>

---

## Analysis for Predictive Modeling 🔮

When developing predictive models, we may be interested in those values which increases the likelihood of a certain event. In our case:

**What are the countries that  maximize the likelihood of finding people with flu?**

Easy, take `country_profiling` in a descending order by `mean_target`:


```r
# Ordering country_profiling by mean_target and then take the first 6 countries
arrange(country_profiling, -mean_target) %>%  head(.)
```

```
##          country mean_target sum_target perc_target q_rows perc_rows
## 1       Malaysia       1.000          1       0.012      1     0.001
## 2         Mexico       0.667          2       0.024      3     0.003
## 3       Portugal       0.200          1       0.012      5     0.005
## 4 United Kingdom       0.178          8       0.096     45     0.049
## 5        Uruguay       0.175         11       0.133     63     0.069
## 6         Israel       0.167          1       0.012      6     0.007
```

<br>

Great! We've got `Malasyia` as the country with the highest likelihood to have flu! 100% of people there have flu (`mean_has_flu=1.000`).

But our common sense advises us that _perhaps_ something is wrong...

How many rows does Malasya have? Answer: 1. -column: `q_rows=1`
How many positive cases does Malasya have? Answer: 1 -column: `sum_target=1`

Since the sample cannot be increased see if this proportion stays high, it will contribute to **overfit** and create a bias on the predictive model.

How about `Mexico`? 2 out of 3 have flu... it still seems low. However `Uruguay` has 17.3% likelihood -11 out of 63 cases- and these 63 cases represents almost 7% of total population (`perc_row=0.069`), this ratio seems more credible.

Next there are some ideas to treat this:

---

### Case 1: Reducing by re-categorizing less representative values

Keep all cases with at least certain percentage of representation in data. Let's say to rename the countries that have less than 1% of presence in data to `others`.


```r
country_profiling=categ_analysis(data=data_country, input="country", target = "has_flu")

countries_high_rep=filter(country_profiling, perc_rows>0.01) %>% .$country

## If not in countries_high_rep then assign `other` category
data_country$country_new=ifelse(data_country$country %in% countries_high_rep, data_country$country, "other")
```

Checking again the likelihood:


```r
country_profiling_new=categ_analysis(data=data_country, input="country_new", target = "has_flu")
country_profiling_new
```

```
##       country_new mean_target sum_target perc_target q_rows perc_rows
## 1  United Kingdom       0.178          8       0.096     45     0.049
## 2         Uruguay       0.175         11       0.133     63     0.069
## 3          Canada       0.158          3       0.036     19     0.021
## 4          France       0.142         41       0.494    288     0.316
## 5         Germany       0.100          3       0.036     30     0.033
## 6       Australia       0.098          4       0.048     41     0.045
## 7         Romania       0.091          1       0.012     11     0.012
## 8           Spain       0.091          1       0.012     11     0.012
## 9          Sweden       0.083          1       0.012     12     0.013
## 10    Netherlands       0.053          1       0.012     19     0.021
## 11          other       0.041          7       0.084    170     0.187
## 12         Turkey       0.030          2       0.024     67     0.074
## 13        Belgium       0.000          0       0.000     15     0.016
## 14         Brazil       0.000          0       0.000     13     0.014
## 15          China       0.000          0       0.000     65     0.071
## 16          Italy       0.000          0       0.000     10     0.011
## 17          Japan       0.000          0       0.000     18     0.020
## 18         Poland       0.000          0       0.000     13     0.014
```

We've reduced the quantity of countries drastically -**74% less**- only by shrinking the less representative at 1%. Obtaining 18 out of 70 countries.

Likelihood of target variable has been stabilised a little more in `other` category. Now when the predictive model _sees_ `Malasya`  it will **not assign 100% of likelihood, but 4.1%** (`mean_has_flu=0.041`).

**Advice about this last method:**

Watch out about applying this technique blindly. Sometimes in a **highly unbalanced** target prediction -e.g. **anomaly detection**- the abnormal behavior is present in less than 1% of cases.


```r
# replicating the data
d_abnormal=data_country

# simulating abnormal behavior with some countries
d_abnormal$abnormal=ifelse(d_abnormal$country %in% c("Brazil", "Chile"), 'yes', 'no')

# categorical analysis
ab_analysis=categ_analysis(d_abnormal, input = "country", target = "abnormal")

## displaying only first 6 elements
head(ab_analysis)
```

```
##               country mean_target sum_target perc_target q_rows perc_rows
## 1              Brazil           1         13       0.867     13     0.014
## 2               Chile           1          2       0.133      2     0.002
## 3           Argentina           0          0       0.000      9     0.010
## 4 Asia/Pacific Region           0          0       0.000      1     0.001
## 5           Australia           0          0       0.000     41     0.045
## 6             Austria           0          0       0.000      1     0.001
```

```r
# inspecting distributrion, just a few belongs to ' 'no' categoryreq(d_abnormal, "abnormal", plot = F)
```

_How many abnormal values are there?_

Only 15, and they represent 1.65% of total values.

Checking the table returned by `categ_analysis`, we can see that this _abnormal behavior_ occurs **only**  in categories with a really low participation: `Brazil` which is present in only 1.4% of cases, and `Chile` with 0.2%.

Creating a category `other` based on the distribution is not a good idea here.

**Conclusion:**

Despite the fact this is a prepared example, there are some data preparations techniques that can be really useful in terms of accuracy, but they need some supervision. This supervision can be helped by algorithms.

<br>

### Case 2: Reducing by automatic grouping

This procedure uses the `kmeans` clustering technique and the table returned by `categ_analysis` in order to create groups -clusters- which contain categories which exhibit similar behavior in terms of:

* `perc_rows`
* `perc_target`

The combination of both will lead to find groups considering likelihood and representativeness.


**Hands on R:**

We define the `n_groups` parameter, it's the number of desired groups. The number is relative to the data and the number of total categories. But a general number would be between 3 and 10.

Function `auto_grouping` comes in `funModeling` >=1.6. Please note that the `target` parameter only supports for now binary variables.

_Note: the `seed` parameter is optional, but assigning a number will retrieve always the same results._


```r
## Reducing the cardinality
country_groups=auto_grouping(data = data_country, input = "country", target="has_flu", n_groups=9, seed = 999)
country_groups$df_equivalence
```

```
##                      country country_rec
## 1                  Australia     group_1
## 2                     Canada     group_1
## 3                    Germany     group_1
## 4                     France     group_2
## 5                      China     group_3
## 6                     Turkey     group_3
## 7        Asia/Pacific Region     group_4
## 8                    Austria     group_4
## 9                 Bangladesh     group_4
## 10    Bosnia and Herzegovina     group_4
## 11                  Cambodia     group_4
## 12                     Chile     group_4
## 13                Costa Rica     group_4
## 14                   Croatia     group_4
## 15                    Cyprus     group_4
## 16            Czech Republic     group_4
## 17        Dominican Republic     group_4
## 18                     Egypt     group_4
## 19                     Ghana     group_4
## 20                    Greece     group_4
## 21 Iran, Islamic Republic of     group_4
## 22                   Ireland     group_4
## 23               Isle of Man     group_4
## 24                    Latvia     group_4
## 25                 Lithuania     group_4
## 26                Luxembourg     group_4
## 27                     Malta     group_4
## 28      Moldova, Republic of     group_4
## 29                Montenegro     group_4
## 30                  Pakistan     group_4
## 31     Palestinian Territory     group_4
## 32                      Peru     group_4
## 33              Saudi Arabia     group_4
## 34                   Senegal     group_4
## 35                  Slovenia     group_4
## 36                    Taiwan     group_4
## 37                  Thailand     group_4
## 38                   Vietnam     group_4
## 39                   Belgium     group_5
## 40                    Brazil     group_5
## 41                  Bulgaria     group_5
## 42                 Hong Kong     group_5
## 43                     Italy     group_5
## 44                    Poland     group_5
## 45                 Singapore     group_5
## 46              South Africa     group_5
## 47                 Argentina     group_6
## 48                    Israel     group_6
## 49                  Malaysia     group_6
## 50                    Mexico     group_6
## 51                  Portugal     group_6
## 52                   Romania     group_6
## 53                     Spain     group_6
## 54                    Sweden     group_6
## 55               Switzerland     group_6
## 56                     Japan     group_7
## 57               Netherlands     group_7
## 58            United Kingdom     group_8
## 59                   Uruguay     group_8
## 60                   Denmark     group_9
## 61                   Finland     group_9
## 62                  Honduras     group_9
## 63                 Indonesia     group_9
## 64        Korea, Republic of     group_9
## 65                   Morocco     group_9
## 66               New Zealand     group_9
## 67                    Norway     group_9
## 68               Philippines     group_9
## 69        Russian Federation     group_9
## 70                   Ukraine     group_9
```

`auto_grouping` returns a list containing 3 objects:

* `df_equivalence`: data frame which contains a table to map old to new values.
* `fit_cluster`: k-means model used to reduce the cardinality (values are scaled).
* `recateg_results`: data frame containing the profiling of each group regarding target variable, first column adjusts its name to the input variable in this case we've got: `country_rec`. Each group correspond to one or many cainput's categoriesariable (as seen in `df_equivalence`).

Let's explore how the new groups behave, this is what the predictive model will _see_:


```r
country_groups$recateg_results
```

```
##   country_rec mean_target sum_target perc_target q_rows perc_rows
## 1     group_8       0.176         19       0.229    108     0.119
## 2     group_6       0.156         10       0.120     64     0.070
## 3     group_2       0.142         41       0.494    288     0.316
## 4     group_1       0.111         10       0.120     90     0.099
## 5     group_7       0.027          1       0.012     37     0.041
## 6     group_3       0.015          2       0.024    132     0.145
## 7     group_4       0.000          0       0.000     49     0.054
## 8     group_5       0.000          0       0.000     85     0.093
## 9     group_9       0.000          0       0.000     57     0.063
```

Last table is ordered by `mean_target`, so we can quickly see groups maximizing and minimizing the likelihood.


* `group_2` is the most common, it is present in 31.6% of cases and `mean_target` (likelihood) is 14.2%.
* `group_8` has the highest likelihood (17.6%). Followed by `group_6` with chance of 15.6% of having a positive case (`has_flu="yes"`).
* `group_4`, `group_4` and `group_9` looks the same. They can be one group since likelihood is 0 in all the cases.
* `group_7` and `group_3` have 1 and 2 countries with positive cases. We could consider these numbers as the same, grouping them into one group, which in the end will represent the countries with the lowest likelihood.

All the groups seems to have a good repreesntation. This can be checked in `perc_rows` variable. All cases are above of 7% share. 



```r
data_country_2=data_country %>% inner_join(country_groups$df_equivalence, by="country")
```

Now we do the additional transformations replacing:

* `group_4` and `group_5` will be `group_5`.
* `group_7` will be `group_3`.


```r
data_country_2$country_rec=ifelse(data_country_2$country_rec == "group_4", "group_5", data_country_2$country_rec)
data_country_2$country_rec=ifelse(data_country_2$country_rec == "group_9", "group_5", data_country_2$country_rec)

data_country_2$country_rec=ifelse(data_country_2$country_rec == "group_3", "group_7", data_country_2$country_rec)
```

Checking the final grouping (`country_rec` variable):


```r
categ_analysis(data=data_country_2, input="country_rec", target = "has_flu")
```

```
##   country_rec mean_target sum_target perc_target q_rows perc_rows
## 1     group_8       0.176         19       0.229    108     0.119
## 2     group_6       0.156         10       0.120     64     0.070
## 3     group_2       0.142         41       0.494    288     0.316
## 4     group_1       0.111         10       0.120     90     0.099
## 5     group_7       0.018          3       0.036    169     0.186
## 6     group_5       0.000          0       0.000    191     0.210
```

Each group seems to have a good sample size regarding the `sum_target` distribution. Our transformation left `group_5` with a representation of 21% of total cases, still with 0 positive cases (`sum_target`=0). And `group_7` with 3 positive cases, which represents 3.36% of positive cases.

<br>

 
## Handling new categories when the predictive model is on production

Let's imagine a new country appears, `new_country_hello_world`, predictive models will fail since they were trained with fixed values. One technique is to assign a group which has `mean_target=0`.

It's similar to the case in last example. But the difference lies in `group_5`, this category would fit better in a mid-likelihood group than a complete new value.

After some time we should re-build the model with all new values, otherwise we would be penalizing `new_country_hello_world` if it has a good likelihood.

In so many words:

_A new category appears? Send to the least meaningful group. After a while, re-analyze its impact. Does it have a mid or high likelihood? Change it to the most suitable group._

<br>

---

## Do predictive models handle high cardinality? Part 1

Yes, and no. Some models deal with this high cardinality issue better than others. In some scenarios, this data preparation may not be necessary. This book tries to expose this issue, which sometimes, may lead to a better model. 

Now, we're going throught this by building two predictive models: Gradient Boosting Machine -quite robust across many different data inputs.

The first model doesn't have treated data, and the second one has been treated by the function in `funModeling` package.

We're measuring the precision based on ROC area, ranged from 0.5 to 1, the higher the number the better the model is. We are going to use cross-validation to be _sure_ about the value. The importance of cross-validate results is treated in <a href="http://livebook.datascienceheroes.com/model_performance/knowing_the_error.html" target="blank">Knowing the error</a> chapter.


```r
## Building the first model, without reducing cardinality.
library(caret)
fitControl <- trainControl(method = "cv",
                           number = 4,
                           classProbs = TRUE,
                           summaryFunction = twoClassSummary)


fit_gbm_1 <- train(has_flu ~ country,
                   data = data_country_2,
                   method = "gbm",
                   trControl = fitControl,
                   verbose = FALSE,
                   metric = "ROC")


# Getting best ROC value
roc=round(max(fit_gbm_1$results$ROC),2)
```

Area under ROC curve is (`roc`): 0.67.

Now we do the same model with the same parameters, but with the data preparation we did before.

<br>
  

```r
## Building the second model, based on the country_rec variable
fit_gbm_2 <- train(has_flu ~ country_rec,
                   data = data_country_2,
                   method = "gbm",
                   trControl = fitControl,
                   verbose = FALSE,
                   metric = "ROC")

## Getting new best ROC value
new_roc=round(max(fit_gbm_2$results$ROC),2)
```

New ROC curve is (`new_roc`): 0.71.

Then we calculate the percentage of improvement over first roc value:

**Improvement: ~ 5.97%**. ✅

Not too bad, right?

**A short comment about last test:**

We've used one of the most robust models, **gradient boosting machine**, and we've increased the performance. If we try other model, for example <a href="https://en.wikipedia.org/wiki/Logistic_regression" target="blank">logistic regression</a>, which is more sensible to dirty data, we'll get a higher difference between reducing and not reducing cardinality. This can be checked deleting `verbose=FALSE` parameter and changing `method=glm` (`glm` implies logistic regression).

In _further reading_ there is a benchmark of different treatments for categorical variables and how each one increases or decreases the accuracy.

<br>

## Don't predictive models handle high cardinality? Part 2

Let's review how some models deal with this:

**Decision Trees**: Tend to select variables with high cardinality at the top, thus giving more importance above others, based on the information gain. In practise, it is evidence of overfitting. This model is good to see the difference between reducing or not a high cardinality variable.

**Random Forest** -at least in R implementation- handles only categorical variables with at least 52 different categories. It's highly probable that this limitation is to avoid overfitting. This point in conjunction to the nature of the algorithm -creates lots of trees- reduces the effect of a single decision tree when choosing a high cardinality variable.

**Gradient Boosting Machine** and **Logistic Regression** converts internally categorical variables into flag or dummy variables. In the example we saw about countries, it implies the -internal- creation of 70 flag variables (this is how `caret` handles formula, if we want to keep the original variable without the dummies, we have to not use a formula). 
Checking the model we created before:


```r
# Checking the first model...
fit_gbm_1$finalModel
```

```
## A gradient boosted model with bernoulli loss function.
## 100 iterations were performed.
## There were 69 predictors of which 9 had non-zero influence.
```

That is: 69 input variables are representing the countries, but the flag columns were reported as not being relevant to make the prediction. 


This opens a new chapter which is going to be covered in this book 😉: **Feature engineering** and <a href="http://livebook.datascienceheroes.com/selecting_best_variables/general_aspects.html" target="blank">selecting best variables</a>. It is a highly recommended practise to first select those variables which carry the most information, and then create the predictive model.

**Conclusion: reducing the cardinality will reduce the quantity of variables in these models.**

<br>

---

## Numerical or multi-nominal target variable 📏
The book covered only the target as a binary variable, it is planned in the future to cover numerical and multi-value target.

However, if you read up to here, you may want explore on your own having the same idea in mind. In numerical variables, for example forecasting `page visits` on a web site, there will be certain categories of the input variable that which will be more related with a high value on visits, while there are others that are more correlated with low values.

The same goes for multi-nominal output variable, there will be some categories more related to certain values. For example predicting the epidemic degree: `high`, `mid` or `low` based on the city. There will be some cities that correlated more correlated with a high epidemic level than others.

<br>

## What we've got as an "extra-🎁" from the grouping?

Knowing how categories fell into groups give us information that -in some cases- is good to report. Each category between the group will share similar behavior -in terms of representativeness and prediction power-.

If `Argentine` and `Chile` are in `group_1`, then they are the same, and this is how the model will _see_ it.

<br>

## Representativeness or sample size

This concept is on the analysis of any categorical variable, but it's a very common topic in data science and statistics: <a href="https://en.wikipedia.org/wiki/Sample_size_determination" target="blank">**sample size**</a>. How much data is it needed to see the pattern _well developed?_.

In a categorical variable: How many cases of category "`X`" do we need to trust in the correlation between "`X`" value and a target value? This is what we've analyzed.

In general terms: the more difficult the event to predict, the more cases we need...

Further in this book we'll cover this topic from other points of view linking back to this page.

<br>

## Final thoughts

* We saw two cases to reduce cardinality, the first one doesn't care about the target variable, which can be dangerous in a predictive model, while the second one does. It creates a new variable based on the affinity -and representativity- of each input category to the target variable.

* Key concept: **representativeness** of each category regarding itself, and regarding to the event being predicted.

* What was mentioned in the beginning in respects to **destroying the information in the input variable**, implies that the resultant grouping have the same rates across groups (in a binary variable input).

* _Should we always reduce the cardinality?_ It depends, two tests on a simple data are not enough to extrapolate all cases. Hopefully it will be a good kick-off for the reader to start doing her-his own optimizations when they consider relevant for the project. 


<br> 

### Further reading

* Following link contains many different accuracy results based on different treatments for categorical variable: <a href="http://www.kdnuggets.com/2015/12/beyond-one-hot-exploration-categorical-variables.html">Beyond One-Hot: an exploration of categorical variables</a>.


<br>
