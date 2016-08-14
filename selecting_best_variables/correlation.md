Correlation table against target variable
=====

### What is this about?

It retrieves the well known `R statistic` -which measures **linear** correlation  for all numeric variables _(skipping the string ones)_.






```r
## Loading funModeling !
suppressMessages(library(funModeling))
data(heart_disease)
```


```r
correlation_table(data=heart_disease, str_target="has_heart_disease")
```

```
##                 Variable has_heart_disease
## 1      has_heart_disease              1.00
## 2 heart_disease_severity              0.83
## 3      num_vessels_flour              0.46
## 4                oldpeak              0.42
## 5                  slope              0.34
## 6                    age              0.23
## 7 resting_blood_pressure              0.15
## 8      serum_cholestoral              0.08
## 9         max_heart_rate             -0.42
```

`R statistic` goes from `1` _positive correlation_ to `-1` _negative correlation_. A value around `0` implies no correlation.
Squaring this number returns the `R squared` statistic (aka `R2`), which goes from `0` _no correlation_ to `1` _high correlation_. 

### C.1) R2 bias problem

**R statistic is highly influenced by outliers and non-linear relationships.**

Outliers can be treated with `prep_outliers` function, present in this package.

Take a look at the **Anscombe's quartet**. These 4 relationships are quite different, but all of them have the same R2: 0.816.


<img src="anscombe_quartet.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" width="400" />



Last plot, and more info about correlation can be found at: [Correlation and dependence](https://en.wikipedia.org/wiki/Correlation_and_dependence)

<br>

<br>
