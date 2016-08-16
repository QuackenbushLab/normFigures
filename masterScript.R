# This script will run the pipeline

source("https://bioconductor.org/biocLite.R")
download_not_installed<-function(x){
  for(i in x){
    if(!require(i,character.only=TRUE)){
      biocLite(i)
      library(i,character.only=TRUE)
    }
  }
}
reqd = c("RColorBrewer","rafalib","calibrate","edgeR","gplots","dplyr","devtools")
download_not_installed(reqd)

if(!require(yarn)){
        devtools::install_github("quackenbushlab/yarn")
}

rm(list=ls())
currentDir = getwd()
if(!dir.exists("data")){
	dir.create("data")
}
if(!dir.exists("figures")){
	dir.create("figures")
}

setwd("generateData")

message("Creating the eSet object")
source("gtex_0_createExpressionSet.R")

message("Annotating the expresson data")
source("gtex_1_annotateExpressionSet.R")

message("Removing mis-annotations")
source("gtex_2_removeMisAnnotations.R")

message("Merging tissues")
source("gtex_3_mergeTissues.R")

message("Filtering lowly expressed genes")
source("gtex_4_filterLowGenes.R")

message("Normalize tissue-aware manner")
source("gtex_5_normalizeTissues.R")

# Analysis + Figures
setwd(sprintf("%s/generateFigures",currentDir))

# Main figures
source("gtex_figure2_tissuesToMergeFigure.R")
source("gtex_figure3_filteredGenes.R")
source("gtex_figure4_countDistribution.R")

# Supplemental figures
source("gtex_sfigure1_checkMisAnnotationFigure.R")
source("gtex_sfigure2_tissuesToMergeFullFigure.R")
source("gtex_sfigure3_rawgif.R")
source("gtex_sfigure4_heatmap.R")
source("gtex_sfigure5_rmse.R")