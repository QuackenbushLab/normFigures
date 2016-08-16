library(yarn)
obj = readRDS("../data/gtex_filtered_genes.rds")

obj = normalizeTissueAware(obj,"our_subtypes")

saveRDS(obj,file="../data/gtex_normalized.rds")
