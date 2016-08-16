library(yarn)
library(rafalib)
library(dplyr)

obj = readRDS("../data/gtex_final_samples.rds")

grabtiss = function(keyword,featurelist=pData(obj)$SMTSD,obj=obj){
	pnl = obj[,grep(keyword,featurelist)]
	pData(pnl)$SMTSD = factor(pData(pnl)$SMTSD)
	pData(pnl)$SMTS = factor(pData(pnl)$SMTS)
	pnl = pnl %>% filterMissingGenes %>% filterGenes
	pnl
}
panelA = grabtiss(keyword="Artery",obj=obj)
panelB = grabtiss(keyword="Skin",featurelist=pData(obj)$SMTS,obj=obj)
panelC = grabtiss(keyword="Esophagus",featurelist=pData(obj)$SMTSD,obj=obj)
panelD = grabtiss(keyword="Blood$",featurelist=pData(obj)$SMTS,obj=obj)
panelE = grabtiss(keyword="Sun",featurelist=pData(obj)$SMTSD,obj=obj)
panelF = grabtiss(keyword="Esophagus",featurelist=pData(obj)$SMTS,obj=obj)
panelF = panelF[,-grep("Mucosa",pData(panelF)$SMTSD)]
pData(panelF)$SMTSD = droplevels(pData(panelF)$SMTSD)


pdf("../figures/gtex_figure2_tissuesToMerge.pdf",width=12,height=8)
mypar(2,3,brewer.name="Set1")
ret = checkTissuesToMerge(panelA,"SMTS","SMTSD",n=1000,legendPos="topleft")
ret = checkTissuesToMerge(panelB,"SMTS","SMTSD",n=1000,legendPos="topleft")
ret = checkTissuesToMerge(panelC,"SMTS","SMTSD",n=1000,legendPos="topleft")
ret = checkTissuesToMerge(panelD,"SMTS","SMTSD",n=1000,legendPos="topleft")
ret = checkTissuesToMerge(panelE,"SMTS","SMTSD",n=1000,legendPos="topleft")
ret = checkTissuesToMerge(panelF,"SMTS","SMTSD",n=1000,legendPos="topright")
dev.off()
