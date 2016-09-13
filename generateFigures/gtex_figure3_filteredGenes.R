library(yarn)
library(rafalib)
library(dplyr)

source("../generateFigures/helper.R")
obj = readRDS("../data/gtex_merged_tissues.rds")

genes = c("MUC7","REG3A","AHSG","GKN1","SMCP","NPPB")
cl = pData(obj)$our_subtypes
cl = abbreviations(cl)

pdf("../figures/gtex_figure3_filteredGenes.pdf",width=12,height=8)
	mypar(3,2,mar = c(2.0, 2.5, 1.6, 1.1))#brewer.name="Set3"
	for(i in genes[1:4]){
		exp = exprs(obj)[which(fData(obj)$geneNames%in%i),]
		boxplot(log2(exp + 1)~cl,main=i,col=1:38,xaxt="n",
			ylab=expression('log'[2]*' raw expression'))
	}
	for(i in genes[5:6]){
		exp = exprs(obj)[which(fData(obj)$geneNames%in%i),]
		boxplot(log2(exp + 1)~cl,main=i,col=1:38,xaxt="n",
			ylab=expression('log'[2]*' raw expression'),las=2)
		end_point = 0.5 + 38
		text(seq(1.5,end_point,by=1), par("usr")[3]-0.25, 
     	srt = 60, adj= 1, xpd = TRUE,
     	labels = levels(cl))
	}
dev.off()