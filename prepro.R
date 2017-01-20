fi<-dir("./dcdata/")
library(data.table)

dat<-c()

for(i in 1:length(fi)){
  tem<-read.table(paste0("./dcdata/",fi[1]),stringsAsFactors = F, fileEncoding = "cp949",sep= ",")
  tem<-unlist(tem[-grep("^\\[[0-9].*\\]$",tem[,1]),1])
  tit<-strsplit(fi[1],"_")[[1]]
  tit<-tit[length(tit)]
  tit<-gsub(".csv","",tit)
  tem<-data.frame(tit,tem,stringsAsFactors = F)
  dat<-rbind(dat,tem)
  print(paste0(i," / ",length(fi)))
}

head(dat)
library(KoNLP)
library(data.table)
library(dplyr)

data<-dat[,c(1,2)]
rm(dat)
data[,1]<-as.factor(data[,1])
data<-data[data$tem!="x",]

data[,1]<-as.factor(data[,1])
write.table(levels(data[,1]),"classes.txt",row.names = F,col.names = F,quote = F)

data[,1]<-as.numeric(data[,1])
data[,1]<-as.character(data[,1])
data[,2]<-gsub("\\n"," ",data[,2])
data<-data[!is.na(data[,2]),]
data[,2]<-gsub("(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w_\\.-]*)*\\/?$/"," ",data[,2])
data[,2]<-gsub("  "," ",data[,2])
data[,2]<-gsub("  "," ",data[,2])
data[,2]<-gsub("  "," ",data[,2])
data[,2]<-unlist(lapply(data[,2],function(x) paste(convertHangulStringToKeyStrokes(x,isFullwidth = F),collapse="")))
tem<-data
# data<-tem
data[,2]<-gsub('[^a-zA-Z ]',"",data[,2])

data[,2]<-gsub("A","aa",data[,2])
data[,2]<-gsub("B","bb",data[,2])
data[,2]<-gsub("C","cc",data[,2])
data[,2]<-gsub("D","dd",data[,2])
data[,2]<-gsub("E","ee",data[,2])
data[,2]<-gsub("F","ff",data[,2])
data[,2]<-gsub("G","gg",data[,2])
data[,2]<-gsub("H","hh",data[,2])
data[,2]<-gsub("I","ii",data[,2])
data[,2]<-gsub("J","jj",data[,2])
data[,2]<-gsub("K","kk",data[,2])
data[,2]<-gsub("L","ll",data[,2])
data[,2]<-gsub("M","mm",data[,2])
data[,2]<-gsub("N","nn",data[,2])
data[,2]<-gsub("O","oo",data[,2])
data[,2]<-gsub("P","pp",data[,2])
data[,2]<-gsub("Q","qq",data[,2])
data[,2]<-gsub("R","rr",data[,2])
data[,2]<-gsub("S","ss",data[,2])
data[,2]<-gsub("T","tt",data[,2])
data[,2]<-gsub("U","uu",data[,2])
data[,2]<-gsub("V","vv",data[,2])
data[,2]<-gsub("W","ww",data[,2])
data[,2]<-gsub("X","xx",data[,2])
data[,2]<-gsub("Y","yy",data[,2])
data[,2]<-gsub("Z","zz",data[,2])

library(caret)
intrain<-createDataPartition(y=data[,1],p=0.7,list=FALSE)
train<-data[intrain,]
test<-data[-intrain,]

write.table(train,"train.csv",row.names = F,col.names = F, quote=T,sep = ",")
write.table(test,"test.csv",row.names = F,col.names = F, quote=T,sep = ",")