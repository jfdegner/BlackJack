sourceDir("datamakers")
scenarios=list()
scenarios[[1]]=list(name="6DeckBJ",fn=datamaker,args=list(decks=6,p=0.75,hands=100,deal=10),seed=1:1000)
scenarios[[2]]=list(name="2DeckBJ",fn=datamaker,args=list(decks=2,p=0.75,hands=100,deal=10),seed=1:1000)
scenarios[[3]]=list(name="10DeckBJ",fn=datamaker,args=list(decks=10,p=0.75,hands=100,deal=10),seed=1:1000)
#Now, for each scenario create an element of scenarios of the following form
#scenarios[[1]]=list(name="",fn=,args,seed=1:100)
