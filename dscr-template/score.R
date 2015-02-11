#This file should define your score function
#My score function 
score = function(data, output){
#insert calculations here; return a named list of results
tooutput <- vector('list', length(data$meta$cards_to_deal))
for(j in 1:length(data$meta$cards_to_deal)) {
player <- data$meta$cards_to_deal[[j]][1:2]
dealer <- data$meta$cards_to_deal[[j]][3:4]
decision <- output$decisionFunction(player, dealer[1], data$meta$cards_seen[[j]])
print(decision)
bet <- output$bet
i=5
if(decision == 'D') {
  bet = bet*2; 
  player = c(player, data$meta$cards_to_deal[[j]][i]); 
  i=i+1
}
if(decision == 'Sp') {
  player1 <- c(player[1], data$meta$cards_to_deal[[j]][i])
  player2 <- c(player[2], data$meta$cards_to_deal[[j]][i + 1])
  D1 <- output$decisionFunction(player1, dealer[1])
  D2 <- output$decisionFunction(player2, dealer[1])
  bet1=bet2=bet
  i=i+2
  if(D1 == 'D') {bet1 = bet1*2; player1 = c(player1, data$meta$cards_to_deal[[j]][i]); i=i+1; 
  }
  while(D1 == 'H') {
    player1 = c(player1, data$meta$cards_to_deal[[j]][i]); i=i+1
    while(sum(player1) > 21 & sum(player1==11) > 0) {
      player1[player1==11][1] = 1
    }
    D1 <- output$decisionFunction(player1, dealer[1])
  }
  if(D2 == 'D') {bet2 = bet2*2; player2 = c(player2, data$meta$cards_to_deal[[j]][i]); i=i+1; 
  }
  while(D2 == 'H') {
    player2 = c(player2, data$meta$cards_to_deal[[j]][i]); i=i+1
    while(sum(player2) > 21 & sum(player2==11) > 0) {
      player2[player2==11][1] = 1
    }
    D2 <- output$decisionFunction(player2, dealer[1])
  }
  while(sum(dealer) < 17 | (sum(dealer) == 17 & sum(dealer == 11) > 0)) {
    dealer = c(dealer, data$meta$cards_to_deal[[j]][i])
    i=i+1
    while(sum(dealer) > 21 & sum(dealer==11) > 0) {
      dealer[dealer==11][1] = 1
    }
  }
  if(sum(player1) > 21) {player1[player1 == 11] <- 1}
  if(sum(player1) > 21) {
    outcome1 <- -1
  } else {
    if(sum(dealer) > 21) {
      outcome1 <- 1
    } else {
      if(sum(dealer) > sum(player1)) {
        outcome1 <- -1
      } else {
        if(sum(dealer) == sum(player1)) {
          outcome1 <- 0
        } else {
          outcome1 <- 1        
        }
      }
    }
  }
  if(sum(player2) > 21) {player2[player2 == 11] <- 1}
  if(sum(player2) > 21) {
    outcome2 <- -1
  } else {
    if(sum(dealer) > 21) {
      outcome2 <- 1
    } else {
      if(sum(dealer) > sum(player2)) {
        outcome2 <- -1
        } else {
        if(sum(dealer) == sum(player2)) {
          outcome2<-0
        } else {outcome2 <- 1
       }
      }
    }
  }
  tooutput[[j]] <- list(outcomes=c(outcome1, outcome2), bets=c(bet1, bet2))
  next()
}
while(decision == 'H') {
  player = c(player, data$meta$cards_to_deal[[j]][i])
  i=i+1
  while(sum(player) > 21 & (sum(player==11) > 0)) {
    player[player==11][1] <- 1
  }
  decision <- output$decisionFunction(player, dealer[1])
}
while(sum(dealer) < 17 | (sum(dealer) == 17 & sum(dealer == 11) > 0)) {
  dealer = c(dealer, data$meta$cards_to_deal[[j]][i])
  i=i+1
  while(sum(dealer) > 21 & sum(dealer==11) > 0) {
    dealer[dealer==11][1] = 1
  }
}
if(sum(player) > 21) {player[player == 11] <- 1}
if(sum(player) == 21 & length(player) == 2){
  if((sum(dealer) == 21 & length(dealer) == 2) == F){
    outcome <- 1*1.5
  } else outcome <- 0
} else{
  if(sum(player) > 21) {
    outcome <- -1
  } else {
    if(sum(dealer) > 21) {
      outcome <- 1
    } else {
      if(sum(dealer) > sum(player)) {
        outcome <- -1
      } else {
        if(sum(dealer) == sum(player)) {
          outcome <- 0
          } else {
          outcome <- 1
          }
      }
    }
  }
}
tooutput[[j]] <- list(outcomes=outcome, bets=bet)
}
summary <- sum(sapply(tooutput, function(i) sum(i[[1]]*i[[2]])))
return(summary)
}