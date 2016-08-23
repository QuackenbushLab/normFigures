library(yarn)
library(rafalib)
library(dplyr)
source("helper.R")

obj = readRDS("../data/gtex_normalized.rds")

cl = pData(obj)$our_subtypes
cl = abbreviations(cl,abb=FALSE)
counts = exprs(obj)
sorted_counts = apply(counts,2,sort)

refM = rowMeans(sorted_counts)
# refMed = rowMedians(sorted_counts)
rmse = function(ref,obs){
	sqrt(mean((ref - obs)^2))
}
rmse_sorted_counts = sapply(1:ncol(sorted_counts),function(i){
	rms = rmse(log(refM+1),log(sorted_counts[,i]+1))
	rms
	})

sorted_counts_ts = split.data.frame(t(sorted_counts),f = cl)
sorted_counts_ts = lapply(sorted_counts_ts,t)

refM_ts = lapply(sorted_counts_ts,rowMeans)
rmse_sorted_counts_ts = sapply(seq(sorted_counts_ts),function(i){
	nm = names(sorted_counts_ts)[i]
	sub_counts = sorted_counts_ts[[i]]
	sub_refM   = refM_ts[[i]]
	rms = sapply(seq(ncol(sub_counts)),function(j){
			rmse(log(sub_refM+1),log(sub_counts[,j]+1))
		})
	names(rms) = nm
	rms
	})

rmse_sorted_counts_ts = unlist(rmse_sorted_counts_ts)
pdf("../figures/gtex_sfigure5_rmse.pdf",width=14,height=7)
	mypar(1,2,mar=c(15.5, 2.5, 1.6, 1.1))
	boxplot(rmse_sorted_counts~cl,las=3,ylim=c(0,2.5),col=1:38,ylab="RMSE",main="RMSE of sample to full reference")
	abline(h=median(rmse_sorted_counts),lty=2,col="red")
	# abline(h=.2,lty=2,col="red")
	boxplot(rmse_sorted_counts_ts~cl,las=3,ylim=c(0,2.5),col=1:38,ylab="RMSE",main="RMSE of sample to tissue reference")
	abline(h=median(rmse_sorted_counts_ts),lty=2,col="red")
	# abline(h=.2,lty=2,col="red")
dev.off()
# plot(y=rmse_sorted_counts,x=rmse_sorted_counts_ts,pch=21,bg=cl)
