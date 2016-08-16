library(yarn)
obj = readRDS("../data/gtex_merged_tissues.rds")

message("smallest sample size is:")
show(min(table(pData(obj)$our_subtypes)))
obj = filterLowGenes(obj,"our_subtypes")

saveRDS(obj,file="../data/gtex_filtered_genes.rds")
