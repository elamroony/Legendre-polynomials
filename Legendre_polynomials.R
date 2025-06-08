# Legendre Polynomials:
#==========================================================================#
# Standardizing Time Points as a Covariate
# Given a time points covariate and a specified order of fit for
# Legendre polynomials, the standTime function returns a matrix 
# M containing the polynomial values of standardized time.
# The matrix 𝑀 has dimensions  txk, where t is the number of
# time points and k is the order of the Legendre polynomials. 
#--------------------------------------------------------------#
rm(list=ls(all=TRUE))
standTime <- function(t, n){
  N <- n+1
  M <- matrix(0, nrow=length(t), ncol=N)
  a <- -1 + 2*(t-t[1])/(t[length(t)] - t[1])
  M[,1] <- 1
  for (i in 2:N){
    M[,i] <- a^(i-1)
  }
  return(M)
}
#--------------------------------------------------------------#
# Get standrozed time:
# Example, as illustrated in Mrode (2014), fitting Legendre polynomials
# of order 4 to DIM (Days In Milk) results in the following matrix:
DIM <- c(4,38,72,106,140,174,208,242,276,310)
order <- 4
standTime (DIM, order)
#standTime 
#===============================================================================#
# Legendre Polynomials:
# Return coefficient matrix (lambda) of n-th order Legendre polynomials.
# Scaling method implemented by Gengler et. al. (1999) converts
# constant Legendre polynomial coefficients into 1.
legendre <- function(n, gengler=FALSE){
  N <- n+1
  L <- matrix(0,nrow=N, ncol=N)
  for(i in (1:N)){
    if(i==1){
      L[i,i] <- 1 }
    else if(i==2){
      L[i,i] <- 1 }
    else  {
      tmp <- L[i-1,]
      tmp2 <- as.numeric()
      tmp2 <- c(0,tmp[1:(N-1)])
      L[i,] <- (1/(i-2+1))*( (2*(i-2) + 1)*tmp2 -(i-2)*L[i-2,] )
    }
  }
  # Apply Gengler (1999) normalization if specified
  for (j in (1:N)){
    L[j,] <- (sqrt((2*(j-1)+1)/2))*L[j,]}
  # Gengler (1999)
  if (gengler==TRUE){
    L <- sqrt(2)*L}
  return(L)
}
#===============================================================================#
# Legendre polynomials evaluated at the different DIM (as illustrated in Mrode (2014))
# Example 1:
DIM <- c(4,38,72,106,140,174,208,242,276,310)
order <- 4
M <- standTime(DIM, order)
Lambda <- legendre(order)
phi <- M%*%t(Lambda)
phi

#           [,1]       [,2]       [,3]        [,4]        [,5]
# [1,]  0.7071068 -1.2247449  1.5811388 -1.87082869  2.12132034
# [2,]  0.7071068 -0.9525793  0.6441677 -0.01796406 -0.62045629
# [3,]  0.7071068 -0.6804138 -0.0585607  0.75705688 -0.77565120
# [4,]  0.7071068 -0.4082483 -0.5270463  0.76218947  0.02618914
# [5,]  0.7071068 -0.1360828 -0.7612891  0.30538905  0.69870039
# [6,]  0.7071068  0.1360828 -0.7612891 -0.30538905  0.69870039
# [7,]  0.7071068  0.4082483 -0.5270463 -0.76218947  0.02618914
# [8,]  0.7071068  0.6804138 -0.0585607 -0.75705688 -0.77565120
# [9,]  0.7071068  0.9525793  0.6441677  0.01796406 -0.62045629
# [10,] 0.7071068  1.2247449  1.5811388  1.87082869  2.12132034
