
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


df1  = read.csv("all_val.csv",as.is=T)
dim(df1)
col=colnames(df1)

library('caret')
#Removing Models with near zero variances

nzv=nearZeroVar(df1)
if (length(nzv)>0) df1=df1[,-nzv]

df2 = cor(df1)
df2[!lower.tri(df2)] = 0

#Taking only those models which are highly correlated with other models
a=apply(df2,2,function(x) any(x > 0.85))
a[1]=FALSE
a[2]=FALSE

#Removing them
reduced_Data = df1[,!a]

dim(reduced_Data)
write.csv(reduced_Data,"cor_removed_val.csv",row.names=F)


setwd(candidates_test)

df1  = read.csv("all_test.csv",as.is=T)
col=gsub('val','test',col)
names(a)=paste(gsub('val','test',names(a)))
df1=df1[,col]
dim(df1)
 if (length(nzv)>0) df1=df1[,-nzv]
reduced_Data = df1[,!a]
dim(reduced_Data)
write.csv(reduced_Data,"cor_removed_test.csv",row.names=F)


