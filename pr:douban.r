library(stringr)
library(rvest)
library(RCurl)
library(openxlsx)
library(XML)
library(dplyr)
library(magrittr)

#构建数据框存放数据
top <-data.frame()
#设置网页入口网 根据页数设置循环
i<- seq(0,225,by=25)
for (i in 1:10){
  url1 <- "https://movie.douban.com/top250"
  url2 <- "?start="
  url3 <-"&filter="
  url <-paste(url1,url2,a[i],url3,sep = "")
  webpage <-read_html(url,encoding = 'utf-8') 
  #电影名
  title <- html_nodes(webpage,".title:nth-child(1)") %>% html_text()
  #排名
  rank <- html_nodes(webpage,"em") %>% html_text()
  rank <- as.numeric(rank)
  #评分
  rate <- html_nodes(webpage, ".rating_num") %>% html_text()
  rate <-as.numeric(rate)
  #评分人数
  num <- html_nodes(webpage, ".rating_num~ span") %>% html_text() %>% 
    str_match("[0-9]*") 
  num <- as.numeric(num)
  num <- num[!is.na(num)]
  #评论
  comment <- html_nodes(webpage, ".inq") %>% html_text()
  #提取所有的附加信息
  info <- webpage %>% html_nodes("div.info div.bd p:nth-child(1)") %>% 
    html_text(trim = TRUE)
  info <- str_split(info, "\\n")
  info1 <- sapply(info, "[", 1)
  #导演
  director <- str_trim(sapply(str_split(info1, "\\s{3}"), "[", 1))
  #演员
  actor <- str_trim(sapply(str_split(info1, "\\s{3}"), "[", 2))
  info2 <- sapply(info, "[", 2)
  #年份
  year <- str_trim(sapply(str_split(info2, "/"), "[", 1))
  #国家
  region <- str_trim(sapply(str_split(info2, "/"), "[", 2))
  #类型
  category <- str_trim(sapply(str_split(info2, "/"), "[", 3))
  top <- rbind(top,data.frame(rank,title,rate,num,director,actor,year,region,category))
}
#导出为Excel文件
wb <-createWorkbook()
addWorksheet(wb,"1")
writeDataTable(wb,1,top,tableStyle = "TableStyleLight16")
saveWorkbook(wb,"6.xlsx",overwrite = TRUE)
