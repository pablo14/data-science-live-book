Predictive Modeling Foundation (binary outcome) 
=====



### The intuition behind

> Events can occur, or not... altough we don't have _tomorrow's newspaper_ :newspaper:, we can make a good guess about how is it going to be.

<img src="cover.png" width='150px'> 

The future is undoubtedly attached to *uncertainty*, and this uncertainty can be estimated.

<br>

### And there are diferents targets...

For now this book will cover the classical: `Yes`/`No` target -also known as binary or multiclass prediction.

So, this estimation is the _value of truth_ of an event to happen, therefore a probabilistic value between 0 and 1.

<br>

### Say what? :hushed:

Some examples:
- Is this client going to buy this product?
- Is this patient going to get better?
- Is certain event going to happen in the next few weeks? 

The answers to these last questions are True or False, but **the essense is to have an score**, or a number indicating the likelihood of certain event to happen.

<br>

### But we need more control...

Many machine learning resources shows the simplified version -which is good to start- getting the final class as an output. Let's say:

Simplified approach:

* Question: _Is this person going to have a heart disease?_ 
* Answer: "No"

But there is something else before the "Yes/No" answer, and this is the score:

* Question: _What is the likelihood for this person of having heart disease?_
* Answer: "25%"

<br>
So first you get the score, and then according to your needs you set the **cut point**. And this is **really** important.


### Let see an example
<img src='tbl_example_1.png' width='400px'> 

Example table showing the following
* `id`=identity
* `x1`,`x2` and `x3` input variables
* `target`=variable to predict


<img src='tbl_example_2.png' width='250px'> 

Forgetting about input variables... After the creation of the predictive model, like a random forest, we are interested in the **scores**. Even though our final goal is to deliver a `yes`/`no` predicted variable.


For example, the following 2 sentences express the same: _The likelihood of being `yes` is `0.8`_ <=> _The likelihood of being `no` is `0.2`_

May be it is understood, but the score usually refers to the less representative class: `yes`.

--- 

:raised_hand: **R Syntax** -_skip it if you don't want to see code_-

Following sentence will return the score:

`score = predict(randomForestModel, data, type = "prob")[, 2]`

Please note for other models this syntax may vary a little, but the concept **will remain the same**. Even for other languages.

Where `prob` indicates we want the probabilities (or scores). 

The `predict` function + `type="prob"` parameter returns a matrix of 15 rows and 2 columns: the 1st indicates the likelihood of being `no` while the 2nd one indicates the same for class `yes`.

Since target variable can be `no` or `yes`, the `[, 2]` return the likelihood of being -in this case- `yes` (which is the complement of the `no` likelihood).

--- 

<br>

### It's all about the cut point :straight_ruler:

<img src='tbl_example_3.png' width='250px'> 

Now the table is ordered by descending score.

This is meant to see how to extract the final class having by default the cut point in `0.5`. Tweaking the cut point will lead into a better classification.

> Accuracy metrics or the confusion matrix are always attached to a certain cut point value.

<br>

After assigning the cut point, we can see the classification results getting the famous: 

* :white_check_mark:**True Positive** (TP): It's _true_, that the classification is _positive_, or, "the model hitted correctly the positive (`yes`) class".
* :white_check_mark:**True Negative** (TN): Same as before, but with negative class (`no`).
* :x:**False Positive** (FP): It's _false_, that the classification is _positive_, or, "the model missed, it predicted `yes` but the result was `no`
* :x:**False Negative** (FN): Same as before, but with negative class, "the model predicted negative, but it was positive", or, "the model predicted `no`, but the class was `yes`"


<img src='tbl_example_4.png' width='500px'> 

<br>

### The best and the worst escenario

> The analysis of the extremes will help to find the middle point.

:thumbsup: The best escenario is when **TP** and **TN** rates are 100%. That means the model correctly predicts all the `yes` and all the `no`; _(as a result, **FP** and **FN** rates are 0%)_.

But wait :raised_hand:! If you find a perfect classification, probably it's because of overfitting!

:thumbsdown: The worst escenario -the opposite to last example- is when **FP** and **FN** rates are 100%. Not even randomness can achieve such an awful escenario. 

_Why?_ If the classes are balanced, 50/50, flipping a coin will assert around half of the results. This is common baseline to test if the model is better than randomness.

<br>
<br>

In the example provided, class distribution is 5 for `yes`, and 10 for `no`; so: 33,3% (5/15) is `yes`. 

<br>

---

### Comparing classifiers

#### Comparing classification results

:question: **Trivia**: Is a model which correcltly predict this 33.3% (TP rate=100%) a good one?

_Answer_: It depends on how many 'yes', the model predicted. 

