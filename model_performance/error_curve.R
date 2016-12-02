# overlay histogram, empirical density and normal density
  qplot(x, geom = 'blank',xlab = "Error (expected vs real value)", ylab = "Count", color='Errors') +   
  stat_function(fun = dnorm, aes(colour = 'Normal')) +                       
  geom_histogram(aes(y = ..density..), alpha = 0.4) +                        
  scale_colour_manual(name = 'Density', values = c('blue', 'black')) + 
  theme(legend.position = c(0.85, 0.85)) +   theme_bw()

