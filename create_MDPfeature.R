setwd('C:/Users/zty20/Desktop/metabolites-disease/sp')
alldata=read.table('alldata.txt',stringsAsFactor=F)	
posdata=alldata[which(alldata[,3]==1),]
meta.feature=read.table('meta_feature.gcn.pca.txt')
dis.feature=read.table('dis.feature.gcn.pca.txt')
dis.meta=read.table('disease-meta.txt',sep='\t',quote='',head=T,stringsAsFactor=F)
alldis=read.table('sp_disease-id.txt',sep='\t',quote='',stringsAsFactor=F)
allmeta=read.table('metabolites_name.txt',sep='\t',quote='',stringsAsFactor=F)
for (i in 1:nrow(dis.meta)){
	index1=which(dis.meta[i,2]==allmeta)
	index2=which(dis.meta[i,1]==alldis[,1])
	feature=c(dis.meta[i,1:2],meta.feature[index1,],dis.feature[index2,])
	dim(feature)=c(1,length(feature))
	write.table(file='posdata_gcnpca.txt',feature,col.names=F,row.names=F,quote=F,append=T)

	}
alldata=read.table('alldata.txt',stringsAsFactor=F)	
posdata=alldata[which(alldata[,3]==1),]
negdata=alldata[which(alldata[,3]==0),]
for (i in 1:5){
print(i)
set.seed(i)
index=sample(1:nrow(negdata),nrow(posdata))
neg=negdata[index,1:2]
name=paste('neg',i,'_gcnpca','.txt',sep='')
	for (j in 1:nrow(neg)){
		print(j)
	index1=which(neg[j,1]==allmeta)
	index2=which(neg[j,2]==alldis[,1])
	feature=c(neg[j,],meta.feature[index1,],dis.feature[index2,])
	dim(feature)=c(1,length(feature))
	write.table(file=name,feature,col.names=F,row.names=F,quote=F,append=T)

	}
}
	
	