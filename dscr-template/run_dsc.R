library(dscr)
setwd('~/Desktop/BlackJack/BlackJack/dscr-template/')
source("scenarios.R")
source("methods.R")
source("score.R")
res=run_dsc(scenarios,methods,score)
summaryResults<-aggregate(results ~ scenario + method, res, mean)


