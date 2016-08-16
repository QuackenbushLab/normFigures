abbreviations<-function(cl,abb=TRUE){
	tis = "adipose_subcutaneous,adipose_visceral_(omentum),adrenal_gland,artery_aorta,artery_coronary,artery_tibial,brain-0,brain-1,brain-2,breast_mammary_tissue,cells_ebv-transformed_lymphocytes,cells_transformed_fibroblasts,colon_sigmoid,colon_transverse,esophagus_gastroesophageal_junction,esophagus_mucosa,esophagus_muscularis,heart_atrial_appendage,heart_left_ventricle,liver,lung,minor_salivary_gland,muscle_skeletal,nerve_tibial,pancreas,pituitary,skin,small_intestine_terminal_ileum,spleen,stomach,thyroid,whole_blood,ovary,uterus,vagina,prostate,testis,kidney_cortex"
	abr = "ADS,ADV,ADG,ATA,ATC,ATT,COR,CER,BST,BRM,LCL,FIB,CLS,CLT,ESG,ESM,ESS,HRA,HRV,LVR,LNG,MSG,MSS,NVT,PNC,PTT,SKN,SIT,SPL,STM,TYR,WBL,OVR,UTR,VGN,PRS,TST,KDN"
	tisname="Adipose subcutaneous,Adipose visceral,Adrenal gland,Artery aorta,Artery coronary,Artery tibial,Brain other,Brain cerebellum,Brain basal ganglia,Breast,Lymphoblastoid cell line,Fibroblast cell line,Colon sigmoid,Colon transverse,Gastroesophageal junction,Esophagus mucosa,Esophagus muscularis,Heart atrial appendage,Heart left ventricle,Liver,Lung,Minor salivary gland,Skeletal muscle,Tibial nerve,Pancreas,Pituitary,Skin,Intestine terminal ileum,Spleen,Stomach,Thyroid,Whole blood,Ovary,Uterus,Vagina,Prostate,Testis,Kidney cortex"
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