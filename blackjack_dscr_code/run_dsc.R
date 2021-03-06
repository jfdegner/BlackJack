library(dscr)
#setwd('Blackjack/blackjack_dscr_code/')
source_dir('methods')
source("score.R")
source('datamakers/BlackJackDataMaker.R')
dsc_blackjack = new_dsc("BlackJack","BJ")
add_scenario(dsc_blackjack,name="2DeckBJ",datamaker,args=list(decks=2,p=0.75,hands=1000,deal=10),seed=1:100)
add_scenario(dsc_blackjack,name="6DeckBJ",datamaker,args=list(decks=6,p=0.75,hands=1000,deal=10),seed=1:100)
add_scenario(dsc_blackjack,name="10DeckBJ",datamaker,args=list(decks=10,p=0.75,hands=1000,deal=10),seed=1:100)
add_method(dsc_blackjack,name="SimpleSumThresh",fn = SimpleSum,args=list(Thresh=16, bet=1))
add_method(dsc_blackjack,name="SimpleHitStand",fn = SimpleHS,args=list(bet=1))
add_method(dsc_blackjack,name="SimpleHitStandDouble",fn = SimpleHSD,args=list(bet=1))
add_method(dsc_blackjack,name="SimpleHitStandDoubleSplit",fn = SimpleHSDSp,args=list(bet=1))
add_method(dsc_blackjack,name="SimpleHitStandDoubleSplit_HiLo",fn = SimpleHSDSpHL,args=list(bet=1))
add_score(dsc_blackjack, score, "basicscore")

res=run_dsc(dsc_blackjack)
summaryResults<-aggregate(WinningsPerBet ~ scenario + method, res, mean)


