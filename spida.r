#Donovan Mitchell, star guard of the Utah Jazz shot 80.5% from the free throw line last season. After working hard on his shot all
#offseason, he is now an 85% FT shooter. Donovan shoots 500 free throws after practice every day.
#Because of fatigue, his percentage goes down by 1 percentage point for after every 100 free throw attempts (ie for free throws 
#1-100, he is an 85% shooter, for 101-200, he is 84%, and so on). Write a function that takes someone's free throw percentage
#and returns the number of free throws that performs makes in a day if he takes 500 under the conditions described above.

free.throw <- function(perc = .85, n = 500 ) {
  makes <- 0
  for (i in 1:(n/100)){
    makes <- makes + sum(sample(c(1,0), 100, c(perc,1-perc), replace=TRUE))
    perc <- perc - .01
  }
  makes
}



#Joe Ingles has often been compared to a math teacher due to his looks. However, he is also a remarkable statistician. He knows that
#Donovan's freethrow percentage goes down with time, so he bets Donovan dinner that he can't make 85% of his free throws over the
#500 after practice (425 makes). Using your function, run a simulation study to calculate the probability Donovan wins the bet
#(by making >=425 free throws). Be sure to assess monte carlo error.

nreps <- 10000

#With saply

makes1 <- sapply(1:nreps, function(x) free.throw())

#With for loop

makes2 <- numeric(nreps)

for(i in 1:nreps){
  makes2[i] <- free.throw()
}

#With replicate

makes3 <- replicate(nreps, free.throw())

est <- mean(makes2 >= 425)

#ci

ci <- est + c(-1,1) * qnorm(.975) * sqrt(est*(1-est)/nreps)

results <- c(est, ci)
names(results) <- c("Estimate", "Lower", "Upper")
results

#The Utah Jazz had an incredible 2018-2019 season and made it to the NBA finals against the Boston Celtics. Celtics coach Brad
#Stevens is not only a basketball prodigy, but has a trick up his sleeve. Inspired by the plot of Celtic Pride, Stevens
#kidnaps Mitchell and replaces him with a Celtic fan look alike. After practice, the Mitchell-look-alike lines up to shoot his
#500 free throws. The Donovan impersonator has practiced his free throw shooting for this moment and is an 80% free throw shooter.
#He also exhibits the 1 percentage point decrease with each 100 free throws. The Jazz will realize that he is an imposter if
#he makes fewer than 400 of his 500 attempts. What is the probability that Jazz will will realize the impersonator
#is an imposter (also know as the power of the test)?

fake <- replicate(nreps, free.throw(perc = .8))
est2 <- mean(fake < 400)

ci2 <- est2 + c(-1,1) * qnorm(.975) * sqrt(est2*(1-est2)/nreps)
ci2


