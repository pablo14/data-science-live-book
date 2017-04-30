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

###########################################################################
###########################################################################

create_files('considerations_involving_time', 'data_preparation')

if(F)
{
  create_files('readme', 'readme')
  
  create_files('correlation', 'exploratory_data_analysis')
  create_files('profiling', 'exploratory_data_analysis')

  create_files('feature_engineering', 'data_preparation')
  create_files('high_cardinality_predictive_modeling', 'data_preparation')
  create_files('high_cardinality_descriptive_stats', 'data_preparation')
  create_files('treating_empty_values', 'data_preparation')

  
  create_files('cross_plot', 'selecting_best_variables')
  create_files('plotar_boxplot', 'selecting_best_variables')
  create_files('plotar_histdens', 'selecting_best_variables')
  
  create_files('scoring', 'scoring')
  
  create_files('introduction', 'model_performance')
  create_files('gain_lift', 'model_performance')
  create_files('out_of_time_validation', 'model_performance')
  create_files('knowing_the_error', 'model_performance')
}


