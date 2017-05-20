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


if(F)
{
  create_files('readme', 'readme') # PUBLISHED
  
  create_files('correlation', 'exploratory_data_analysis') # PUBLISHED
  create_files('profiling', 'exploratory_data_analysis') # PUBLISHED

  create_files('high_cardinality_predictive_modeling', 'data_preparation') # PUBLISHED
  create_files('high_cardinality_descriptive_stats', 'data_preparation') # PUBLISHED
  create_files('outliers_treatment', 'data_preparation') # PUBLISHED
  create_files('considerations_involving_time', 'data_preparation')
  create_files('feature_engineering', 'data_preparation')
  create_files('treating_missing_data', 'data_preparation')
  create_files('data_types', 'data_preparation')
  create_files('modifying_variables', 'data_preparation')
  
  create_files('cross_plot', 'selecting_best_variables') # PUBLISHED
  create_files('plotar_boxplot', 'selecting_best_variables') # PUBLISHED
  create_files('plotar_histdens', 'selecting_best_variables') # PUBLISHED
  create_files('introduction', 'selecting_best_variables') # PUBLISHED
  create_files('general_aspects', 'selecting_best_variables')
  
  create_files('scoring', 'scoring') # PUBLISHED
  
  create_files('introduction', 'model_performance') # PUBLISHED
  create_files('gain_lift', 'model_performance') # PUBLISHED
  create_files('out_of_time_validation', 'model_performance') # PUBLISHED
  create_files('knowing_the_error', 'model_performance') # PUBLISHED
}


