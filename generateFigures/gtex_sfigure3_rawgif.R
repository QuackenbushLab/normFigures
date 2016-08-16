library(yarn)
library(rafalib)

obj = readRDS("../data/gtex_merged_tissues.rds")
cl = names(sort(table(pData(obj)$SMTS),decreasing=TRUE))
groups = factor(pData(obj)$SMTS,levels=names(sort(table(pData(obj)$SMTS),decreasing=TRUE)))

for (i in 1:10){
  subsetTypes<-cl[1:i]
  groups2 = groups[which(groups%in%subsetTypes)]; groups2 = droplevels(groups2)
  obj2 = filterSamples(obj,ids=subsetTypes,"SMTS",keepOnly=TRUE)
  obj2 = filterLowGenes(obj2,"SMTS")


  fileName=paste("../figures/tissue_groups",as.character(i),".png",sep="")
  png(fileName,
	  width     = 4,
	  height    = 4,
	  units     = "in",
	  res       = 1200,
	  pointsize = 4)
	bigpar(1)

	plotDensity(obj2,groups2,legendPos="topright",
		ylab="Density",xlab="Log2 raw expression")
  dev.off()
}

system("convert -delay 80 ../figures/tissue_groups*.png ../figures/raw_tissue_groups.gif")
