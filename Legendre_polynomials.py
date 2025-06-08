import pandas as pd
import os
import numpy as np
# Legendre Polynomials:
#==========================================================================#
# Standardizing Time Points as a Covariate
# Given a time points covariate and a specified order of fit for
# Legendre polynomials, the standTime function returns a matrix 
# M containing the polynomial values of standardized time.
# The matrix 𝑀 has dimensions  txk, where t is the number of
# time points and k is the order of the Legendre polynomials. 
#--------------------------------------------------------------#
def standTime(t,n):
  t = np.array(t)
  N = n+1
  M = pd.DataFrame.from_records([[1]*1]*len(t)) 
  a = -1 + 2*(t-t[0])/(t[len(t)-1] - t[0])
  for i in range(1,N):
    M.insert(i,f'{i}', pd.Series(a**(i)))
  return(M)

#----------------------------------------------#
# Get standrozed time:
# Example, as illustrated in Mrode (2014), fitting Legendre polynomials
# of order 4 to DIM (Days In Milk) results in the following matrix:
DIM = [4,38,72,106,140,174,208,242,276,310]
order = 4
standTime(DIM, order)
#===============================================================================#
# Legendre Polynomials:
# Return coefficient matrix (lambda) of n-th order Legendre polynomials.
# Scaling method implemented by Gengler et. al. (1999) converts
# constant Legendre polynomial coefficients into 1.

def legendre(n, gengler=False):
    N = n + 1
    L = np.zeros((N, N))  # Create an N x N matrix of zeros
    for i in range(1, N + 1):
        if i == 1:
            L[i - 1, i - 1] = 1
        elif i == 2:
            L[i - 1, i - 1] = 1
        else:
            tmp = L[i - 2, :]
            tmp2 = np.roll(tmp, 1)  
            tmp2[0] = 0  
            L[i-1,:] = (1/(i-1))*((2*(i-2)+1)*tmp2-(i-2)*L[i-3,:])
    for j in range(1, N + 1):
        L[j - 1, :] *= np.sqrt((2 * (j - 1) + 1) / 2)
    # Apply Gengler (1999) normalization if specified
    if gengler:
        L *= np.sqrt(2)
    return L
  
DIM = [4,38,72,106,140,174,208,242,276,310]
order = 4
M = standTime(DIM, order)

Lambda = legendre(order)
phi  = M @ Lambda.T
phi

#        0         1         2         3         4
# 0  0.707107 -1.224745  1.581139 -1.870829  2.121320
# 1  0.707107 -0.952579  0.644168 -0.017964 -0.620456
# 2  0.707107 -0.680414 -0.058561  0.757057 -0.775651
# 3  0.707107 -0.408248 -0.527046  0.762189  0.026189
# 4  0.707107 -0.136083 -0.761289  0.305389  0.698700
# 5  0.707107  0.136083 -0.761289 -0.305389  0.698700
# 6  0.707107  0.408248 -0.527046 -0.762189  0.026189
# 7  0.707107  0.680414 -0.058561 -0.757057 -0.775651
# 8  0.707107  0.952579  0.644168  0.017964 -0.620456
# 9  0.707107  1.224745  1.581139  1.870829  2.121320
