library(data.table)

relu=function(x){
	x=1/(1+exp(-x))
	return(x)
	}
meta.net=as.matrix(fread('metabolites.net.txt',data.table=F))
for (i in 1:nrow(meta.net)){
	index=which(meta.net[i,]<0)
	meta.net[i,index]=0
	print(i)
	}

meta.feature=read.table('metabolites.feature.txt')
D=colSums(meta.net)
D_hat=diag(D^(-0.5))

meta.net.gcn=relu(D_hat%*%meta.net%*%D_hat%*%as.matrix(meta.feature))


feature=meta.net.gcn
feature <- scale(meta.net.gcn, center = T, scale = T)
a=prcomp(feature, center = F,scale. = F)
f_242=feature%*%a$rotation[,1:21]

write.table(file='meta_feature.gcn.pca.txt',f_242,col.names=F,row.names=F,quote=F)


meta.net=as.matrix(fread('disease-sim.txt',data.table=F))
meta.feature=diag(1,nrow(meta.net),nrow(meta.net))
meta.net=meta.net+meta.feature
D=colSums(meta.net)
D_hat=diag(D^(-0.5))

meta.net.gcn=D_hat%*%meta.net%*%D_hat%*%as.matrix(meta.feature)
feature=meta.net.gcn
feature <- scale(meta.net.gcn, center = T, scale = T)
a=prcomp(feature, center = F,scale. = F)
f_242=feature%*%a$rotation[,1:232]

write.table(file='dis.feature.gcn.pca.txt',f_242,col.names=F,row.names=F,quote=F)
	
