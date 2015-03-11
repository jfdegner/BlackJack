#This function will return a list.  
  # The input component will be a list of length equal to the number of hands played with full information on the cards seen so far.  
  # The meta will contain the next 52 cards in the deck and all args given to datamaker.
  # A method will be expected to determine a bet and decision function from previous cards played. 
  # The score function will do most of the work and will determine the outcome of each game
# args
  # decks - number of decks
  # p - proportion of shoe dealt
  # hands - number of hands played
  # deal - cards seen per deal
datamaker<-function(args) {
  cards_seen <- vector('list', args$hands)
  cards_to_deal <- vector('list', args$hands)
  for(k in seq(1, args$hands)) {
    j <- seq(1, args$hands*args$deal, args$deal)[k]
    i <- j %% floor((args$p*args$decks*52))
    cards <- sample(c(rep(2:11, args$decks*4), rep(10, 3*args$decks*4)), 52*args$decks)
    cards_seen[[k]] <- tabulate(cards[1:i], 11)
    cards2 <- c(cards, sample(c(rep(2:11, args$decks*4), rep(10, 3*args$decks*4)), 52*args$decks))
    cards_to_deal[[k]] <- cards2[i:(i + 51)]
    }
  input=list(cards_seen=cards_seen, datamakerargs=args)
  meta=list(cards_to_deal=cards_to_deal)
  data = list(meta=meta,input=input)
  return(data)
}


