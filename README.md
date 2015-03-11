# BlackJack

This is a set of R functions for simulating blackjack play and comparing player-strategies.  The current version is working but is relatively ridged with respect to simulating different blackjack variants.  If people find this interesting or useful, I will go back to it and make it more flexible.

I have implemented five blackjack strategies so far - three are strawmen for comparison, one is an optimal strategy without card counting and one uses the Hi-Lo system of card counting where betting is doubled for each integer increase in true count above 3.  More detail on strategy is given below with the resulting estimates of house edge given 1,000,000 simulated blackjack hands.

#SimpleSumThresh
This method simply decides to hit or stand based on the sum of the players cards. Using this method of hitting on anything less than 16 gives these results for 2, 6, and 10 deck blackjack:

scenario	method	WinningsPerBet
10DeckBJ	SimpleSumThresh	-0.055037000
2DeckBJ	SimpleSumThresh	-0.055163500
6DeckBJ	SimpleSumThresh	-0.053512000

#SimpleHitStand
This method limits decisions to Hit or Stand but takes into account the dealer's visible card.   Often video-based blackjack games limit the player to these options.
scenario	method	WinningsPerBet
10DeckBJ	SimpleHitStand	-0.025122000
2DeckBJ	SimpleHitStand	-0.022971500
6DeckBJ	SimpleHitStand	-0.023402000

#SimpleHitStandDouble
This method is like the previous, but allows the player the option to double-down when it is advantageous.
10DeckBJ	SimpleHitStandDouble	-0.012883806
2DeckBJ	SimpleHitStandDouble	-0.009856444
6DeckBJ	SimpleHitStandDouble	-0.011111093

#SimpleHitStandDoubleSplit
This method allows all normal blackjack options but does not consider cards dealt in previous hands (i.e., no card counting system).  Decisions are hard coded and were taken from https://www.blackjackinfo.com/blackjack-basic-strategy-engine/.  Overall house edge is a little bit higher than what this website reports (I get a house edge around 1% wheras they report around 0.7%).  This could be because right now I hard code that only one split is allowed.   It is also possible there is a bug somewhere.  In the simulations below, you do see that the house has a greater advantage with more decks even in the absense of card counting. 
10DeckBJ	SimpleHitStandDoubleSplit	-0.012336347
2DeckBJ	SimpleHitStandDoubleSplit	-0.009381720
6DeckBJ	SimpleHitStandDoubleSplit	-0.010409513

#SimpleHitStandDoubleSplit_HiLo
This method always makes the same card-playing decisions as the previous method, but adjusts the players bet based on the running count of high and low cards played.   In the high-low system, a player remembers a single number.  When dealing from a shuffled deck begins, the count is set to 0.   For every card with value 2-6, the count is increased by one.  For every 10-valued card or ace, the count is decreased by one.  This raw count is adjusted by deviding by the number of decks left to play to get a 'true count'.  In this implimentation, the players bet is doubled for every integer increase of the 'true count' above 3 (e.g., bet is 2X for true count of 4, 4X for tc of 5, 8X for tc of 6).

The results below suggest that this card counting strategy can give a player a substantial advantage in 2-Deck blackjack, can decrease the expected loss in 6-deck blackjack, and has almost no effect in 10-deck blackjack

10DeckBJ	SimpleHitStandDoubleSplit_HiLo	-0.012089300
2DeckBJ	SimpleHitStandDoubleSplit_HiLo	 0.009594838
6DeckBJ	SimpleHitStandDoubleSplit_HiLo	-0.004958975
