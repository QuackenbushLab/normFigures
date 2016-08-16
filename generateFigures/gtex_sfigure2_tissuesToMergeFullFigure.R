library(yarn)
library(rafalib)
library(dplyr)

obj = readRDS("../data/gtex_final_samples.rds")

pd = pData(obj)
ntissues = sapply(by(pd$SMTSD,pd$SMTS,unique),length)
tissues = names(which(ntissues>1))
temporaryObject = filterSamples(obj,tissues,"SMTS",keepOnly=TRUE) %>% 
					filterMissingGenes %>% filterGenes
pData(temporaryObject)$SMTS = factor(pData(temporaryObject)$SMTS,levels = unique(pData(temporaryObject)$SMTS)[c(1:2,4,6,8,5,7,3)])

grabtiss = function(keyword,featurelist=pData(temporaryObject)$SMTSD,obj=temporaryObject){
	pnl = obj[,grep(keyword,featurelist)]
	pData(pnl)$SMTSD = factor(pData(pnl)$SMTSD)
	pData(pnl)$SMTS = factor(pData(pnl)$SMTS)
	pnl
}
panelI = grabtiss(keyword = "Sun")
panelJ = grabtiss(keyword="Esophagus",featurelist=pData(temporaryObject)$SMTS)
panelJ = panelJ[,-grep("Mucosa",pData(panelJ)$SMTSD)]

panelKL= grabtiss(keyword="Brain",featurelist=pData(temporaryObject)$SMTS)
panelK = panelKL[,-grep("Cere",pData(panelKL)$SMTSD)]
panelL = panelK[,-grep("basal",pData(panelK)$SMTSD)]


pdf("../figures/gtex_sfigure2_tissuesToMergeFull.pdf",width=11.25,height=15)
mypar(4,3,brewer.name="Set3",brewer.n=12)
temporaryObject %>% 
	filterSamples("Adipose Tissue","SMTS",keepOnly=TRUE) %>% 
	checkTissuesToMerge("SMTS","SMTSD",n=1000,legendPos="bottomright")

temporaryObject %>% 
	filterSamples("Blood","SMTS",keepOnly=TRUE) %>% 
	checkTissuesToMerge("SMTS","SMTSD",n=1000,legendPos="topleft")

temporaryObject %>% 
	filterSamples("Blood Vessel","SMTS",keepOnly=TRUE) %>% 
	checkTissuesToMerge("SMTS","SMTSD",n=1000,legendPos="topleft")

temporaryObject %>% 
	filterSamples("Colon","SMTS",keepOnly=TRUE) %>% 
	checkTissuesToMerge("SMTS","SMTSD",n=1000,legendPos="topright")

temporaryObject %>% 
	filterSamples("Heart","SMTS",keepOnly=TRUE) %>% 
	checkTissuesToMerge("SMTS","SMTSD",n=1000,legendPos="topleft")

temporaryObject %>% 
	filterSamples("Skin","SMTS",keepOnly=TRUE) %>% 
	checkTissuesToMerge("SMTS","SMTSD",n=1000,legendPos="bottomleft")
checkTissuesToMerge(panelI,"SMTS","SMTSD",n=1000,legendPos="topleft")

temporaryObject %>% 
	filterSamples("Esophagus","SMTS",keepOnly=TRUE) %>% 
	checkTissuesToMerge("SMTS","SMTSD",n=1000,legendPos="topleft")
checkTissuesToMerge(panelJ,"SMTS","SMTSD",n=1000,legendPos="topright")

temporaryObject %>% 
	filterSamples("Brain","SMTS",keepOnly=TRUE) %>% 
	checkTissuesToMerge("SMTS","SMTSD",n=1000)
brain = temporaryObject %>% 
	filterSamples("Brain","SMTS",keepOnly=TRUE)	
legend("topright",legend=levels(factor(pData(brain)$SMTSD)),fill=1:13,cex=.65)
checkTissuesToMerge(panelK,"SMTS","SMTSD",n=1000)
legend("bottomleft",legend=levels(factor(pData(panelK)$SMTSD)),fill=(1:13),cex=.75)

checkTissuesToMerge(panelL,"SMTS","SMTSD",n=1000)
legend("bottomleft",legend=levels(factor(pData(panelL)$SMTSD)),fill=1:13,cex=.75)
dev.off()
