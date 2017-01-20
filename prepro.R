fi<-dir("./dcdata/")
library(data.table)

dat<-c()

for(i in 1:length(fi)){
  tem<-read.csv(paste0("./dcdata/",fi[1]),stringsAsFactors = F)
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
