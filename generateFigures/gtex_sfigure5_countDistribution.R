library(yarn)
library(rafalib)
library(grid)

source("helper.R")
obj = readRDS("../data/gtex_normalized.rds")

pdf("../figures/gtex_sfigure5_normalizeTissues.pdf",width=10,height=5)
	mypar(1,2,brewer.name="Set3")
	plotDensity(obj,groups="our_subtypes",
		ylab="Density",xlab=expression('log'[2]*' raw expression'))
	groups = as.character(pData(obj)[, "our_subtypes"])
	groups = abbreviations(groups,abb=FALSE)
	legend("topright", legend = levels(groups),cex=.5,
		fill = 1:length(levels(groups)),box.col = NA)
	plotDensity(obj,groups="our_subtypes",normalized=TRUE,ylab="Density",
		xlab=expression('log'[2]*' normalized expression'))
	u <- par("usr")
	v <- c(
	  grconvertX(u[1:2], "user", "ndc"),
	  grconvertY(u[3:4], "user", "ndc")
	)
	v <- c( (v[1]+v[2])/2, v[2], (v[3]+v[4])/2, v[4] )
	par(fig=v, new=TRUE, mar=c(0,0,0,0) )
	plotDensity(obj, axes=TRUE, groups="our_subtypes",
		normalized=TRUE,ylab="",xlab="",xlim=c(5,11),ylim=c(0.05,0.09))
	box()
	
dev.off()
