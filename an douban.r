library(jiebaR,jiebaRD) 
library(wordcloud2)
library(openxlsx)

ne=scan('C:/Users/10492/Desktop/douban.txt',sep='\n',what='',encoding="UTF-8")#文本处理

text<-douban$rate #提取文本数据所在列（可选）

#分词部分
mixseg<-worker("mix") #建立模型分词
a<-segment(ne,mixseg) #开始分词，segement函数必须支持文本格式的读取文件.txt，疑问：为什么不可以将数据框进行转换？或者提取数据框中的一段？

#添加停用词
topwords <- read.table("C:/Users/Thinkpad/Desktop/停用词.txt")
class(stopwords) 
stopwords <- as.vector(stopwords[,1]) 
wordResult <- removeWords(a,stopwords)

#词频统计部分
freq<-table(a) #词频统计
View(freq)   #查看词频统计结果

#把词频统计结果作为表格输出
c=data.frame(freq)
wb=createWorkbook()
addWorksheet(wb,'qusiba')
writeDataTable(wb,1,c,tableStyle = 'tableStylelight16')
saveWorkbook(wb,'qsiba.xlsx',overwrite = TRUE)

#绘制词云
wordcloud2(freq,shape='star') #绘制词云

#可选样式
wordcloud2(demoFreq)
wordcloud2(demoFreq, size = 2)
wordcloud2(demoFreq, size = 1,shape = 'pentagon')
wordcloud2(demoFreq, size = 1,shape = 'star')
wordcloud2(demoFreq, size = 2,
           color = "random-light", backgroundColor = "grey")
wordcloud2(demoFreq, size = 2, minRotation = -pi/2, maxRotation = -pi/2)
wordcloud2(demoFreq, size = 2, minRotation = -pi/6, maxRotation = -pi/6,
           rotateRatio = 1)
wordcloud2(demoFreq, size = 2, minRotation = -pi/6, maxRotation = pi/6,
           rotateRatio = 0.9)
wordcloud2(demoFreqC, size = 2,
           color = "random-light", backgroundColor = "grey")
wordcloud2(demoFreqC, size = 2, minRotation = -pi/6, maxRotation = -pi/6,
           rotateRatio = 1)
# Color Vector
colorVec = rep(c('red', 'skyblue'), length.out=nrow(demoFreq))
wordcloud2(demoFreq, color = colorVec, fontWeight = "bold")
wordcloud2(demoFreq,
           color = ifelse(demoFreq[, 2] > 20, 'red', 'skyblue'))
