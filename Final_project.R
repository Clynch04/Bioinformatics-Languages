print("Welcome to R")
library('neuralnet')
library('ggplot2')
library('dplyr') # for resampling
library('caret') # for confusion matrix
data = read.csv('C:/Users/Connor Lynch/OneDrive/Desktop/Coding/Patient_Data.csv', header = TRUE)
GE = data$Gene_Expression; # Gene Expression
Age = data$Age; # sepal length
DFS = data$DFS_months; # sepal width
dataframe = data.frame(Age, DFS, GE)
subframe = data.frame(Age, DFS)
print (subframe)
rnd <- sample(1:62, 1)
set.seed(rnd)
mysample = sample_n(dataframe, 50, replace=FALSE)
print(mysample)
myspecies = mysample[3:3]
print(myspecies)

# run neural network classifier
mytest <- neuralnet(GE~Age+DFS, mysample, hidden = 3, linear.output = FALSE)
print(mytest)
print(plot(mytest))
mypred <- predict(mytest, subframe, rep = 1, all.units = FALSE)
print(round(mypred))
library(data.table)
print(max.col(mypred)) # return column with maximum value
myplot1 <-ggplot(mysample, aes(Age, DFS, colour = GE)) + geom_point()
                                
library('grid')
pushViewport(viewport(layout = grid.layout(3, 2)))
print(myplot1, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))

# confusion matrix
print(max.col(mypred))
GE_factor <- as.factor(GE)
print(as.integer(GE_factor))
GE_integer <- as.integer(GE_factor)
mymatrix <- confusionMatrix(as.factor(max.col(mypred)), as.factor(GE_integer))
print(mymatrix)
print(plot(mytest))
print("Leaving R")
#q()