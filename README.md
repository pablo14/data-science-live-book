# Data Science Live Book



A book to learn data science, data analysis and machine learning, suitable for all ages!

## Introduction

This book covers common aspects in predictive modeling:

+  A. **Data Preparation** / **Data Profiling**
+  B. **Selecting best variables (dataviz)**
+  C. **Assessing model performance**
+  D. **Miscellaneous**

And it is heavly based on the `funModeling` package. Please install before starting:

`install.packages("funModeling")`


As you can see, model creation is not included, while _almost_ everything else does. 

Model creation consumes around **10%** of almost any predictive modeling project; `funModeling` will try to cover remaining 90%. 

It´s not only the function itself, but the explanation of how to interpret results. This brings a deeper understanding of **what is being done**, boosting the freedom to use that knowledge in other situations andor using languages.


## `funModeling` quick start


```r
## Loading funModeling !
suppressMessages(library(funModeling))

# loading data frame
data(heart_disease)
```
