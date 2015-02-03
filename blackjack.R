#outcomes <- sapply(1:10000, function(i) game(cards, 0.8, 12))
#plot(cumsum(unlist(lapply(outcomes, function(i) i[,1]*i[,2]))))

first_deal <- function(player, dealer) {
		if(player[1] == player[2]){
			decision <- decision_pairs[rownames(decision_pairs) == paste(player[1], player[2]), dealer[1]-1]
			} else {
				if(sum(player == 11) > 0){
					decision <- decision_ace[rownames(decision_ace) == paste(min(player), max(player)), dealer[1]-1]
					} else {
					decision <- decision_sum[sum(player), dealer[1]-1]
					}
					}
return(decision)
	}

second_deal <- function(player, dealer) {
if(sum(player) > 21) {
	decision <- 'S'
	} else {
if(sum(player==11) > 0) {
	player <- c(sum(player) - 11, 11)
	decision <- decision_ace[rownames(decision_ace) == paste(min(player), max(player)), dealer[1]-1]
	} else {
	decision <- decision_sum[sum(player), dealer[1]-1]
	}
}
if(decision != 'S') decision <- 'H'
return(decision)
}

game <- function(cards, percent, count_thresh) {
	outcomes = c()
	bets = c()
	bet=1
	count=0
	deal_order <- sample(1:length(cards), length(cards), replace=F)
	i=1
	while(i < length(cards) * percent) {
		player <- cards[deal_order[i:(i+1)]]
		bet=1
		if(count > count_thresh) {(bet = bet*2); count = 0}
		if(count < -1*count_thresh) {(bet = bet/2); count = 0}
		dealer <- cards[deal_order[(i+2):(i+3)]]
		i=i+4
		###print(player)
		decision <- first_deal(player, dealer)
		#print(decision)
		if(decision == 'D') {
			bet = bet*2; 
			##print(paste('Double bet', bet)) ;
			player = c(player, cards[deal_order[i]]); 
			i=i+1
			}
		if(decision == 'Sp') {
			###print(decision)
			player1 <- c(player[1], cards[deal_order[i]])
			player2 <- c(player[2], cards[deal_order[i + 1]])
			D1 <- first_deal(player1, dealer)
			D2 <- first_deal(player2, dealer)
			bet1=bet2=bet
			###print(D1)
			###print(D2)
			###print(player1)
			###print(player2)
			i=i+2
			if(D1 == 'D') {bet1 = bet1*2; player1 = c(player1, cards[deal_order[i]]); i=i+1; 
				##print(paste('Double bet1', bet1))
				}
			while(D1 == 'H') {
				player1 = c(player1, cards[deal_order[i]]); i=i+1
				while(sum(player1) > 21 & sum(player1==11) > 0) {
					player1[player1==11][1] = 1
					}
				D1 <- second_deal(player1, dealer)
				}
				for(x in player1) {if(x < 6) count = count - 1; if(x > 9 | x==1) count = count+1}
			#if(D1 == 'S') {
			#	##print(player1)
			#	##print(dealer)
			#	}
			if(D2 == 'D') {bet2 = bet2*2; player2 = c(player2, cards[deal_order[i]]); i=i+1; 
				##print(paste('Double bet2', bet2))
				}
			while(D2 == 'H') {
				player2 = c(player2, cards[deal_order[i]]); i=i+1
					while(sum(player2) > 21 & sum(player2==11) > 0) {
					player2[player2==11][1] = 1
					}
				D2 <- second_deal(player2, dealer)
				}
				for(x in player2) {if(x < 6) count = count - 1; if(x > 9 | x==1) count = count+1}
			#if(D2 == 'S') {
			#	##print(player2)
			#	##print(dealer)
			#	}
			while(sum(dealer) < 17 | (sum(dealer) == 17 & sum(dealer == 11) > 0)) {
				dealer = c(dealer, cards[deal_order[i]])
				i=i+1
					while(sum(dealer) > 21 & sum(dealer==11) > 0) {
					dealer[dealer==11][1] = 1
					}
				}
				for(x in dealer) {if(x < 6) count = count - 1; if(x > 9 | x==1) count = count+1}
			if(sum(player1) > 21) {player1[player1 == 11] <- 1}
			#print("Split")
			##print(paste(dealer, "Dealer"))
			##print(paste(player1, "player1"))
			if(sum(player1) > 21) {
				outcomes <- c(outcomes, -1)
				##print(-1)
				bets <- c(bets, bet1)
				} else {
				if(sum(dealer) > 21) {
					outcomes <- c(outcomes, 1)
					##print(1)
					bets <- c(bets, bet1)
					} else {
						if(sum(dealer) > sum(player1)) {
							outcomes <- c(outcomes, -1)
							##print(-1)
							bets <- c(bets, bet1)
							} else {
								if(sum(dealer) == sum(player1)) {
									outcomes <- c(outcomes, 0)
									bets <- c(bets, bet1)
									##print(0)
									} else {
										outcomes <- c(outcomes, 1)
										bets <- c(bets, bet1)
										##print(1)
										}
							}
						}
				}
			if(sum(player2) > 21) {player2[player2 == 11] <- 1}
			##print(paste(player2, "player2"))
			if(sum(player2) > 21) {
				outcomes <- c(outcomes, -1)
				bets <- c(bets, bet2)
				##print(-1)
				} else {
				if(sum(dealer) > 21) {
					outcomes <- c(outcomes, 1)
					bets <- c(bets, bet2)
					##print(1)
					} else {
						if(sum(dealer) > sum(player2)) {
							outcomes <- c(outcomes, -1)
							bets <- c(bets, bet2)
							##print(-1)
							} else {
								if(sum(dealer) == sum(player2)) {
									outcomes <- c(outcomes, 0)
									bets <- c(bets, bet2)
									##print(0)
									} else {outcomes <- c(outcomes, 1)
										bets <- c(bets, bet2)
										##print(1)
										}
							}
						}
				}
			next()
			}
		while(decision == 'H') {
			player = c(player, cards[deal_order[i]])
			i=i+1
			while(sum(player) > 21 & (sum(player==11) > 0)) {
			player[player==11][1] = 1
			}
			decision <- second_deal(player, dealer)
			}
			for(x in player) {if(x < 6) count = count - 1; if(x > 9 | x==1) count = count+1}
			while(sum(dealer) < 17 | (sum(dealer) == 17 & sum(dealer == 11) > 0)) {
				dealer = c(dealer, cards[deal_order[i]])
					i=i+1
					while(sum(dealer) > 21 & sum(dealer==11) > 0) {
					dealer[dealer==11][1] = 1
					}
				}
				for(x in dealer) {if(x < 6) count = count - 1; if(x > 9 | x==1) count = count+1}
		if(sum(player) > 21) {player[player == 11] <- 1}
		#print('No split')
		##print(paste(player, "player"))
		##print(paste(dealer, "dealer"))
		if(sum(player) == 21 & length(player) == 2){
			if((sum(dealer) == 21 & length(dealer) == 2) == F){
				outcomes <- c(outcomes, 1.5)
				} else outcomes <- c(outcomes, 0)
				bets <- c(bets, bet)
			##print(1.5)
			} else{
			if(sum(player) > 21) {
				outcomes <- c(outcomes, -1)
				##print(-1)
				bets <- c(bets, bet)
				} else {
				if(sum(dealer) > 21) {
					outcomes <- c(outcomes, 1)
					##print(1)
					bets <- c(bets, bet)
					} else {
						if(sum(dealer) > sum(player)) {
							outcomes <- c(outcomes, -1)
							##print(-1)
							bets <- c(bets, bet)
							} else {
								if(sum(dealer) == sum(player)) {
									outcomes <- c(outcomes, 0)
									bets <- c(bets, bet)
									##print(0)
									} else {
										outcomes <- c(outcomes, 1)
										bets <- c(bets, bet)
										##print(1)
										}
							}
						}
				}
		}
		#if(decision == 'S') {
		#	##print(player)
		#	##print(dealer)
		#	}


		}
return(cbind(outcomes, bets))
	}


