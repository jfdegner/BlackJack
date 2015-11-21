#This function will return a decision function that depends only on the sum of a players cards without attention to the dealers card
#Ignoring split and double down, the decisions are based on the optimal strategy given here: https://www.blackjackinfo.com/blackjack-basic-strategy-engine/ for a game with parameters 6 decks, H17, DAS, No Surrender, Peek
#The bet will always be constant
SimpleHS <- function(input, args) {
  decision_softsum <- matrix('H',nrow=21, ncol=10)
  rownames(decision_softsum) <- 1:21
  colnames(decision_softsum) <- 2:11
  decision_softsum[18,c(1:7)] <- 'S'
  decision_softsum[19:21,] <- 'S'
  decision_sum <- matrix('H',nrow=21, ncol=10)
  rownames(decision_sum) <- 1:21
  colnames(decision_sum) <- 2:11
  decision_sum[12,c(3:5)] <- 'S'
  decision_sum[13,c(3:5)] <- 'S'
  decision_sum[14:16,c(1:5)] <- 'S'
  decision_sum[17:21,] <- 'S'
  decisionFunction <- function(PlayersCards, DealersCard, CardsDealt) {
    if(sum(PlayersCards) < 21) {
    if(sum(PlayersCards == 11) > 0) {
      decision_softsum[sum(PlayersCards),DealersCard-1]
    } else{return(decision_sum[sum(PlayersCards),DealersCard-1])}
    } else {return('S')}
  }
return(list(bet=args$bet, decisionFunction=decisionFunction))
}