\name{LikeF2}
\alias{LikeF2}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  Auxiliar Marginal Likelihood Function 
}
\description{
  This function is an auxiliar function of the package that computes the marginal likelihood function of 
the transformed static parameters of the model. All transformed static parameters 
have values in the interval (-Inf, Inf). The marginal likelihood function is the 'LikeF' function.
}
\usage{
LikeF2(formula, data,na.action="na.omit",pz=NULL,
nBreaks=NULL,model="Poisson",StaPar=NULL,a0=0.01,b0=0.01,amp=FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
 \item{formula}{
    an object of class "formula" (or one that can be coerced to that class): 
    a symbolic description of the model to be fitted.  
} 
  \item{data}{
  a data frame containing the variables in the model. The variables are: 
     - the time series of interest Yt (first column of the data frame).
     the explanatory time series to be inserted in the model. 
      - Xt must be always specified as a matrix of order n by p (after Yt).
      - the explanatory time series to be inserted in the mean of volatility 
     model. Zt must be always specified as a matrix of order n by p (after Xt).
     - a censoring indicator of the event (a vector), only for the PEM. If the 
     model is the PEM, put the variable Event in the secon column of tha data frame 
  after Yt, and he explanatory time series after the variable Event.
}
  \item{na.action}{
    a function which indicates what should happen when the data contain NAs. 
    The default is set by the na.action setting 
    of options, and is na.fail if that is unset. Optional argument.
}
  \item{pz}{
    the number of the explanatory time series to be inserted in the mean of volatility 
     model. Default: NULL. Optional argument.
} 
\item{nBreaks}{
    the number of breaks used to build a vector with the interval limits, 
    only for the PEM. Optional argument.
}

\item{model}{
       the chosen model for the observations. The options are: Poisson, Normal, Gamma,
Weibull, Generalized Gamma, Laplace, GED and PEM models.
} 
\item{StaPar}{
    a numeric vector of initial values for the static parameters. Optional argument.
}
 \item{a0}{
    the shape parameter of the initial Gamma distribution. Optional argument. Default: a0=0.01.
}  \item{b0}{
      the scale parameter of the initial Gamma distribution. Optional argument. Default: b0=0.01.
} 
\item{amp}{
     the interval width is taken in account in the estimation of parameter w 
     which controls the loss of information over time, only for the PEM. For more 
     details see Santos et al. (2017). Default: FALSE. Optional argument.
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
 Typical usages are
\preformatted{LikeF2(Ytm~Trend+CosAnnual+SinAnnual+CosSemiAnnual+SinSemiAnnual,
data=data.frame(Ytm,Xtm),model="Poisson",
StaPar=c(log(-log(0.8)),-0.1,0.01,0.01,0.01,0.01),a0=0.01,b0=0.01)}
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
  \item{llik}{This function returns the value of the marginal likelihood 
  function in the logarithmic scale 
  multiplied by -1.}
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
The model options are the Poisson, Normal, Laplace, GED, Gamma, Weibull and Generalized Gamma models.
'Zt' are the explanatory time series only for the Normal, Laplace and GED volatility 
     models.
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
\code{\link{LikeF}}
\code{\link{FilteringF}}
\code{\link{SmoothingF}}
}
\examples{
library(NGSSEML)
data(gte_data)
Ytm=gte_data$V1
Xtm=NULL
Ztm=NULL
Eventm=gte_data$V2
model="PEM"
LikeF2(Ytm~1,data=data.frame(Ytm,Eventm),model="PEM",StaPar=c(log(-log(0.8))))

}
%% Add one or more standard keywords, see file 'KEYWORDS' in the
%% R documentation directory.
\keyword{Dynamic model}
\keyword{NGSSM}
\keyword{Exact likelihood}
\keyword{States and observations forecasting}
\keyword{States filtering}% __ONLY ONE__ keyword per line