decks <- 6
cards <- c(rep(2:11, decks*4), rep(10, 3*decks*4))
outcomes_sum <- 1:21
outcomes_pairs <- sapply(2:11, function(i) c(i,i))
outcomes_ace <- rbind(2:11, 11)
dealer <- 2:11

decision_ace <- matrix(nrow=length(outcomes_ace[1,]), ncol=length(dealer))
rownames(decision_ace) <- paste(outcomes_ace[1,], outcomes_ace[2,])
colnames(decision_ace) <- dealer

decision_ace[1:7,] <- 'H'
decision_ace[1:2,4:5] <- 'D'
decision_ace[3:4,3:5] <- 'D'
decision_ace[5,2:5] <- 'D'
decision_ace[6,] <- 'H'
decision_ace[6,c(1,6,7)] <- 'S'
decision_ace[7:9,] <- 'S'
decision_ace[10,] <- 'Sp'

decision_pairs <- matrix('Sp',nrow=length(outcomes_pairs[1,]), ncol=length(dealer))
rownames(decision_pairs) <- paste(outcomes_pairs[1,], outcomes_pairs[2,])
colnames(decision_pairs) <- dealer

decision_pairs[1:2,6:10] <- 'H'
#decision_pairs[1:2,1:2] <- 'H'
decision_pairs[3,] <- 'H'
decision_pairs[4,1:8] <- 'D'
decision_pairs[4,9:10] <- 'H'
decision_pairs[5,c(1,6:10)] <- 'H'
decision_pairs[5,2:5] <- 'S'
decision_pairs[6,c(1,6:10)] <- 'H'
decision_pairs[6,1:5] <- 'S'
decision_pairs[8,c(6,7,9,10)] <- 'S'
#decision_pairs[8,] <- 'S'
decision_pairs[9,] <- 'S'

decision_sum <- matrix('H',nrow=length(outcomes_sum), ncol=length(dealer))
rownames(decision_sum) <- outcomes_sum
colnames(decision_sum) <- dealer

decision_sum[9,2:5] <- 'D'
decision_sum[10,1:8] <- 'D'
decision_sum[11,1:10] <- 'D'
decision_sum[12,c(3:5)] <- 'S'
decision_sum[13,c(3:5)] <- 'S'
decision_sum[14:16,c(1:5)] <- 'S'
decision_sum[17:21,] <- 'S'

