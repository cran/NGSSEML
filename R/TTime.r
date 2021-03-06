################################################################################
################################################################################
##
##
#'@noRd
 TTime<- function(StaPar,Yt,Event, Break, Xt = NULL){
    if (is.null(Event))stop("Bad input Event")
    if (is.null(Break))stop("Bad input Break")
    if (is.null(Yt))stop("Bad input Yt")
    if (is.vector(Yt)==FALSE)stop("Bad input for Yt")
    if(is.null(Xt)==FALSE){if(is.matrix(Xt)==FALSE){Xt=as.matrix(Xt)}}
    if (is.vector(Xt))stop("Bad input for Xt. Put as a matrix.")
    if (is.null(StaPar))stop("Bad input for StaPar")
    if (is.data.frame(StaPar))stop("Bad input for StaPar")

      if(is.null(Xt)==FALSE){
       if(is.null(dim(Xt))){
        dbeta=dim(t(Xt))[1]
        dStaPar=length(StaPar)
        Beta=matrix(StaPar[(dStaPar-dbeta+1):(dStaPar)],dbeta,1)
        }else{
        dbeta=dim(Xt)[2]
        dStaPar=length(StaPar)
        Beta=matrix(StaPar[(dStaPar-dbeta+1):(dStaPar)],dbeta,1)
        }
       }

  ksi<- 0
  ksicov<- 0
  nT<- length(Break) - 1
  N<- length(Yt)
  auxiliar<- matrix(NA, ncol = nT, nrow = N)
  auxiliarcov<- matrix(NA, ncol = nT, nrow = N)
  auxiliarcov2<- matrix(0, ncol = nT, nrow = N)

  for(j in 1:nT){ # for intervals (terms, T)
    for(i in 1:N){ # for individuals (N).  j = i in our notation!
      if(Yt[i] > Break[j] & Yt[i] <= Break[j+1]){ # time indiv. inside current interval
        if(is.null(Xt)){
        auxiliar[i,j]<- Yt[i] - Break[j]
        }else{
        auxiliarcov[i,j]<- (Yt[i] - Break[j])*exp(Xt[i,1:dbeta]%*%Beta)
        }

      }else{
        if(Yt[i] > Break[j+1]){ # time indiv. outside current interval
          if(is.null(Xt)){
          auxiliar[i,j]<- Break[j+1] - Break[j]
          }else{
          auxiliarcov[i,j]<- (Break[j+1] - Break[j])*exp(Xt[i,1:dbeta]%*%Beta)
          }
        }else{ # no contribution
          auxiliar[i,j]<- 0
          auxiliarcov[i,j]<- 0
       }
      }
    }
    ksi[j]<- sum(auxiliar[,j])
    ksicov[j]<- sum(auxiliarcov[,j])
  }
  if(is.null(Xt)){
     ttime=ksi
     return(ttime)
  } else{
   ttime=ksicov
    return(ttime)
  }
}
################################################################################
################################################################################