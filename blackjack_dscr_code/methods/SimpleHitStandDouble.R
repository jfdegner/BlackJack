#This is the same as SimpleHS except double down option is added as an option where appropriate
#Optimum decisions are still taken from https://www.blackjackinfo.com/blackjack-basic-strategy-engine/
SimpleHSD <- function(input, args) {
  decision_softsum <- matrix('H',nrow=21, ncol=10)
  rownames(decision_softsum) <- 1:21
  colnames(decision_softsum) <- 2:11
  decision_softsum[13:14,4:5] <- 'D'
  decision_softsum[15:16,3:5] <- 'D'
  decision_softsum[17,2:5] <- 'D'
  decision_softsum[18,c(1:7)] <- 'S'
  decision_softsum[19:21,] <- 'S'
  decision_softsum[18,1:5] <- 'D'
  decision_softsum[19,5] <- 'D'
  decision_sum <- matrix('H',nrow=21, ncol=10)
  rownames(decision_sum) <- 1:21
  colnames(decision_sum) <- 2:11
  decision_sum[9,c(2:5)] <- 'D'
  decision_sum[10,c(1:8)] <- 'D'
  decision_sum[11,] <- 'D'
  decision_sum[12,c(3:5)] <- 'S'
  decision_sum[13,c(3:5)] <- 'S'
  decision_sum[14:16,c(1:5)] <- 'S'
  decision_sum[17:21,] <- 'S'
  decisionFunction <- function(PlayersCards, DealersCard, CardsDealt) {
    if(length(PlayersCards) > 2) {decision_sum[decision_sum == 'D'] <- 'H'}
    if(length(PlayersCards) > 2) {decision_softsum[decision_softsum == 'D'] <- 'H'}
    if(sum(PlayersCards) < 21) {
      if(sum(PlayersCards == 11) > 0) {
        decision_softsum[sum(PlayersCards),DealersCard-1]
      } else{return(decision_sum[sum(PlayersCards),DealersCard-1])}
    } else {return('S')}
  }
  return(list(bet=args$bet, decisionFunction=decisionFunction))
}