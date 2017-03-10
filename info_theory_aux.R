library(infotheo)
  
a=discretize(df_exp)
mutinformation(a)
discretize


ggplot(a, aes(x=x, y=y)) + geom_line()


library(entropy)
a=discretize(df_exp)
  
exp_rel=df_exp[,c(1,2)]
lin_rel=data.frame(A=df_exp[,1], B=3*df_exp[,1])
x=entropy::discretize(exp_rel$y, numBins = 10)

hist(x, 4)


d_lin_rel=discretize(lin_rel, nbins = 100)

plot(x=d_exp_rel$x, y=d_exp_rel$y)
plot(lin_rel)

entropy(d_exp_rel)
entropy(d_lin_rel)

x1 = runif(10000)
hist(x1, xlim=c(0,1), freq=FALSE)
y1 = entropy::discretize(x1, numBins=10, r=c(0,1))
y1

x2 = rbeta(10000, 750, 250)
hist(x2, xlim=c(0,1), freq=FALSE)
# discretize into 10 categories and estimate entropy
y2 = entropy::discretize(x2, numBins=10, r=c(0,1))
y2
