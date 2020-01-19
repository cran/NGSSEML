\name{GridP}
\alias{GridP}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  Grid function for the PEM
}
\description{
  The function GridP returns a vector with the interval limits (breaks) for the 
  baseline failure rate of the PEM.
}
\usage{
GridP(Yt, Event, nT = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
    \item{Yt}{
     is a vector with the failure/censored times.
}
  \item{Event}{
     is a censoring indicator (a vector).
}
  \item{nT}{
     is the number of intervals/breaks. Optional argument. 
     If nT==NULL, it is built one interval per failure is built.
}  
}
\details{
 Typical usages are
\preformatted{GridP(Yt, Event, nT = NULL)}
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
  \item{Break}{a vector with the interval limits (breaks).}
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
 If the argument 'nT' is 'NULL', it is built one interval per failure.

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
Xt=NULL
Zt=NULL
model="PEM"
amp=FALSE
Event=gte_data$V2        
Break=GridP(Yt, Event, nT = NULL)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ Reliability model}
\keyword{ NGSSM}
\keyword{ Exact likelihood}
\keyword{ States and observations forecasting}
\keyword{ States filtering}% __ONLY ONE__ keyword per line
