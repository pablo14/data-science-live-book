Introduction
===

### What is this about?

In practice, 90% of the time is spent in data preparation this book</a> does't have -yet- empirical information about how model performance increases by preparing the data.



<style type="text/css">
.table {
    width: 40%;
}
</style>

### Removing outliers 

**Model building**: Some models such as random forest and gradient boosting machines tend to deal better with outliers, but some noise will affect results anyway. 

**Communicating results:** If we need to report the variables used in the model, we'll end up removing outliers to not see an histogram with only one bar, and/or show not a biased mean. 

It's better to show a non-biased number than justifying the model _will handle_ extreme values.

**Type of outliers:** 

* Numerical: For example the ones which bias the mean.
* Categorical: Having a variable in which the dispersion of categories is quite high (high cardinallity). For example: postal code.

Jump to <a href="http://livebook.datascienceheroes.com/data_preparation/outliers_treatment.html">Outliers Treatment</a> chapter.

<br>

### Don't use information from the future

<img src="back_to_the_future.png" width='250px'> 

Common mistake when starting a new predictive model project, for example:

Imagine we need to build a predictive model to know what users are likely to adquire full subscription in a web application, and this software has a ficticious feature called it `Feature A`:



| user_id|feature_A |full_subscription |
|-------:|:---------|:-----------------|
|       1|yes       |yes               |
|       2|yes       |yes               |
|       3|yes       |yes               |
|       4|no        |no                |
|       5|yes       |yes               |
|       6|no        |no                |
|       7|no        |no                |
|       8|no        |no                |
|       9|no        |no                |
|      10|no        |no                |


We build the predictive model, we got a perfect accuracy, and an inspection throws the following: _"100% of users that have full subscription, uses Feature A"_. Some predictive algorithms report variable importance, thus `feature_A` will be at the top.

**The problem is:** `feature_A` is only availble **after the user goes for full subcription**. Therefore it cannot be used.

**The key message is**: Don't trust in perfect variables, nor perfect models. 

<br>

### Play fair with data, let it to develop their behavior

If a **numerical variable** increases as time moves, we may need to define an **observation time window** to analyze or when creating the predictive model, thus not biasing results. 

* Setting the **minimun** time: How much is it need to start seeing the behavior? 
* Setting the **maximun** time: How much time is it needed to see the end of the behavior? 

Eassiest solutions are: setting minimun since begin, and the maximun as the whole history.

<font color="#5d6d7e">

**Example:** 

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3-1.png)


User `Laura` starts knowing `feature_A` from day 3, and after 5 days she has more use on this feature than `Tim` who started using it from day 0.  

If `Laura` adcquiere `full subscription` and `Tim` doesn't, _what would the model learn?_ 

If modeling with full history -`days_since_signup = all`-, the higher the `days_since_signup` the higher the likelihood, since `Laura` has the highest number.

However, if we keep only with the user history corresponding to their first 5 days, the conclussion is the opposite. 



</font>


------
