\name{Prediction}
\alias{Prediction}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  The h-step-ahead forecast for the observations 
}
\description{
  The function Prediction implements the h-step-ahead forecast 
  for the observations of SR and Poisson models. 
}
\usage{
Prediction(formula,data,na.action="na.omit",pz=NULL,nBreaks=NULL,
model="Poisson",StaPar=NULL,a0=0.01,b0=0.01,distl="PRED",
ci=0.95,samples=500,hh=1,Xtprev=NULL,method="MLE")
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
  The value 1 indicates failure.
     
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
       the chosen model for the observations. The options are: Poisson, SRGamma,
and SRWeibull models.
} 
 \item{StaPar}{
    a numeric vector of initial values for the static parameters. Optional argument.
}
  \item{a0}{
     the shape parameter of the initial Gamma distribution. Optional argument. Default: a0=0.01.
}  
\item{b0}{
     the scale parameter of the initial Gamma distribution. Optional argument. Default: b0=0.01.
}  
\item{distl}{
     the latent states distribution to be returned. Optional argument.
}
\item{ci}{
     the confidence level of the confidence interval for the states. Optional argument.
     Default: ci=0.95.
} 
\item{samples}{
    the number of samples drawn from the predictive distributions for the observations, 
given a point of the static parameters (StaPar). Default: samples=500.
}
\item{hh}{
     the forecast horizon. Optional argument. Default: hh=1.
} 
\item{Xtprev}{
     the future values of covariates, if there are covariates in the model. Optional argument.
} 
\item{method}{
     the estimation method used, MLE or Bayesian.
} 
 
}
\details{
 Typical usages are
\preformatted{Prediction(Ytm~Trend+CosAnnual+SinAnnual+CosSemiAnnual+SinSemiAnnual,
data=data1,model=model,pz=NULL,StaPar=estopt,a0=a0,b0=b0,ci=ci,distl="PRED",
samples=500,hh=hh,Xtprev=Xtprev,method="MLE")}
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
  \item{Mean}{'Mean' is the mean of the one-step-ahead forecast distribution for the observations.}
  \item{Median}{'Median' is the median of the one-step-ahead forecast distribution for the observations.}
  \item{Perc1}{'Perc1' the the percentile of ((1-ci)/2) order of the one-step-ahead forecast distribution for the observations.}
  \item{Perc2}{'Perc2' is the percentile of (1-(1-ci)/2) order of the one-step-ahead forecast distribution for the observations.}

%% ...
}
\references{
%% ~put references to the literature/web site here ~
Gamerman, D., Santos, T. R., and Franco, G. C. (2013). A Non-Gaussian Family of State-Space 
Models with Exact Marginal Likelihood. Journal of Time Series Analysis, 34(6), 625-645.

Santos T. R., Gamerman, D., Franco, G. C. (2017). Reliability Analysis via Non-Gaussian 
State-Space Models. IEEE Transactions on Reliability, 66, 309-318.
}
\author{
  Thiago Rezende dos Santos
 
}
\note{
%%  ~~further notes~~
The model options are Poisson, SRWeibull and SRGamma models, because the remaining 
are the volatility and piecewise exponential/PH models.
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
\code{\link{LikeF}}
\code{\link{SmoothingF}}

}
\examples{
%%
################################################################################
##
##  SR Weibull MODEL: the SYS1 data
##
################################################################################
library(NGSSEML) 
#Classical:
data(sys1_data)
Ytm=sys1_data[,1]+0.00001
Xtm=as.matrix(sys1_data[,2])
hh=3
Xtprev=as.matrix(135+1:hh)
model="SRWeibull" 
#model="SRGamma"    
LabelParTheta=c("w","nu","Beta1")
StaPar=c(0.9,0.7,0.01)
#Fit:
fit=ngssm.mle(Ytm~Xtm,data=data.frame(Ytm,Xtm),
model=model,pz=NULL,StaPar=StaPar,a0=0.01,b0=0.01,ci=0.95)
estopt=c(0.99,0.75262104,0.02342691)
estopt=fit[[1]][1:3]
predpar=Prediction(Ytm~Xtm,data=data.frame(Ytm,Xtm),
model=model,StaPar=estopt,pz=NULL,a0=0.01,
b0=0.01,distl="FILTER",ci=0.95,samples=500,hh=hh,
Xtprev=Xtprev,method="MLE")

#library(NGSSEML)
#Bayesian:
#### Inputs: 
data(sys1_data)
Yt=sys1_data[,1]+0.00001
Xt=as.matrix(sys1_data[,2])  # Xt as matrix always!
hh=3
Xtprev=as.matrix(135+1:hh)
Zt="NULL"
model="SRWeibull"  
#model="SRGamma"  
LabelParTheta=c("w","nu","Beta1")
pointss=4    ### points
nsamplex=50 ## Multinomial sampling posterior
StaPar=c(0.9,0.7,0.01)
#Fit:
fitbayes=ngssm.bayes(Ytm~Xtm,data=data.frame(Ytm,Xtm),
model=model,pz=NULL,StaPar=StaPar,
prw=c(1,1),prnu=c(0.1,0.1),prbetamu=rep(0,1),prbetasigma=diag(100,1,1),
pointss=pointss,nsamplex=50,postplot=FALSE,contourplot=FALSE)
posts=fitbayes[[2]]
#Prediction:
set.seed(1000)
predpar=Prediction(Ytm~Xtm,data=data.frame(Ytm,Xtm),
model=model,pz=NULL,StaPar=posts,
a0=0.01,b0=0.01,distl="PRED",ci=0.95,samples=500,hh=hh,
Xtprev=Xtprev,method="Bayes")
predpar
 
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ Reliability model}
\keyword{ NGSSM}
\keyword{ Exact likelihood}
\keyword{ States and observations forecasting}
\keyword{ States filtering}% __ONLY ONE__ keyword per line
