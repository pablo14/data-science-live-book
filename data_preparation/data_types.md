

Handling Data Types
===

### What is this about?


<br>

### The universe of data types

There are two main data types, **numerical** or **categorical**. Other names for categorical are: string and nominal.

A sub set of categorical is the ordinal, or as it is named in R, an ordered factor. At least in R, this type is only relevant when plotting categories in a certain order.

<br>

#### Binary variable, numerical or categorical?

This book suggests to use binary variables as numeric, when `0` is `FALSE` and `1` is `TRUE`. This way makes easier to profile data. 

<br>

### Data types per algorithm

Some algorithms work:

* Only with categorical data
* Only with numerical data
* With both types

Add to last points, that not every predictive model handle *missing value*. 

The **Data Science Live Book** tries to cover all of these situations, and more 😀.

<br>

### Converting categorical variables into numerical 

In R using `caret` package the task this straitforward, converting every categorical variable into a flag one, also known as _dummy_ variable. After the conversion original categorical

If the original categorical variable has 2 possible values, it will result in 30 new columns holding the value `0` or `1`, when `1` represents the presence of that category in the row.

If we use package `caret` from R, this conversion only takes two lines of code:


```r
library(caret) # contains dummyVars function
library(dplyr) # data munging library
library(funModeling) # df_status function
  
## Checking categorical variables
status=df_status(heart_disease, print_results = F)
filter(status,  type %in% c("factor", "character")) %>% select(variable)
```

```
##              variable
## 1              gender
## 2          chest_pain
## 3 fasting_blood_sugar
## 4     resting_electro
## 5                thal
## 6        exter_angina
## 7   has_heart_disease
```

```r
## It converts all categorical variables (factor and character) into numerical
## skipping the original so the data is ready to use
dmy = dummyVars(" ~ .", data = heart_disease)
heart_disease_2 = data.frame(predict(dmy, newdata = heart_disease))

# Checking the new numerical data set:
colnames(heart_disease_2)
```

```
##  [1] "age"                    "gender.female"         
##  [3] "gender.male"            "chest_pain.1"          
##  [5] "chest_pain.2"           "chest_pain.3"          
##  [7] "chest_pain.4"           "resting_blood_pressure"
##  [9] "serum_cholestoral"      "fasting_blood_sugar.0" 
## [11] "fasting_blood_sugar.1"  "resting_electro.0"     
## [13] "resting_electro.1"      "resting_electro.2"     
## [15] "max_heart_rate"         "exer_angina"           
## [17] "oldpeak"                "slope"                 
## [19] "num_vessels_flour"      "thal.3"                
## [21] "thal.6"                 "thal.7"                
## [23] "heart_disease_severity" "exter_angina.0"        
## [25] "exter_angina.1"         "has_heart_disease.no"  
## [27] "has_heart_disease.yes"
```

Original data `heart_disease` has been converted into `heart_disease_2` with no categorical variables. There are only numerical and dummy. Note every new variable has a _dot_ following by the _value_.

If we check the before and after for the 7th patient (row) in variable `chest_pain` which can take the values `1`, `2`, `3` or `4`:


```r
# before
as.numeric(heart_disease[7, "chest_pain"])
```

```
## [1] 4
```

```r
# after
heart_disease_2[7, c("chest_pain.1", "chest_pain.2", "chest_pain.3", "chest_pain.4")]
```

```
##   chest_pain.1 chest_pain.2 chest_pain.3 chest_pain.4
## 7            0            0            0            1
```

Having keept and transformed only numeric variables, excluding the nominal ones, the data `heart_disease_2` is ready to be used.

<br>


### Is it categorical or numerical? Think about it

Consider `chest_pain` variable, which can take values `1`, `2`, `3` or `4`. Is this variable categorical or numerical?

If the values are ordered, it can be considered as numerical since it exhibits an **order**, i.e. 1 is less than 2, 2 is less than 3 and 3 is less than 4. 

If we create a decision tree model, we may find rules like: "`If chest_pain > 2.5 then...`". Does it makes sense? The algorithm splits the variable by a value that is not present, `2.5`, but the interpretation is "if `chest_pain is equal or higher than 3`.

<br>

#### Thinking as an algorithm

Consider two numerical input variables, and a target binary variable. The algorithm will _see_ both input variable as an scatter plot, considering that are infintie values between each number. 

<img src="svm.png" alt="Support Vector Machine" widt="300px">
_Image credit: ZackWeinberg._

For example, a **Supported Vector Machine** (SVM) will create _several_ vectors in order to separate the target variable class. It will **find regions** based on these vectors. How would it be possible to find these regions based on categorical variables? It isn't possible, that's why SVM only supports numerical variables. Same case to neural networks.

