library(minerva)
heart_disease$chest_pain=as.numeric(heart_disease$chest_pain)
heart_disease$max_heart_rate
r=mine(select(heart_disease, max_heart_rate, chest_pain))
heart_disease$chest_pain
r$MIC

heart_disease2=heart_disease
heart_disease2$target=ifelse(heart_disease$has_heart_disease=="yes", 1, 0)

r=mine(select(heart_disease2, max_heart_rate, chest_pain, target))
plotly::plot_ly(x=heart_disease2$chest_pain, y=heart_disease2$max_heart_rate, color=heart_disease2$target)

cross_plot(heart_disease2, str_input = c("chest_pain", "max_heart_rate"), str_target = "target")

install.packages("infotheo")
library(infotheo)
data(USArrests)
dat<-discretize(USArrests)
H <- condentropy(dat[,1], dat[,2], method = "emp")
H

data(USArrests)
dat<-discretize(USArrests)

condinformation(heart_disease2$chest_pain,heart_disease2$max_heart_rate,heart_disease2$target,method="emp")
condinformation(heart_disease2$chest_pain,heart_disease2$target,method="emp")
condinformation(heart_disease2$max_heart_rate,heart_disease2$target,method="emp")


entropy(select(heart_disease2, max_heart_rate, chest_pain, target), method="emp")
entropy(select(heart_disease2, max_heart_rate, target), method="emp")
entropy(select(heart_disease2, chest_pain, target), method="emp")


