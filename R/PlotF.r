##########################################################################################
##
##   PLOT FUNCTION
##
##########################################################################################
##
##

PlotF<-function(formula, data,na.action="na.omit",pz=NULL,nBreaks=NULL,
plotYt=TRUE,axisxdate=NULL,transf=1,model="Poisson",posts,Proc="Smooth",Type="Marg",
distl="PRED",a0=0.01,b0=0.01,ci=0.95,startdate=NULL,enddate=NULL,Freq=NULL,
Typeline='l',cols=c("black","blue","lightgrey"),xxlab="t",
yylab=expression(paste(hat(mu)[t])),xxlim=NULL,yylim=NULL,Lty=c(1,2,1),
Lwd=c(2,2,2),Cex=0.68){


#argument breaks ==FALSE or TRUE

#NA
 if(na.action=="na.omit"){na.omit(data)}

##Check formula
# if(check.env){
#    envs<-lapply(formula, environment)
#    hasenv<-which(sapply(envs,is.null))
#    if (length(hasenv)>1){
 #     for(i in 2:length(hasenv))
  #      if (!identical(envs[[hasenv[1]]],envs[[hasenv[i]]]))
#          warning("Different environments on formulas")
#    }
#  }

# DataFrame:  
#dataf<-data  
#dataf<-dataf[all.vars(formula)]
#Dataframe data
#if(length(all.vars(formula))> dim(data)[2])stop("Check the formula and data.")
#if(is.data.frame(data)==FALSE)stop("The argument needs to be a data frame.")

#attach(dataf)

if(model=="PEM"){
#Event=get(names(dataf)[2])
dataf<-data  
dataf<-dataf[c(all.vars(formula)[1],colnames(data)[2],all.vars(formula)[-1])]
#Dataframe data
if(length(all.vars(formula))> dim(data)[2])stop("Check the formula and data.")
if(is.data.frame(data)==FALSE)stop("The argument needs to be a data frame.")

#dataf<-dataf[all.vars(formula)]
#Yt=get(names(dataf)[1])
Ytdd=dataf[[colnames(dataf)[1]]]
Eventdd=dataf[[colnames(dataf)[2]]]
Breakdd=GridP(Ytdd, Eventdd, nT = nBreaks)
Event<-Eventdd
Break<-Breakdd
Xtdd=NULL
Ztdd=NULL
if(is.null(pz)){
if(dim(dataf)[2]>2){
nnnd=dim(dataf)[1]
ppd=dim(dataf)[2]-2
Xtdd=matrix(0,nnnd,ppd)
for(i in 1:ppd){
#Xt[,i]=get(names(dataf)[i+2])
Xtdd[,i]=dataf[[names(dataf)[i+2]]] 

}
}
}
 if(is.null(pz)!=TRUE){
nnnd=dim(dataf)[1]
ppd=dim(dataf)[2]-2-pz
if(ppd>=1){
Xtdd=matrix(0,nnnd,ppd)
for(i in 1:ppd){
#Xt[,i]=get(names(dataf)[i+2])
Xtdd[,i]=dataf[[names(dataf)[i+2]]]  
}
}
if(pz>=1){
Ztdd=matrix(0,nnnd,pz)
for(j in 1:pz){
#Zt[,j]=get(names(dataf)[j+ppd+2])
Ztdd[,j]=dataf[[names(dataf)[j+ppd+2]]]
}
}
}
}

if(model!="PEM"){
dataf<-data  
dataf<-dataf[all.vars(formula)]
Event<-NULL
Break<-NULL

#Dataframe data
if(length(all.vars(formula))> dim(data)[2])stop("Check the formula and data.")
if(is.data.frame(data)==FALSE)stop("The argument needs to be a data frame.")
Ytdd=dataf[[colnames(dataf)[1]]]
Xtdd=NULL
Ztdd=NULL
if(is.null(pz)){
if(dim(dataf)[2]>1){
nnnd=dim(dataf)[1]
ppd=dim(dataf)[2]-1
Xtdd=matrix(0,nnnd,ppd)
for(i in 1:ppd){
#Xt[,i]=get(names(dataf)[i+1])
##print(get(names(dataf)[i+1]))
Xtdd[,i]=dataf[[names(dataf)[i+1]]]  

}
}
}
if(is.null(pz)!=TRUE){
nnnd=dim(dataf)[1]
ppd=dim(dataf)[2]-1-pz
if(ppd>=1){
Xtdd=matrix(0,nnnd,ppd)
for(i in 1:ppd){
#Xt[,i]=get(names(dataf)[i+1])
Xtdd[,i]=dataf[[names(dataf)[i+1]]]  
}
}
if(pz>=1){
Ztdd=matrix(0,nnnd,pz)
for(j in 1:pz){
#Zt[,j]=get(names(dataf)[j+ppd+1])
Ztdd[,j]=dataf[[names(dataf)[j+ppd+1]]]
}
}
}
}
Yt<-Ytdd
Xt<-Xtdd
Zt<-Ztdd
#detach(dataf)
#print(Yt)
#print(Xt)
#print(Zt)



if(is.null(Xt)==FALSE){if(is.matrix(Xt)==FALSE){Xt=as.matrix(Xt)}}
if(is.null(Zt)==FALSE){if(is.matrix(Zt)==FALSE){Zt=as.matrix(Xt)}}

if(Proc=="Smooth"){
#Smoothing:
set.seed(1000)
nn=length(Yt)
samples=1
if(is.null(dim(posts))){samples=2000}
if(model=="PEM"){nn=length(Break)-1}
fits=SmoothingF(StaPar=posts,formula=formula,data=data,pz=pz,model=model,Type=Type,
a0=a0,b0=b0,ci=ci,splot=FALSE,samples=samples)

## Graph:
ytm=matrix(0,nn,4)
if(model=="PEM"){}else{ytm[,1]=Yt}
alpha=1-ci
#aplicar uma transf.
sums=fits[[1]]
if(is.null(dim(posts))){sums=fits}
ytm[,1]=ytm[,1]^(transf)
ytm[,2]=sums[,1]^(transf)
ytm[,3]=sums[,3]^(transf)
ytm[,4]=sums[,4]^(transf)
minyt=min(ytm)
maxyt=max(ytm)
if(is.null(axisxdate)){
#Seq. ordem das obs.
at=1:nn
}else{
#Date
#Deixar especificar o eixo date at!
#at = seq(as.Date(startdate),as.Date(enddate),Freq)
at=axisxdate
}
d=at
#if(is.null(startdate)==FALSE & is.null(enddate)==FALSE){
#dat=seq(d[1], d[length(d)], by="month")}
if(is.null(yylim)|is.null(yylim)){
plot(at,ytm[,2],xlab=xxlab,ylab=yylab,type=Typeline,axes=FALSE,ylim=c(minyt,maxyt),col="white")
seq1=at
seq2=sort(at,decreasing = TRUE)
xxx=sort(at,decreasing = TRUE)
polygon(c(at, xxx),c((ytm[,4]),rev((ytm[,3]))),ylim=c(minyt,maxyt),col=cols[3],border=cols[3])
if(plotYt==TRUE){
par(new=TRUE)
plot(at,ytm[,1],xlab=xxlab,ylab=yylab,type=Typeline,axes=TRUE,ylim=c(minyt,maxyt),lty=c(Lty[1]),
lwd=c(Lwd[1]),col=c(cols[1]))
}
par(new=TRUE)
plot(at,ytm[,2],xlab=xxlab,ylab=yylab,type=Typeline,axes=TRUE,ylim=c(minyt,maxyt),lty=c(Lty[2]),
lwd=c(Lwd[2]),col=c(cols[2]),cex=Cex)
}else{
plot(at,ytm[,2],xlab=xxlab,ylab=yylab,type=Typeline,axes=FALSE,ylim=c(yylim[1],yylim[2]),col="white",cex=Cex)
seq1=at
seq2=sort(at,decreasing = TRUE)
xxx=sort(at,decreasing = TRUE)
polygon(c(at, xxx),c((ytm[,4]),rev((ytm[,3]))),ylim=c(yylim[1],yylim[2]),col=cols[3],border=cols[3])
if(plotYt==TRUE){
par(new=TRUE)
plot(at,ytm[,1],xlab=xxlab,ylab=yylab,type=Typeline,ylim=c(yylim[1],yylim[2]),axes=TRUE,lty=c(Lty[1]),
lwd=c(Lwd[1]),col=c(cols[1]),cex=Cex)
}
par(new=TRUE)
plot(at,ytm[,2],xlab=xxlab,ylab=yylab,type=Typeline,ylim=c(yylim[1],yylim[2]),axes=TRUE,lty=c(Lty[2]),
lwd=c(Lwd[2]),col=c(cols[2]),cex=Cex)

}
#axis.Date(1,at=dat,labels=dat, las = 1)
##axis(2, at =round(seq(min(ytm[,4]), max(ytm[,4]),((max(ytm[,4])-min(ytm[,4]))/10)),digits=2), las = 1, tck = +0.01,cex.axis=0.7)
##if(is.null(startdate) | is.null(enddate)|is.null(Freq)|is.null(axisxdate)){
#Seq. ordem das obs.
#seq(min(ytm[,4]), max(ytm[,4]),((max(ytm[,4]))/10))
#axis(1, at =at , las = 1, tck =+0.01,cex.axis=0.5)
##axis(1, at =round(seq(min(att), max(att),((max(att))/100))), las = 1, tck =+0.01,cex.axis=0.7)

##}else{
#Date
#Deixar especificar o eixo date at!
#axis.Date(1, at = seq(as.Date(startdate),as.Date(enddate),"years"),cex.axis=0.7)
#axis.Date(1, at = seq(as.Date(startdate),as.Date(enddate),Freq),labels = FALSE, tcl = -0.2,cex.axis=0.7)
##at=1:nn
##seqq=round(seq(min(att), max(att),((max(att))/100)))
##axis.Date(1, at = axisxdate[seqq],labels = axisxdate[seqq], tcl = -0.4,cex.axis=0.7)

##}
if(plotYt==TRUE){
legend("topright", c("Time Series","Smoothed Mean","95 CI"),
lty=Lty,lwd=Lwd,col=cols,cex=Cex, bty="n")
}else{
legend("topright", c("Smoothed Mean","95 CI"),
lty=Lty[-1],lwd=Lwd[-1],col=cols[-1],cex=Cex, bty="n")
}

} #End Smooth

if(Proc=="Filter"){
#Filtering:
nn=length(Yt)
if(model=="PEM"){nn=length(Break)-1}
filpar1=matrix(0,nn,nsamplex)
#samples=1
#if(is.null(dim(posts))){samples=500}
for(j in 1:nsamplex){
filparaux=FilteringF(StaPar=posts[j,],formula=formula,data=data,model=model,pz=pz,
a0=a0,b0=b0,distl=distl,splot=FALSE)
filpar1[,j]=((filparaux[1,]/ filparaux[2,]))
}
filpar=apply(filpar1,1,mean)
#filparmedian=apply(filpar1,1,median)
alpha=1-ci
filparp1=apply(filpar1,1,function(x) quantile(x,probs=c(alpha/2)))    #perc alpha/2
filparp2=apply(filpar1,1,function(x) quantile(x,probs=c(1-(alpha/2))))   #perc 1-alpha/2

## Graph:
ytm=matrix(0,nn,4)
if(model=="PEM"){}else{ytm[,1]=Yt}
#aplicar uma transf.
#sums=fits[[1]]
ytm[,2]=filpar^(transf)
ytm[,3]=filparp1^(transf)
ytm[,4]=filparp2^(transf)
minyt=min(ytm)
maxyt=max(ytm)
if(is.null(axisxdate)){
#Seq. ordem das obs.
at=1:nn
}else{
#Date
#Deixar especificar o eixo date at!
#at = seq(as.Date(startdate),as.Date(enddate),Freq)
at=axisxdate
}
d=at
#if(is.null(startdate)==FALSE & is.null(enddate)==FALSE){
#dat=seq(d[1], d[length(d)], by="month")}
if(is.null(yylim)|is.null(yylim)){
plot(at,ytm[,2],xlab=xxlab,ylab=yylab,type=Typeline,axes=FALSE,ylim=c(minyt,maxyt),col="white",cex=Cex)
seq1=at
seq2=sort(at,decreasing = TRUE)
xxx=sort(at,decreasing = TRUE)
polygon(c(at, xxx),c((ytm[,4]),rev((ytm[,3]))),ylim=c(minyt,maxyt),col=cols[3],border=cols[3])
if(plotYt==TRUE){
par(new=TRUE)
plot(at,ytm[,1],xlab=xxlab,ylab=yylab,type=Typeline,axes=TRUE,ylim=c(minyt,maxyt),lty=c(Lty[1]),
lwd=c(Lwd[1]),col=c(cols[1]),cex=Cex)
}
par(new=TRUE)
plot(at,ytm[,2],xlab=xxlab,ylab=yylab,type=Typeline,axes=TRUE,ylim=c(minyt,maxyt),lty=c(Lty[2]),
lwd=c(Lwd[2]),col=c(cols[2]),cex=Cex)
}else{
plot(at,ytm[,2],xlab=xxlab,ylab=yylab,type=Typeline,axes=FALSE,ylim=c(yylim[1],yylim[2]),col="white",cex=Cex)
seq1=at
seq2=sort(at,decreasing = TRUE)
xxx=sort(at,decreasing = TRUE)
polygon(c(at, xxx),c((ytm[,4]),rev((ytm[,3]))),ylim=c(yylim[1],yylim[2]),col=cols[3],border=cols[3])
if(plotYt==TRUE){
par(new=TRUE)
plot(at,ytm[,1],xlab=xxlab,ylab=yylab,type=Typeline,ylim=c(yylim[1],yylim[2]),axes=TRUE,lty=c(Lty[1]),
lwd=c(Lwd[2]),col=c(cols[1]),cex=Cex)
}
par(new=TRUE)
plot(at,ytm[,2],xlab=xxlab,ylab=yylab,type=Typeline,ylim=c(yylim[1],yylim[2]),axes=TRUE,lty=c(Lty[2]),
lwd=c(Lwd[2]),col=c(cols[2]),cex=Cex)

}

if(plotYt==TRUE){
legend("topright", c("Time Series","Filtered Mean","95 CI"),
lty=Lty,lwd=Lwd,col=cols,cex=Cex, bty="n")
}else{
legend("topright", c("Filtered Mean","95 CI"),
lty=Lty[-1],lwd=Lwd[-1],col=cols[-1],cex=Cex, bty="n")

}

} #EndFilter




} #End PlotF
##########################################################################################
