library(rpivotTable)

data=read.delim(file="scoring/example.txt", sep="\t", header = T, stringsAsFactors=F)


## score_cut_point, all obove "0.5" will be classified as "yes"
data$label_predicted=ifelse(data$score>=0.5, "yes", "no")


## Normal confusion matrix
rpivotTable(data = data, rows = "label_predicted", cols="target", aggregatorName = "Count", rendererName = "Table", width="100%", height="400px")


## This view sums 100% per column
rpivotTable(data = data, rows = "label_predicted", cols="target", aggregatorName = "Count as Fraction of Columns", rendererName = "Table", width="100%", height="400px")
  

## changing the cut point to 0.4
data$label_predicted=ifelse(data$score>=0.4, "yes", "no")


## Normal confusion matrix
rpivotTable(data = data, rows = "label_predicted", cols="target", aggregatorName = "Count", rendererName = "Table", width="100%", height="400px")

rpivotTable(data = data, rows = "label_predicted", cols="target", aggregatorName = "Count as Fraction of Columns", rendererName = "Table", width="100%", height="400px")
  