<br>
A classifier that always predicts `yes`, will have a TP of 100%, but is absolutly useless since lots of `yes` will be actually `no`. As a matter of fact, FP rate will be high.


#### Comparing ordering label based on score 

A classifier must be trustful, and this is what **ROC** curves measures when plotting the TP vs FP rates. The higher the proportion of TP over FP, the higher the Area Under Roc Curve (AUC) is.

> The intuition behind ROC curve is to get an **sanity measure** regarding the **score**: how well it orders the label. Ideally all the positive labels must be at the top, and the negative ones at the bottom. 


<br>

<img src='tbl_example_5.png' width='500px'> 

<br>

`model 1` will have a higher AUC than `model 2`.

Wikipedia has an extensive and good article on this: https://en.wikipedia.org/wiki/Receiver_operating_characteristic

There is the comparission of 4 models, given a cutpoint of 0.5:

<img src='4_models_roc.png' width='500px'> 

Also there is a table with the calculations for building the confusion matrix (or contingency table):

<img src='wiki_confusion_matrix.png' width='600px'> 



<br>

---

### Hands on R!

We'll be analyzing 3 scenarios based on 3 cut-points.


```r
# install.packages("rpivotTable") 
# rpivotTable: it creates a pivot table dinamically, it also supports plots, more info at: https://github.com/smartinsightsfromdata/rpivotTable

library(rpivotTable)

## reading the data
data=read.delim(file="example.txt", sep="\t", header = T, stringsAsFactors=F)
```

#### **Scenario 1** Cut point @ `0.5`

Classical confusion matrix, indicating how many cases fall in the intersection of real vs predicted value:


```r
data$predicted_target=ifelse(data$score>=0.5, "yes", "no")

rpivotTable(data = data, rows = "predicted_target", cols="target", aggregatorName = "Count", rendererName = "Table", width="100%", height="400px")
```


<img src="count_1.png" width='400px'> 


Another view, now each column sums **100%**. Good to answer the following questions: 



```r
rpivotTable(data = data, rows = "predicted_target", cols="target", aggregatorName = "Count as Fraction of Columns", rendererName = "Table", width="100%", height="400px")
```

<img src="percentage_1.png" width='400px'> 

* _What is the percentage of real `yes` values captured by the model? Answer: 80%_ Also known as **Precision** (PPV)
* _What is the percentage of `yes` thrown by the model? 40%._ 

So, from the last two senteces: 

**The model throws 4 out of 10 predictions as `yes`, and from this segment -the `yes`- it hits 80%.**

<br>

Other view: The model correctly hits 3 cases for each 10 `yes` predictions _(0.4/0.8=3.2, or 3, rounding down)_.

Note: The last way of analysis can be found when building a association rules (market basket analysis), and a decision tree model.

<br>

#### **Scenario 2** Cut point @ `0.4`

Time to change the cut point to `0.4`, so the amount of `yes` will be higher:


```r
data$predicted_target=ifelse(data$score>=0.4, "yes", "no")

rpivotTable(data = data, rows = "predicted_target", cols="target", aggregatorName = "Count as Fraction of Columns", rendererName = "Table", width="100%", height="400px")
```

<img src="percentage_2.png" width='400px'> 

Now the model captures `100%` of `yes` (TP), so the total amount of `yes` produced by the model increased to `46.7%`, but at no cost since the *TN and FP remained the same* :thumbsup:. 

<br>

#### **Scenario 3** Cut point @ `0.8`

Want to decrease the FP rate? Set the cut point to a higher value, for example: `0.8`, which will cause the `yes` produced by the model decreases:


```r
data$predicted_target=ifelse(data$score>=0.8, "yes", "no")

rpivotTable(data = data, rows = "predicted_target", cols="target", aggregatorName = "Count as Fraction of Columns", rendererName = "Table", width="100%", height="400px")
```

<img src="percentage_3.png" width='400px'> 

<br>

Now the FP rate decreased to `10%` (from `20%`), and the model still captures the `80%` of TP which is the same rate as the one obtained with a cut point of `0.5` :thumbsup:.

**Decreasing the cut point to `0.8` improved the model at no cost :champagne:.**

<br>

#### Conclusions

* This chapter has focused on the essence of predicting a binary variable: To produce an score or likelihood number which **orders** the target variable.

* A predictive model maps the input with the output.

* There is not a unique and best **cut point value**, it relies on the project needs, and is constrained by the rate of `False Positive` and `False Negative` we can accept. This live book addresses model performance by <a href="http://livebook.datascienceheroes.com/model_performance/roc.html"> ROC curves</a> and <a href="http://livebook.datascienceheroes.com/model_performance/gain_lift.html"> lift &amp; gain charts</a>



