#' Predict ngssm.mle.p object.
#'
#' @param x ngssm.mle.p object
#' @param ... ignored
#'@noRd
predict.ngssm.mle.p<- function(object,data=NULL,hh=NULL,...){
  if(!is.null(hh)){
    if (object$model!= "Poisson" && object$model!="SRGamma" && object$model!="SRWeibull")stop("Sorry! Forecasting is not available for the model.")
  }
  if(is.null(hh) ) {
    objecta <- list(object$fitted.values)
  } else if (object$model=="Poisson" || object$model=="SRGamma" || object$model=="SRWeibull"){
    objecta<-list(ngssm.mle.p(object,data=data,hh=hh))
  }
  else{
    objecta <- list(object$fitted.values)
  }
  class(objecta) = "ngssm.mle"
  return(objecta)
}
