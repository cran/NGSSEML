\name{PriorF}
\alias{PriorF}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  Prior Function 
}
\description{
  This function computes the probability density function of the specified prior for 
the static parameters of the model. 
}
\usage{
PriorF(StaPar,model="Poisson",prw=c(1,1),prnu=NULL,prchi=NULL,prmu=NULL,
prbetamu=NULL,prbetasigma=NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{StaPar}{
     the static parameter vector.
}
  \item{model}{
       the chosen model for the observations. The options are: Poisson, Normal, Gamma,
Weibull, Generalized Gamma, Laplace, GED and PEM models.
}  
   \item{prw}{
        the numeric vector of length 2, indicating the hyperparameters of the 
       Beta prior distribution for the parameter w. Optional argument. The
default value is c(1,1), which constitutes an uninformative prior for common data sets.
}  

  \item{prnu}{
      the numeric vector of length 2, indicating the hyperparameters of the 
       Gamma prior distribution for the shape parameter nu. Optional argument. The
default value is NULL.
  }  

  \item{prchi}{
       the numeric vector of length 2, indicating the hyperparameters of the 
       Gamma prior distribution for the shape parameter chi. Optional argument. The
default value is NULL.
}  
  \item{prmu}{
       the numeric vector of length 2, indicating the mean and standard deviation for the 
       Gaussian prior distribution for the parameter mu. Optional argument. The
default value is NULL. This prior can be used in Normal, Laplace and
GED time series models.

}  
  \item{prbetamu}{
   the numeric vector of length p, indicating mean for the 
       Gaussian prior distribution for the parameter beta, the regression coefficients. Optional argument. The
default value is NULL.  
       
       }  
  \item{prbetasigma}{
      the numeric matrix of order p by p, indicating variance-covariance matrix of the 
       Gaussian prior distribution for the parameter beta, the regression coefficients. Optional argument. The
default value is NULL.  
}   

}
\details{
%%  ~~ If necessary, more details than the description above ~~
 Typical usages are
\preformatted{PriorF(StaPar,model="Poisson",prw=c(1,1),prnu=NULL,prchi=NULL,
prmu=NULL,prbetamu=NULL,prbetasigma=NULL)}
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
  \item{llik}{This function returns the probability density of the specified prior for 
the static parameters of the model.}
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
The arguments of this function depend on the static parameters in each model to be specified to 
the data.
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
\code{\link{ngssm.bayes}}
\code{\link{SmoothingF}}
}
\examples{
library(NGSSEML)
#Trend,CosAnnual,SinAnnual,CosSemiAnnual,SinSemiAnnual
LabelParTheta=c("w","Beta1","Beta2","Beta3","Beta4","Beta5")
StaPar=c(0.8,-0.1,0.01,0.01,0.01,0.01)
PriorF(StaPar,model="Poisson",prw=c(1,1),prnu=NULL,prchi=NULL,prmu=NULL,
prbetamu=rep(0,5),prbetasigma=diag(4, 5, 5))

}
%% Add one or more standard keywords, see file 'KEYWORDS' in the
%% R documentation directory.
\keyword{Dynamic model}
\keyword{NGSSM}
\keyword{Exact likelihood}
\keyword{States and observations forecasting}
\keyword{States filtering}% __ONLY ONE__ keyword per line
