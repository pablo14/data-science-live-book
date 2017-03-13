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


#######################


births <- scan("http://robjhyndman.com/tsdldata/data/nybirths.dat")

d_births=data.frame(time=(1:length(births)),births=births)
plot(births, type = 'l')

res_mine_3=mine(d_births)

res_mine_3$MIC
res_mine_3$MAS


d_births$births_log=log(d_births$births)
plot(diff(d_births$births_log), type = 'l')

####################
souvenir <- scan("http://robjhyndman.com/tsdldata/data/fancy.dat")
d_souvenir=data.frame(time=(1:length(souvenir)),souvenir=souvenir)
res_mine_4=mine(d_souvenir)

res_mine_4$MIC[,1]
res_mine_4$MAS[,1]

####################
sinx=data.frame(x=1:200,y=sin(1:200))
res_mine_5=mine(sinx, alpha = 1)
plot(x=sinx$x, y=sinx$y, type="l")

res_mine_5$MIC
res_mine_5$MAS



