library(knitr)

## README
knit("readme/readme.Rmd", "README.md")

## SELECTING BEST VARIABLES
knit("selecting_best_variables/introduction.Rmd", "selecting_best_variables/introduction.md")
knit("selecting_best_variables/cross_plot.Rmd", "selecting_best_variables/cross_plot.md")
knit("selecting_best_variables/plotar_histdens.Rmd", "selecting_best_variables/plotar_histdens.md")
knit("selecting_best_variables/plotar_boxplot.Rmd", "selecting_best_variables/plotar_boxplot.md")
knit("selecting_best_variables/correlation.Rmd", "selecting_best_variables/correlation.md")

## DATA PREPARATION/PROFILING
knit("data_preparation/outliers_treatment.Rmd", "data_preparation/outliers_treatment.md")
knit("data_preparation/profiling.Rmd", "data_preparation/profiling.md")

## ASSESING MODEL PERFORMANCE 
knit("model_performance/model_performance.Rmd", "model_performance/model_performance.md")

## MISCELLANEOUS
knit("miscellaneous/miscellaneous.Rmd", "miscellaneous/miscellaneous.md")

#################################
###         HTMLs             ###         
#################################
## README
knit2html("readme/readme.Rmd", "readme/README.md")

## SELECTING BEST VARIABLES
knit2html("selecting_best_variables/introduction.Rmd", "selecting_best_variables/introduction.html")
knit2html("selecting_best_variables/cross_plot.Rmd", "selecting_best_variables/cross_plot.html")
knit2html("selecting_best_variables/plotar_histdens.Rmd", "selecting_best_variables/plotar_histdens.html")
knit2html("selecting_best_variables/plotar_boxplot.Rmd", "selecting_best_variables/plotar_boxplot.html")
knit2html("selecting_best_variables/correlation.Rmd", "selecting_best_variables/correlation.html")

## DATA PREPARATION/PROFILING
knit2html("data_preparation/outliers_treatment.Rmd", "data_preparation/outliers_treatment.html")
knit2html("data_preparation/profiling.Rmd", "data_preparation/profiling.html")

## ASSESING MODEL PERFORMANCE 
knit2html("model_performance/model_performance.Rmd", "model_performance/model_performance.html")

## MISCELLANEOUS
knit2html("miscellaneous/miscellaneous.Rmd", output = "miscellaneous/miscellaneous.html")