However if the model is a tree based, like decision trees, random forest or gradient boosting machine, they handle both types since the search space can be regions (sames as SVM), and categories. Like the rule "`if postal_code is AX441AG then...`".


Going back to the heart disease example, the variable `chest_pain` has an order. and we should take advantage of it If we convert this variable into one categorical, *we are losing information*, this is a really important point in handling data types.



<br>

#### Is the solution to treat all as categorical?

No... A numerical variale carries more information than a nominal one because of its order. In categorical variables, the values cannot be compared. Let's say it's not possible to do a rule like `If postal code is higher than "AX2004-P"`.

Values of nominal variable can be compared, if we have a another variale to use as a reference (usually the an outcome ot predict). 

Also there is the **high cardinallity** issue in categorical variable, for example a `postal code` variable containinig hundreds of different values. This book addressed it in both chapters: handling high categorical variable for <a href="http://livebook.datascienceheroes.com/data_preparation/high_cardinality_descriptive_stats.html" target="blank">descriptive statistics</a> and when we do <a href="http://livebook.datascienceheroes.com/data_preparation/high_cardinality_predictive_modeling.html" target="blank">predictive modelling</a>.

Anyway, you can do the _free test_ of converting all variables into categorical and see what happen. Comparing the results vs. keeping the numerical. Remember to use some good error measure for the test like Kappa or ROC statistic, and to cross-validate the results.

<br>

#### Be aware when converting categorical into numerical

Imagine we have a categorical variable, and we need to convert into one numerical. Same case as before, but trying a different **transformation**: assiging a different number to each category.

We have to be careful when doing such transformation because we are **introducing order** to the variable. 

Considering the following data example, having 4-rows. The first two-variables are `visits` and `postal_code` this play either as two input variables or `visits` as input and `postal_code` as output.

Following code will show the `visits` depending on `postal_code` transformed according to two criteria:

* `transformation_1`: Assign a sequence number based on the given order.
* `transformation_2`: Assign a number based on the amount of `visits`.


```r
# creating data -toy- sample 
df_pc=data.frame(visits=c(10, 59, 27, 33), postal_code=c("AA1", "BA5", "CG3", "HJ1"), transformation_1=c(1,2,3,4), transformation_2=c(1, 4, 2, 3 ))

# printing table
knitr::kable(df_pc)
```



| visits|postal_code | transformation_1| transformation_2|
|------:|:-----------|----------------:|----------------:|
|     10|AA1         |                1|                1|
|     59|BA5         |                2|                4|
|     27|CG3         |                3|                2|
|     33|HJ1         |                4|                3|

```r
library(gridExtra)

# transformation 1
plot_1=ggplot(df_pc, aes(x=transformation_1, y=visits, label=postal_code)) +  geom_point(aes(color=postal_code), size=4)+ geom_smooth(method=loess, group=1, se=FALSE, color="lightblue", linetype="dashed") + theme_minimal()  + theme(legend.position="none") + geom_label(aes(fill = factor(postal_code)), colour = "white", fontface = "bold")
  

# transformation 2
plot_2=ggplot(df_pc, aes(x=transformation_2, y=visits, label=postal_code)) +  geom_point(aes(color=postal_code), size=4)+ geom_smooth(method=lm, group=1, se=FALSE, color="lightblue", linetype="dashed") + theme_minimal()  + theme(legend.position="none") + geom_label(aes(fill = factor(postal_code)), colour = "white", fontface = "bold")
  
# arranging plots side by side
grid.arrange(plot_1, plot_2, ncol=2)
```

<img src="figure/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" width="400px" />

For sure, no body does a predictive model with only 4 rows, but the intention of this example is to show how the relationship changes from non-linear (`transformation_1`) to another linear (`transformation_2`).  Making the things easier to the predictive model, as well as explaining the relationship.

This effect is the same when we handle millions of rows and the number of variables scale to hundreds. Learning from small data is a good approach in these cases.


<br>

### Custom buckets

It's common to create custom binning or custom buckets in the **Feature Engineering** stage. These buckets can be created based on the ingformation provided by `cross_plot`.


```r
# Lock5Data contains many data sets to practice. One of them: HollywoodMovies2011
library(Lock5Data)
data("HollywoodMovies2011")

HollywoodMovies2011$TheatersOpenWeek_2=cut(HollywoodMovies2011$TheatersOpenWeek, breaks = c(0, 2995, 3400, 4375), dig.lab = 9)

freq(HollywoodMovies2011, "TheatersOpenWeek_2")
summary(HollywoodMovies2011$TheatersOpenWeek_2)
```
