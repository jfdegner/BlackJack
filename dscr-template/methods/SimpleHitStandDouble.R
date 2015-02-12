#This function will return a decision function that depends only on the sum of a players cards without attention to the dealers card
#The bet will always be constant
SimpleHSD <- function(input, args) {
  decision_sum <- matrix('H',nrow=21, ncol=10)
  rownames(decision_sum) <- 1:21
  colnames(decision_sum) <- 2:11
  decision_sum[12,c(3:5)] <- 'S'
  decision_sum[13,c(3:5)] <- 'S'
  decision_sum[14:16,c(1:5)] <- 'S'
  decision_sum[17:21,] <- 'S'
  decisionFunction <- function(PlayersCards, DealersCard, CardsDealt) {
    if(sum(PlayersCards) < 21) { 
    return(decision_sum[sum(PlayersCards),DealersCard-1])} else {return('S')}
  }
return(list(bet=args$bet, decisionFunction=decisionFunction))
}