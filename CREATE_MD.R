library(knitr)



create_files <- function(name, folder)
{
  if(name!='readme')
  {
	  knit(sprintf("%s/%s.Rmd", folder, name), sprintf("%s/%s.md", folder, name))
	  knit2html(sprintf("%s/%s.Rmd", folder, name), sprintf("%s/%s.html", folder, name));file.remove(sprintf("%s.md", name))
  } else {
    knit(sprintf("%s/%s.Rmd", folder, name), sprintf("%s.md", folder, name))
    knit2html(sprintf("%s/%s.Rmd", folder, name), sprintf("%s/%s.html", folder, name))
  }
}

setwd("~/repos/data-science-live-book")
create_files('correlation', 'exploratory_data_analysis')
create_files('profiling', 'exploratory_data_analysis')
create_files('high_cardinality_predictive_modeling', 'data_preparation')
create_files('readme', 'readme')


create_files('high_cardinality_descriptive_stats', 'data_preparation')

create_files('gain_lift', 'model_performance')
create_files('introduction', 'model_performance')
create_files('out_of_time_validation', 'model_performance')
create_files('knowing_the_error', 'model_performance')


create_files('introduction', 'data_preparation')

#create_files('roc', 'model_performance')

create_files('scoring', 'scoring')


knit("readme/readme.Rmd", "README.md")

#########


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
#knit("miscellaneous/miscellaneous.Rmd", "miscellaneous/miscellaneous.md")

#################################
###         HTMLs             ###         
#################################
## README
knit2html("readme/readme.Rmd", "README.md")

## SELECTING BEST VARIABLES
knit2html("selecting_best_variables/introduction.Rmd", "selecting_best_variables/introduction.html");file.remove("introduction.md")
knit2html("selecting_best_variables/cross_plot.Rmd", "selecting_best_variables/cross_plot.html");file.remove("cross_plot.md")
knit2html("selecting_best_variables/plotar_histdens.Rmd", "selecting_best_variables/plotar_histdens.html");file.remove("plotar_histdens.md")
knit2html("selecting_best_variables/plotar_boxplot.Rmd", "selecting_best_variables/plotar_boxplot.html");file.remove("plotar_boxplot.md")
knit2html("selecting_best_variables/correlation.Rmd", "selecting_best_variables/correlation.html");file.remove("correlation.md")

## DATA PREPARATION/PROFILING
knit2html("data_preparation/outliers_treatment.Rmd", "data_preparation/outliers_treatment.html");file.remove("outliers_treatment.md")
knit2html("data_preparation/profiling.Rmd", "data_preparation/profiling.html");file.remove("profiling.md")

## ASSESING MODEL PERFORMANCE 
knit2html("model_performance/model_performance.Rmd", "model_performance/model_performance.html");file.remove("model_performance.md")

## MISCELLANEOUS
#knit2html("miscellaneous/miscellaneous.Rmd", output = "miscellaneous/miscellaneous.html");file.remove("miscellaneous.md")

## SCORING
knit2html("scoring/scoring.Rmd", output = "scoring/scoring.html");file.remove("scoring.md")
