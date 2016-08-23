library(yarn)
library(calibrate)
library(rafalib)

obj = readRDS("../data/gtex_annotated.rds")

### Check mis-annotation 
pd = pData(obj)
ngenders = sapply(by(pd$gender,pd$SMTSD,unique),length)
tissues = names(ngenders[which(ngenders==2)])
temporaryObject = filterGenes(obj,keepOnly=TRUE)
temporaryObject = filterSamples(temporaryObject,ids=tissues,groups="SMTSD",keepOnly=TRUE)

res = lapply(tissues,function(i){
	objsubset = temporaryObject[,which(pData(temporaryObject)$SMTSD==i)]
	res=checkMisAnnotation(objsubset,
		phenotype="gender",
		controlGenes="Y",main=i,
		plotFlag=FALSE,
		n=200)
	list(cmp=res,gender=pData(objsubset)$gender)
})
names(res) = tissues

keep = sapply(sapply(seq(tissues),function(i){grep("11ILO",rownames(res[[i]][[1]]))}),length)

pdf("../figures/gtex_sfigure1_checkMisAnnotation.pdf",width=10,height=10)
mypar(4,4,brewer.name="Set1")
for(i in which(keep==1)){
	x = res[[i]]
	cl = as.integer(factor(x[[2]]))
	cl = adjustcolor(cl,alpha.f=.45)
	if(i == 38){
		cex.m=.85
	} 
	else{cex.m = 1}
	plot(x[[1]],pch=21,bg=cl,col=cl,main=names(res)[i],
		xlab="MDS component 1", ylab="MDS component 2",
		cex.main=cex.m)
	smpl = x[[1]][grep("11ILO",rownames(x[[1]])),]
	smplg= cl[grep("11ILO",rownames(x[[1]]))]
	points(x=smpl[1],y=smpl[2],pch=21,bg=smplg,cex=2)
	textxy(X=smpl[1],Y=smpl[2],labs="GTEX-11ILO",offset=-.8)
}
plot(1,xaxt="n",yaxt="n",pch="",xlab="",ylab="",bty="n")
legend("topleft",legend=levels(pData(obj)$gender),fill=1:2)
dev.off()
