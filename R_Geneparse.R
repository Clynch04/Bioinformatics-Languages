print("hello, welcome to R")

library('ggplot2')
library('reshape2')

data<-read.csv("C:/Users/Connor Lynch/OneDrive/Desktop/Coding/geneparse_output.csv",header=TRUE,sep = ",")
Chromosome=data$Chromosome
GC=data$GC
total=data$total
Di_repeats=data$Di_repeats
User_input=data$User_input
ORF=data$ORF

gene.data<-data.frame(
  Chromosome,
  GC,
  total,
  Di_repeats,
  User_input,
  ORF
)

plot1<-ggplot(gene.data, aes(x=Di_repeats, y=total)) +
  geom_point() +
  geom_smooth(method=lm, se=FALSE, fullrange=TRUE)
print(plot1)

plot2<-ggplot(gene.data, aes(Chromosome, GC)) +
  geom_boxplot()
print(plot2)

plot3<-ggplot(gene.data, aes(Chromosome, Di_repeats)) +
  geom_boxplot()
print(plot3)

plot4<-ggplot(gene.data, aes(Chromosome, total)) +
  geom_boxplot()
print(plot4)

plot5<-ggplot(gene.data, aes(Chromosome, User_input)) +
  geom_boxplot()
print(plot5)