library(yarn)
obj = readRDS("../data/gtex_final_samples.rds")

# Get our tissue classification
our_subtypes = gsub(" - "," ",as.character(pData(obj)$SMTSD))
our_subtypes = gsub(" ","_",our_subtypes)
our_subtypes = tolower(our_subtypes)

brain_0 = which(pData(obj)$SMTSD == "Brain - Hypothalamus")
brain_01 = which(pData(obj)$SMTSD == "Brain - Amygdala")
brain_02 = which(pData(obj)$SMTSD == "Brain - Anterior cingulate cortex (BA24)")
brain_03 = which(pData(obj)$SMTSD == "Brain - Hippocampus")
brain_04 = which(pData(obj)$SMTSD == "Brain - Cortex")
brain_05 = which(pData(obj)$SMTSD == "Brain - Substantia nigra")
brain_06 = which(pData(obj)$SMTSD == "Brain - Spinal cord (cervical c-1)")
brain_07 = which(pData(obj)$SMTSD == "Brain - Frontal Cortex (BA9)")

brain_0 = union(brain_0,c(brain_01,brain_02,brain_03,brain_04,brain_05,brain_06,brain_07))
our_subtypes[brain_0] = "Brain-0"

brain_1 = c(which(pData(obj)$SMTSD=="Brain - Cerebellum"),which(pData(obj)$SMTSD=="Brain - Cerebellar Hemisphere"))
our_subtypes[brain_1] = "Brain-1"

brain_2 = c(which(pData(obj)$SMTSD=="Brain - Caudate (basal ganglia)"),which(pData(obj)$SMTSD=="Brain - Nucleus accumbens (basal ganglia)"),which(pData(obj)$SMTSD=="Brain - Putamen (basal ganglia)"))
our_subtypes[brain_2] = "Brain-2"


skin = grep("sun",our_subtypes)
our_subtypes[skin] = "skin"

our_subtypes = factor(tolower(our_subtypes))
pData(obj)$our_subtypes = our_subtypes

saveRDS(obj,file="../data/gtex_merged_tissues.rds")
