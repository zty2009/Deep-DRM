# Deep-DRM: A computational Method for Identifying Dis-ease-related Metabolites based on Graph Deep Learning Approaches

File description:
1. alldata.txt is the label of each Metabolite-disease pair (MDP). The first column is metabolite ID in HMDB and the second column is the disease ID in Disease Ontology (DO). The third column is the label of MDP. If the metabolites are associated with diseases according to the HMDB, their labels would be 1. Otherwise, the labels would be 0.
2. disease-meta.txt collects all the MDPs recored in HMDB. They are also the positive samples of our work.
3. disease-sim.txt is the similarities of diseases. It is a 242*242 matrix which describes the similarity of any two diseases. The names of rows and columns are diseases which are recorded in sp_disease-id.txt. The way of calculating similarities is explained in our manscript section 2.1.2 Diseases network.
4. metabolites.net.txt is the similarities of metabolites. It is a 1436*1436 matrix which describes the similarity of any two metabolites. The names of rows and columns are metabolites which are recorded in metabolites_name.txt. The way of calculating similarities is explained in our manscript section 2.1.1 Metabolites network. 
5. sp_disease-id.txt is all the diseases ID in DO.
6. metabolites_name.txt is all the metabolites ID in HMDB.
7. metabolites.feature.txt is the features of metabolites which could be calculated according to section 2.2.1 Feature extraction.


Run our code:

1.Run GCNPCA_metabolites_diseases.R to extract features of metabolites and diseases respectively. This process uses 'metabolites.feature.txt', 'disease-sim.txt' and 'metabolites.net.txt'. 

2.Run create_MDPfeature.R to obtain the features of MDPs. In the meanwhile, positive samples and negative samples will be generated.

3.Finally, run DNN.R to build model and 10-cross validation. AUC and AUPR would be given.
