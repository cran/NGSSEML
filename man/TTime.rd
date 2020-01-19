\name{TTime}
\alias{TTime}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  Total Failure Time
}
\description{
  The function TTime gives a vector with the contribution of the units for each interval of the PEM.
}
\usage{
TTime(StaPar,Yt,Event, Break, Xt = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{StaPar}{
     the static parameter vector.
}
  \item{Yt}{
     a vector with the failure/censored times.
}
\item{Event}{
     a censoring indicator (a vector).
}
\item{Break}{
       a vector with the interval limits.
}     

  \item{Xt}{
     the explanatory variables to be inserted in the model. Optional argument.
}
  
}
\details{
 Typical usages are
\preformatted{TTime(StaPar,Yt,Event, Break, Xt = NULL)}
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
  \item{ttime}{a vector with the contribution of the units for each interval.}

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
This function provides the total failure time.

}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
\code{\link{LikeF}}
\code{\link{SmoothingF}}
}
\examples{
################################################################################ 
#
## PEM Example: the GTE data 
##
################################################################################
library(NGSSEML)
data(gte_data)
Yt=gte_data$V1
Xt=NULL
Zt=NULL
amp=FALSE
Event=gte_data$V2        # Event: failure, 1.
Break=GridP(Yt, Event, nT = NULL)
StaPar=c(0.7)
out=TTime(StaPar,Yt,Event, Break, Xt = NULL)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ Reliability model}
\keyword{ NGSSM}
\keyword{ Exact likelihood}
\keyword{ States and observations forecasting}
\keyword{ States filtering}% __ONLY ONE__ keyword per line
