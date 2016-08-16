library(yarn)
obj = readRDS("../data/gtex_annotated.rds")

# Remove troublesome samples
obj = filterSamples(obj,ids=c("GTEX-11ILO","K-562"),groups="ids")

# Remove zero rows
obj = filterMissingGenes(obj)

saveRDS(obj,file="../data/gtex_final_samples.rds")

# throwAwaySamples = which(pData(obj)$ids == "GTEX-11ILO" | pData(obj)$ids=="K-562")
# obj = obj[,-throwAwaySamples]
# throwAway = which(rowSums(exprs(obj))==0)
# if(length(throwAway)>0){
# 	obj = obj[-throwAway,]	
# }
