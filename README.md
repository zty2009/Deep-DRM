# GPDNN-for-Identify-ing-Disease-related-Metabolites

First, run GCNPCA_metabolites_diseases.R to extract features of metabolites and diseases respectively.


Then, run create_MDPfeature.R to combine the feature of metabolites and diseases to obtain the feature of MDPs. In the meanwhile, positive samples and negative samples will be generated.



Finally, run DNN.R to identify true MDPs. AUC and AUPR would be given. 
