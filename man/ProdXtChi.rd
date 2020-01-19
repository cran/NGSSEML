\name{ProdXtChi}
\alias{ProdXtChi}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  ProdXtChi
}
\description{
  ProdXtChi computes a constant to be inserted 
  in the likelihood of the PEM with covariate (PH model). 
}
\usage{
ProdXtChi(StaPar,Yt,Break,Event,Xt)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{StaPar}{
     the static parameter vector.
}
  \item{Yt}{
     a vector with the failure/censored times.
}
\item{Break}{
       a vector with the interval limits.
} 
\item{Event}{
     a censoring indicator (a vector).
}    

  \item{Xt}{
     the explanatory variables to be inserted in the model.
}
  
}
\details{
 Typical usages are
\preformatted{ProdXtChi(StaPar,Yt,Break,Event,Xt)}
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
  \item{cco}{a constant.}

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
   T. R. Santos
 
}
\note{
%%  ~~further notes~~
This function is ONLY to compute a constant to be inserted in the likelihood 
of the PEM with covariate. It is more an internal function.
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
\code{\link{LikeF}}
\code{\link{SmoothingF}}

}
\examples{
library(NGSSEML)
data(gte_data)
Yt=gte_data$V1
Xt=as.matrix(1:125)
model="PEM"
amp=FALSE
Event=gte_data$V2        # Event: failure, 1.
Break=GridP(Yt, Event, nT = NULL)
LabelParTheta=c("w")
StaPar=c(0.73)
out=ProdXtChi(StaPar,Yt,Break,Event,Xt)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ Reliability model}
\keyword{ NGSSM}
\keyword{ Exact likelihood}
\keyword{ States and observations forecasting}
\keyword{ States filtering}% __ONLY ONE__ keyword per line
