# Methodological Aspects on Model Validation
## Out-of-Time Validation

### What's this about?

Once you've built a predictive model, how sure you are it captured general patterns, and not just the data it has seen (overfitting)?.

Will it perform well when it will be on production / running live? What is the expected error?



<br>

#### What sort of data?

If it's generated along time and -let's say- every day you have new cases like _"page visits on a website"_, or _"new patients arriving to a medical center"_, one strong validation is the **Out-Of-Time** approach.

<br>

### Out-Of-Time Validation Example

**How to?**

Imagine you are building the model on **Jan-01**, then to build the model you use all the data **before Oct-31**. Between these two dates, there are 2 months.

When predicting a **binary/two class variable** (or multi-class), it's quite straight-forward: with the model we've built -with data <= **Oct-31**- we score the data on that exact day, and then we measure how the users/patients/persons/cases evolved during those two months.


Since the output of a binary model should be a number indicating the likelihood for each case to belong to a certain class (<a href="http://livebook.datascienceheroes.com/scoring/scoring.html" target="blank">Scoring Data</a> chapter), you test what the **model "_said_" on Oct-31 against what it really happened on "Jan-01"**.

<br>

**So the validation workflow looks something like...**

<img src="model_validation_workflow.png" width="600px" alt="Model performance workflow">


_<a href="http://datascienceheroes.com/img/blog/lift_gain.png" target="Blank">Enlarge image.</a>_

<br>

#### Using Gain and Lift Analysis

<img src="gain_lift.png" width="300px" alt="Gain and lift analysis">

This analysis explained in <a href="http://livebook.datascienceheroes.com/model_performance/gain_lift.html" target="blank">the other chapter</a> of the book can be used following the out-of-time validation.

Keeping only with those cases that were `negative` on `Oct-31`, we get the `score` returned by the model on that date, and the `target` variable is the value that those cases actually had on `Jan-1`.

### How about a numerical target variable?

Now the common sense and/or business need is more present. A numerical outcome can take any value, it can increase or decrease through time, so we may have to consider these 2 scenarios to help us thinking what we consider success.


**Example scenario**: You are measuring certain app usage, the normal thing is as the days pass, the users use it more.


<br>

#### Case A: Convert the numerical target into categorical?

For an app user, she/he can be more active through time-measured in page views, so to do an out of time validation we would predict if the user visit more than the average, or more than the top 10%, or twice what he spent up to the model's creation day, etc.


Examples of this case can be:

* **Binary**: "yes/no" above average.
* **Multi-label**: "low increase"/"mid increase"/"high increase"


<br>

#### Case B: Leave it numerical (linear regression)?

Examples:

* Predicting the concentration of certain substance in blood.
* Predicting page visits.
* Time series analysis.


We also have in these cases the difference between: **"what was expected" vs "what it is"**.

This difference can take any number. This is the error, or residuals.

<img src="numerical_variable.png" width="500px">

If the model is good, this error should be **white noise** [1]. It follows a normal curve when mainly there are some logical properties:

* The error should be **around 0** -_the model must tend its error to 0_-.
* The standard deviation from this error **must be finite** -to avoid unpredictable outliers-.
* There has to be no correlation between the errors.
* **Normal distribution**: expect the majority of errors around 0, having the biggest ones in a **smaller proportion** as the error increases -likelihood of finding bigger errors decreases exponentially-.

<img src="normal_error_curve.png" width="400px" alt="Error curve following a normal distribution">

<br>


#### Final thoughts

* **Out-of-Time Validation** is an strong validation tool to simulate the running of the model on production with data that may **not need to depend on sampling**.

* The **error analysis** is a big chapter in data science. Time to go to next chapter which will try to cover key-concepts on this: <a href="http://livebook.datascienceheroes.com/model_performance/knowing_the_error.html" target="blank">Knowing the error</a>

<br>

**References:**

* [1] See **Time series analysis and regression** section in: <a href="https://en.wikipedia.org/wiki/White_noise">White noise (wikipedia)</a>
