

rm(list=ls())

user=(Sys.info()[6])
Desktop=paste("C:/Users/",user,"/Desktop/",sep="")
setwd(Desktop)


home=paste(Desktop,"MEMS/S4/R Programming/German/",sep="")

setwd(paste(home,'Model',sep=''))
preproc_dir=paste(home,'Model',"/","preproc_data",sep='')

candidates_val=paste(home,'Model',"/","candidates_val",sep='')

candidates_test=paste(home,'Model',"/","candidates_test",sep='')
	
setwd(candidates_val)
myFiles = list.files(pattern="*csv")

library(plyr)
##Importing all the model csv files
import = llply(myFiles, read.csv)
## Mass cbind
b=do.call("cbind", import)


setwd(preproc_dir)
c=read.csv("val.csv",as.is=T)
b=cbind(c[,c("id","dv")],b)
setwd(candidates_val)

#Saving all
write.csv(b,"all_val.csv",row.names=F)

#in test samples column names have "test" string as against "val" in validation samples
col=gsub('val','test',colnames(b))


setwd(candidates_test)
myFiles = list.files(pattern="*csv")


import = llply(myFiles, read.csv)
b=do.call("cbind", import)

setwd(preproc_dir)
c=read.csv("test.csv",as.is=T)
b=cbind(c[,c("id","dv")],b)
setwd(candidates_test)
b=b[,col]
write.csv(b,"all_test.csv",row.names=F)

