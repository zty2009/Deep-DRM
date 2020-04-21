library(data.table)
negdata=fread('neg1_gcnpca.txt',stringsAsFactor=F,data.table=F)
posdata=fread('posdata_gcnpca.txt',stringsAsFactor=F,data.table=F)
title=posdata[,1:2]
col=ncol(posdata)
title.neg=negdata[,1:2]
posdata=as.matrix(posdata[,3:col])
negdata=as.matrix(negdata[,3:col])
library(keras)

negindex=cut(sample(1:nrow(negdata)),10, labels=F)
posindex=cut(sample(1:nrow(posdata)),10, labels=F)



for (kk in 1:10){

	test.index1=which(posindex==kk)
	test.index2=which(negindex==kk)
	train.index1=which(posindex!=kk)
	train.index2=which(negindex!=kk)

	x_train=rbind(posdata[train.index1,],negdata[train.index2,])
	
	y_train=to_categorical(c(rep(1,length(train.index1)),rep(0,length(train.index2))))
	
	x_test=rbind(posdata[test.index1,],negdata[test.index2,])
	y_test=to_categorical(c(rep(1,length(test.index1)),rep(0,length(test.index2))))
	ti=rbind(title[test.index1,],title.neg[test.index2,])
	label=c(rep(1,length(test.index1)),rep(0,length(test.index2)))
	ti=cbind(ti,label)
	pp=nrow(x_test)

model <- keras_model_sequential() 
model %>% 
layer_dense(units = 512, activation = "sigmoid") %>% 
  layer_dropout(rate = 0.4) %>% 
  layer_dense(units = 256, activation = "sigmoid") %>% 
  layer_dropout(rate = 0.3) %>% 
  layer_dense(units = 128, activation = "sigmoid") %>%
  layer_dropout(rate = 0.2) %>%
  layer_dense(units = 2, activation = "sigmoid")
  
  model %>% compile(
  loss = "binary_crossentropy",
  optimizer = optimizer_rmsprop(),
  metrics = c("accuracy")
)
history <- model %>% fit(
  as.matrix(x_train), y_train, 
  epochs = 35, batch_size = 64, 
  validation_split = 0.2
)
result=predict(model,as.matrix(x_test))[,2]
a=cbind(ti,result)

library(pROC)
library(PRROC)
i=1
name=paste('test',i,'.txt',sep='')
write.table(file=name,a,append=T,row.names=F,col.names=F,quote=F)
}
a=read.table(name)
roc(a[,3],a[,4])$auc
pr.curve(a[a[,3]==1,4],a[a[,3]==0,4])$auc.integral



