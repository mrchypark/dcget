library(rvest)

url<-"http://wstatic.dcinside.com/gallery/gallindex_iframe_new_gallery.html"
tem<-read_html(url)
titV<-tem%>% html_nodes("ul li a.list_title")%>%html_text()
titIn<-tem%>% html_nodes("ul.list_category li a")%>%html_text()

urlsV<-tem%>% html_nodes("ul li a.list_title")%>%html_attr("href")
urlsIn<-tem%>% html_nodes("ul.list_category li a")%>%html_attr("href")

urls<-c(urlsV,urlsIn)
urls<-urls[-c(1,2)]

# write.csv(urls,"./dccode.csv",row.names = F)

urls<-read.csv("./dccode.csv",stringsAsFactors = F)
urls<-urls[grep("http://gall.dcinside.com/board/lists",urls[,1]),]

for(i in 1639:length(urls)){
  ptit<-c()
  for(j in 1:100){
   
    url<-paste0(urls[i],"&page=",j)
    tem<-read_html(url)
    tit<-tem%>% html_nodes("td.t_subject a")%>%html_text()
    if(!identical(grep("^\\[[0-9].*\\]$",tit),integer(0))){
    tit<-tit[-grep("^\\[[0-9].*\\]$",tit)]}
    ptit<-c(ptit,tit)
  }
  write.csv(ptit,paste0("./dcdata/dc",strsplit(urls[i],"=")[[1]][2],"_",i,".csv"),row.names = F)
  print(paste0(i, " / ",length(urls)))
}