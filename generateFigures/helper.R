abbreviations<-function(cl,abb=TRUE){
	tis = "adipose_subcutaneous,adipose_visceral_(omentum),adrenal_gland,artery_aorta,artery_coronary,artery_tibial,brain-0,brain-1,brain-2,breast_mammary_tissue,cells_ebv-transformed_lymphocytes,cells_transformed_fibroblasts,colon_sigmoid,colon_transverse,esophagus_gastroesophageal_junction,esophagus_mucosa,esophagus_muscularis,heart_atrial_appendage,heart_left_ventricle,kidney_cortex,liver,lung,minor_salivary_gland,muscle_skeletal,nerve_tibial,ovary,pancreas,pituitary,prostate,skin,small_intestine_terminal_ileum,spleen,stomach,testis,thyroid,uterus,vagina,whole_blood"
	abr = "ADS,ADV,ARG,ATA,ATC,ATT,BRO,BRC,BRB,BST,LCL,FIB,CLS,CLT,GEJ,EMC,EMS,HRA,HRV,KDN,LVR,LNG,MSG,SMU,TNV,OVR,PNC,PIT,PRS,SKN,ITI,SPL,STM,TST,THY,UTR,VGN,WBL"
	tisname = "Adipose subcutaneous,Adipose visceral,Adrenal gland,Artery aorta,Artery coronary,Artery tibial,Brain other,Brain cerebellum,Brain basal ganglia,Breast,Lymphoblastoid cell line,Fibroblast cell line,Colon sigmoid,Colon transverse,Gastroesophageal junction,Esophagus mucosa,Esophagus muscularis,Heart atrial appendage,Heart left ventricle,Kidney cortex,Liver,Lung,Minor salivary gland,Skeletal muscle,Tibial nerve,Ovary,Pancreas,Pituitary,Prostate,Skin,Intestine terminal ileum,Spleen,Stomach,Testis,Thyroid,Uterus,Vagina,Whole blood"
	abr = strsplit(abr,",")[[1]]
	tis = strsplit(tis,",")[[1]]
	tisname=strsplit(tisname,",")[[1]]
	if(abb){
		cl = abr[match(cl,tis)]
	} else {
		cl = tisname[match(cl,tis)]
	}
	factor(cl)
}
