#This is the same as SimpleHS except double down and split options are added as an option where appropriate
#Optimum decisions are still taken from https://www.blackjackinfo.com/blackjack-basic-strategy-engine/
SimpleHSDSpHL <- function(input, args) {
  decision_pair <- matrix('H',nrow=22, ncol=10)
  colnames(decision_pair) <- 2:11
  rownames(decision_pair) <- 1:22
  decision_pair[c(2,8,22),] <- 'Sp'
  decision_pair[c(4,6,14),1:6] <- 'Sp'
  decision_pair[c(8),4:5] <- 'Sp'  
  decision_pair[12,1:5] <- 'Sp'
  decision_pair[10,1:8] <- 'D'
  decision_pair[17:22,] <- 'S'
  decision_pair[18,c(1:5, 7:8)] <- 'Sp'  
  decision_softsum <- matrix('H',nrow=21, ncol=10)
  rownames(decision_softsum) <- 1:21
  colnames(decision_softsum) <- 2:11
  decision_softsum[13:14,4:5] <- 'D'
  decision_softsum[15:16,3:5] <- 'D'
  decision_softsum[17,2:5] <- 'D'
  decision_softsum[18,c(1:7)] <- 'S'
  decision_softsum[19:21,] <- 'S'
  decision_softsum[18,1:5] <- 'DS'
  decision_softsum[19,5] <- 'DS'
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
  decisionFunction <- function(PlayersCards, DealersCard, CardsDealt, disallowed=NULL) {
    if(is.null(disallowed) == F) {
      for(xx in disallowed) {
        if(xx =='Sp') decision_pair <- decision_sum
      }
    }
    if(length(PlayersCards) > 2) {decision_sum[decision_sum == 'D'] <- 'H'}
    if(length(PlayersCards) > 2) {decision_softsum[decision_softsum == 'D'] <- 'H'}
    if(length(PlayersCards) > 2) {decision_softsum[decision_softsum == 'DS'] <- 'S'}
    if(length(PlayersCards) > 2) {decision_pair[decision_pair == 'D'] <- 'H'}
    if(length(PlayersCards) == 2) {decision_softsum[decision_softsum == 'DS'] <- 'D'}    
    if(length(PlayersCards) == 2 && PlayersCards[1] == PlayersCards[2]) {
      return(decision_pair[sum(PlayersCards),DealersCard-1])
    } else {
      if(sum(PlayersCards) < 21) {
        if(sum(PlayersCards == 11) > 0) {
          return(decision_softsum[sum(PlayersCards),DealersCard-1])
        } else{return(decision_sum[sum(PlayersCards),DealersCard-1])}
      } else {return('S')}
    }
  }
  raw_count <- sapply(input$cards_seen, function(seen) sum(seen[2:6]) - sum(seen[10:11]))
  true_count <- raw_count/(as.numeric(input$datamakerargs$decks) - sapply(input$cards_seen, function(seen) sum(seen)/52))
  bet=rep(1, length(true_count))
  bet[true_count > 4] <- 2
  bet[true_count > 5] <- 4
  bet[true_count > 6] <- 8
  bet[true_count > 7] <- 16
  bet[true_count > 8] <- 32
  return(list(bet=bet, decisionFunction=decisionFunction))
}