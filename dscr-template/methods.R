sourceDir("methods")
methods=list()
methods[[1]] = list(name="SimpleSumThresh",fn = SimpleSum,args=list(Thresh=16, bet=1))
methods[[2]] = list(name="SimpleHitStand",fn = SimpleHS,args=list(bet=1))

#now for each method define a list with its name, function and arguments (if no additional arguments use NULL)
# like this: 
#methods[[1]] = list(name="methodname",fn = function,args=NULL)
 
