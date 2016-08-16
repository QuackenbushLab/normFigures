library(yarn)
library(readr)

fileDir1 = "/ifs/labs/cccb/projects/gtex/dbgap/46628/PhenoGenotypeFiles/RootStudyConsentSet_phs000424.GTEx.v6.p1.c1.GRU/ExpressionFiles/phe000006.v2.GTEx_RNAseq.expression-data-matrixfmt.c1"
fileDir2 = "/ifs/labs/cccb/projects/gtex/dbgap/46628/PhenoGenotypeFiles/RootStudyConsentSet_phs000424.GTEx.v6.p1.c1.GRU/PhenotypeFiles"

### Create ExpressionSet object

# Grab count matrix
x = read_tsv(sprintf("%s/GTEx_Data_20150112_RNAseq_RNASeQCv1.1.8_gene_reads.gct.gz",fileDir1),skip=2)
counts = x[,-c(1:2)]
counts = as.matrix(counts)
for(i in 1:nrow(problems(x))){
	counts[problems(x)$row[i],problems(x)$col[i]] = 100000
}
rownames(counts) = unlist(x[,1])
ids = sapply(strsplit(colnames(counts),"-"),function(i)paste(i[1:2],collapse="-"))

# Create featureData AnnotatedDataFrame
genes = unlist(x[,1])
geneNames = unlist(x[,2])
names(geneNames) = genes
fd = AnnotatedDataFrame(data.frame(geneNames))

# Creating phenoData AnnotatedDataFrame
pd = read_tsv(sprintf("%s/phs000424.v6.pht002743.v6.p1.c1.GTEx_Sample_Attributes.GRU.txt",fileDir2),skip=10)
pd = as.matrix(pd)
rownames(pd) = pd[,"SAMPID"]
pd = AnnotatedDataFrame(data.frame(pd))
pd = pd[colnames(counts)]

pd2 = read_tsv(sprintf("%s/phs000424.v6.pht002742.v6.p1.c1.GTEx_Subject_Phenotypes.GRU.txt",fileDir2),skip=10)
pd2 = as.matrix(pd2)
rownames(pd2) = pd2[,"SUBJID"]
pd2 = pd2[which(rownames(pd2)%in%unique(ids)),] 
pd2 = pd2[match(ids,rownames(pd2)),]
rownames(pd2) = colnames(counts)
pd2 = AnnotatedDataFrame(data.frame(pd2))
fullpd = AnnotatedDataFrame(cbind(pData(pd),pData(pd2)))

# Create ExpressionSet
obj = ExpressionSet(as.matrix(counts))
phenoData(obj) = fullpd
featureData(obj) = fd

# Removing tissues not interesting
removeTissues = c("Bladder","Cervix Uteri","Fallopian Tube")
obj = filterSamples(obj,ids=removeTissues,groups="SMTS")

# Remove zero rows
obj = filterMissingGenes(obj)

# Place multiple phenodata and fixing missing labels
ids = sapply(strsplit(colnames(obj),"-"),function(i)paste(i[1:2],collapse="-"))
pData(obj)$ids = ids


colnames(pData(obj))[80] = "gender"
pData(obj)$gender = as.character(pData(obj)$gender)
pData(obj)$gender[pData(obj)$gender==1] = "MALE"
pData(obj)$gender[pData(obj)$gender==2] = "FEMALE"
pData(obj)$gender = factor(pData(obj)$gender,levels=c("FEMALE","MALE"))

pData(obj)["GTEX-YEC3-2526-101809-SM-5CVLT","SMTS"] = "Esophagus"
pData(obj)["GTEX-YEC4-1026-101814-SM-5P9FX","SMTS"] = "Esophagus"
pData(obj)["GTEX-YFC4-0126-101855-SM-5CVLZ","SMTS"] = "Skin"
pData(obj)["GTEX-YF7O-2326-101833-SM-5CVN9","SMTS"] = "Skin"
pData(obj)["GTEX-YEC3-1426-101806-SM-5PNXX","SMTS"] = "Stomach"

saveRDS(obj,file="../data/gtex.rds")