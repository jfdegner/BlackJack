#This function will return a decision function that depends only on the sum of a players cards without attention to the dealers card
#The bet will always be constant
SimpleSum <- function(input, args) {
  decisionFunction <- function(PlayersCards, DealersCards, CardsDealt, Thresh=args$Thresh) {
    if(sum(PlayersCards) < Thresh) {
      return('H')
    } else (return('S'))
  }
return(list(bet=args$bet, decisionFunction=decisionFunction))
}