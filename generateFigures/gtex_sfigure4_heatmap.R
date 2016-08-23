library(yarn)
library(rafalib)
library(edgeR)
library(RColorBrewer)

obj = readRDS("../data/gtex_merged_tissues.rds")

counts = cpm(exprs(obj))
keep_strict = rowSums(counts > 1) >= ncol(obj)/2
obj_strict = obj[keep_strict, ]
obj_strict = normalizeTissueAware(obj_strict,"our_subtypes")

obj_strict = filterSamples(obj_strict,"Blood Vessel","SMTS",keepOnly=TRUE)
obj_strict = filterMissingGenes(obj_strict)
obj_strict = filterGenes(obj_strict)

keep_sane = rowSums(counts > 1) >= min(table(pData(obj)$our_subtypes))/2
obj_sane = obj[keep_sane, ]
obj_sane = normalizeTissueAware(obj_sane,"our_subtypes")

obj_sane = filterSamples(obj_sane,"Blood Vessel","SMTS",keepOnly=TRUE)
obj_sane = filterMissingGenes(obj_sane)
obj_sane = filterGenes(obj_sane)


tissues = pData(obj_sane)$our_subtypes
heatmapColColors=brewer.pal(12,"Set3")[as.integer(factor(tissues))]
heatmapCols = colorRampPalette(brewer.pal(9, "RdBu"))(50)

n = 25

mat = yarn:::extractMatrix(obj_strict, TRUE, TRUE)
genesToKeep = which(rowSums(mat) > 0)
geneStats = apply(mat[genesToKeep, ], 1, sd)
geneIndices = genesToKeep[order(geneStats, decreasing = TRUE)[seq_len(n)]]
fd_strict = fData(obj_strict)[geneIndices,]

mat = yarn:::extractMatrix(obj_sane, TRUE, TRUE)
genesToKeep = which(rowSums(mat) > 0)
geneStats = apply(mat[genesToKeep, ], 1, sd)
geneIndices = genesToKeep[order(geneStats, decreasing = TRUE)[seq_len(n)]]
fd_sane = fData(obj_sane)[geneIndices,]

pdf("../figures/gtex_sfigure4_heatmap.pdf")
	plotHeatmap(obj_strict,normalized=FALSE,log=TRUE,trace="none",n=n,
	 ColSideColors = heatmapColColors,cexCol = .6,
	 labRow=as.character(fd_strict$geneNames),labCol="")
	plotHeatmap(obj_sane,normalized=FALSE,log=TRUE,trace="none",n=n,
	 ColSideColors = heatmapColColors,cexCol = .6,
	 labRow=as.character(fd_sane$geneNames),labCol="")
dev.off()
