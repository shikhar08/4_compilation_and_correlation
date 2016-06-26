
rm(list=ls())

user=(Sys.info()[6])
Desktop=paste("C:/Users/",user,"/Desktop/",sep="")
setwd(Desktop)


home=paste(Desktop,"MEMS/S3/Seminar-R&U/ForestFire/",sep="")

setwd(paste(home,'ForestFireModel',sep=''))

	preproc_dir=paste(home,'ForestFireModel',"/","preproc_data",sep='')
	dir.create("candidates_val")
	candidates_val=paste(home,'ForestFireModel',"/","candidates_val",sep='')
	dir.create("candidates_test")
	candidates_test=paste(home,'ForestFireModel',"/","candidates_test",sep='')
	
	setwd(candidates_val)
	myFiles <- list.files(pattern="*csv")
	
	library(plyr)
	import <- llply(myFiles, read.csv)
	b=do.call("cbind", import)
	

	setwd(preproc_dir)
	c=read.csv("val.csv",as.is=T)
	b=cbind(c[,c("id","dv_binary")],b)
	setwd(candidates_val)
	write.csv(b,"all_val.csv",row.names=F)
	col=gsub('val','test',colnames(b))
	
	
	setwd(candidates_test)
	myFiles <- list.files(pattern="*csv")

	
	import <- llply(myFiles, read.csv)
	b=do.call("cbind", import)

	setwd(preproc_dir)
	c=read.csv("test.csv",as.is=T)
	b=cbind(c[,c("id","dv_binary")],b)
	setwd(candidates_test)
	b=b[,col]
	write.csv(b,"all_test.csv",row.names=F)

