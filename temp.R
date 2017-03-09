correlatedValue = function(x, r){
  r2 = r**2
  ve = 1-r2
  SD = sqrt(ve)
  e  = rnorm(length(x), mean=0, sd=SD)
  y  = r*x + e
  return(y)
}


set.seed(5)
x = 1000*rnorm(10000)
y = correlatedValue(x=x, r=.2)

cor(x,y)
c=data.frame(x, y)
plot(x, y, type = 'l')

a=diamonds
a=sample(diamonds, size = 1000)

ggplot(diamonds, aes(x=carat, y=price)) + geom_point() + geom_smooth()
cor(diamonds$carat, diamonds$price)
library(dplyr)
res=mine(select(diamonds, carat, price)) 
res$MIC
res$MAS


library(ggplot2)
x=seq(0, 20, length.out=500)
df_exp=data.frame(x=x, px=dexp(x, rate=0.65))
ggplot(dat, aes(x=x, y=px)) + geom_line()

cor(dat)
res_mine=mine(dat);res$MIC

