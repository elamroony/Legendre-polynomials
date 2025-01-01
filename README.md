# Legendre polynomials for time points
Orthogonal polynomials are used with longitudinal data to model the shape of the curve for an longitudinal trait of interest (e.g., age or lactation curves). **The reason polynomials is being used for this is because orthogonal polynomials are less correlated to each other than would be the correlation between polynomials of the longitudinal phenotypes (e.g., age).** One simple type of orthogonal polynomials are Legendre polynomials. In order to use Legendre polynomials or other kinds of orthogonal polynomials, the time values (whole integer numbers) must be scaled to range from -1 to +1. These R and python codes do the same. Each code, first, standardize the time and then generate Legendre polynomials given a desired order.  


#### A small example was taken from Mrode 2014 for 10 days in milk:
``` DIM = 4, 38 ,72 ,106 ,140 ,174 ,208 ,242 ,276 ,310 ```

##### The output of the example:
```
         [,1]       [,2]       [,3]        [,4]        [,5]
[1,]  0.7071068 -1.2247449  1.5811388 -1.87082869  2.12132034
[2,]  0.7071068 -0.9525793  0.6441677 -0.01796406 -0.62045629
[3,]  0.7071068 -0.6804138 -0.0585607  0.75705688 -0.77565120
[4,]  0.7071068 -0.4082483 -0.5270463  0.76218947  0.02618914
[5,]  0.7071068 -0.1360828 -0.7612891  0.30538905  0.69870039
[6,]  0.7071068  0.1360828 -0.7612891 -0.30538905  0.69870039
[7,]  0.7071068  0.4082483 -0.5270463 -0.76218947  0.02618914
[8,]  0.7071068  0.6804138 -0.0585607 -0.75705688 -0.77565120
[9,]  0.7071068  0.9525793  0.6441677  0.01796406 -0.62045629
[10,] 0.7071068  1.2247449  1.5811388  1.87082869  2.12132034
```
