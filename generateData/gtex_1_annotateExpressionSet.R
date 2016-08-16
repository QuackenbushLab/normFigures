library(yarn)
obj = readRDS("../data/gtex.rds")

### Annotate from Biomart
genes <- sub("\\..*","",featureNames(obj))
obj = annotateFromBiomart(obj,genes=genes,host="dec2013.archive.ensembl.org", 
						biomart="ENSEMBL_MART_ENSEMBL", 
                      	dataset="hsapiens_gene_ensembl",
                      	 attributes=c("ensembl_gene_id",
                      	 	"chromosome_name","start_position",
                      	 	"end_position","gene_biotype"))

saveRDS(obj,file="../data/gtex_annotated.rds")
