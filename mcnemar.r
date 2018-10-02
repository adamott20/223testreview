# Suppose that two doctors independently diagnose the same individual patients
# as either sick or not sick.  The null hypothesis is that the probability that
# Doctor 1 diagnoses a patient as sick is the same as the probability that 
# Doctor 2 diagnoses a patient as sick.  Many patients are to be evaluated 
# and the data is summarized in a 2 x 2 contingency table:

#
#    Doctor 1 \ 2   |  Sick   | Not Sick
#   ----------------+---------+----------
#            Sick   |    a    |    b
#        Not Sick   |    c    |    d
#

# where 'a' is the number of patients in which the doctors agree in diagnosing
# the patient as sick, 'b' is the number of patients in which Doctor 1 says the
# patient is sick but Doctor 2 says the patient is not sick, etc.  The McNemar
# test statistic is (b-c)^2/(b+c).  Under the null hypothesis, the test
# statistic is approximately distributed chi-square with 1 degree of freedom.

# Write a function named "mcnemar" that takes four arguments: "prob.1" and
# "prob.2" are the probabilities that Doctors 1 and 2, respectively, diagnose a
# patient as sick, "n" is the number of patients evaluated by the doctors in
# the experiment, and "nReps" is the number of Monte Carlo replications of the
# experiment.  The function should estimate the proportion of times that the
# McNemar test rejects the null hypothesis at the 0.05 level of significance
# (i.e., the probability that the test statistic equals or exceeds
# qchisq(1-0.05,df=1) = 3.84).  The function should return a numeric vector of
# length three giving the Monte Carlo estimate of the probability and the lower
# and upper bounds of a 95% confidence interval of the probability.
# 20 pts.

mcnemar <- function(prob.1,prob.2,n,nReps=10000) {
  rejects <- numeric(nReps)
  for (i in 1:nReps){
    doctor1 <- sample(c(0,1),n,prob=c(1-prob.1, prob.1), replace=TRUE)
    doctor2 <- sample(c(0,1),n,prob=c(1-prob.2, prob.2), replace = TRUE)
    b <- sum( doctor1 == 1 & doctor2 == 0)
    c <- sum( doctor1 == 0 & doctor2 == 1)
    test.stat <- (b-c)^2/(b+c)
    rejects[i] <- test.stat >= qchisq(1-0.05,df=1)
  }
  prop <- mean(rejects)
  ci <- prop + c(-1,1)*qnorm(0.975)*sqrt(prop*(1-prop)/nReps)
  c(Estimate=prop, Lower=ci[1], Upper=ci[2])
  
}#Keep

# Using your function, see if the probability of rejecting the null hypothesis
# is indeed 0.05 when both doctors diagnose a patient as sick with probability
# 0.3 and the sample size is 30.
# 3 pts.

mcnemar(0.3,0.3,30)

# Using your function, see if the probability of rejecting the null hypothesis
# is indeed 0.05 when both doctors diagnose a patient as sick with probability
# 0.3 and the sample size is 60.
# 3 pts.

mcnemar(0.3,0.3,60)

# For sample size being 60, 120, and 180, use your function to compute the
# power when Doctor 1 diagnoses a patient as sick with probability 0.3 and
# Doctor 2 diagnoses sick with probability 0.45.
# 4 pts.


