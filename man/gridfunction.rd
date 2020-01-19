\name{gridfunction}
\alias{gridfunction}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
A grid of points for obtaining
the static parameters of the non-Gaussian state space models with
exact marginal likelihood 
}
\description{
  The function builds a grid of the points for 
the static parameters of the model.
}
\usage{
gridfunction(npoints,linf,lsup)

}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{npoints}{
     the number of points/parts that the specified interval of the static parameters is partitioned.
}
  \item{linf}{
     the lower limit of the static parameters in the grid.
}
  \item{lsup}{
     the upper limit of the static parameters in the grid.
}
 
}
\details{
%%  ~~ If necessary, more details than the description above ~~
Typical usages are
\preformatted{gridfunction(npoints,linf,lsup)}

}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
  \item{[[1]]}{This function returns the grid of points for the static parameters of the model.}
}
\references{
%% ~put references to the literature/web site here ~
Gamerman, D., Santos, T. R., and Franco, G. C. (2013). A Non-Gaussian Family of State-Space 
Models with Exact Marginal Likelihood. Journal of Time Series Analysis, 34(6), 625-645.

Santos T. R., Gamerman, D., Franco, G. C. (2017). Reliability Analysis via Non-Gaussian 
State-Space Models. IEEE Transactions on Reliability, 66, 309-318.

}
\author{
T. R. Santos
}
\note{
%%  ~~further notes~~
The function is used to perform Bayesian inference for the static parameters. It 
computes the exact posterior distribution and draws a sample of the 
marginal posterior distribution of the static parameters using multinomial sampling scheme. 
It requires the R package 'fields'.
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
\code{\link{ngssm.bayes}}

}
\examples{
library(NGSSEML)
n=5   # number of points
linf=c(0,3,-1)   # lower limit
lsup=c(1,6,-2)     # upper limit
out=gridfunction(n,linf,lsup) # Calling the function

}

%% Add one or more standard keywords, see file 'KEYWORDS' in the
%% R documentation directory.
\keyword{State space model}
\keyword{NGSSM}
\keyword{Exact likelihood}
\keyword{Classical estimation}
\keyword{States and observations forecasting}
\keyword{States filtering}% __ONLY ONE__ keyword per line
\keyword{States Smoothing}% __ONLY ONE__ keyword per line
