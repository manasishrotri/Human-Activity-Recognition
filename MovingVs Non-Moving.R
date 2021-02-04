setwd("D:/MS DS WPI/Sem I/DS 502/Project/HAPT Data Set/Data_preprocessed/")

train=read.csv("train_data.csv",header=T)
test=read.csv("test_data.csv",header=T)

X_train=train[,-c(colnames(train)%in%c('activity','subject_id'))]
Y_train=train[,c(colnames(train)%in%'activity')]
Sub_train=data.frame(train[,c(colnames(train)%in%c('subject_id'))])
colnames(Sub_train)<-"subject_id"

X_test=test[,-c(colnames(test)%in%c('activity','subject_id'))]
Y_test=test[,c(colnames(test)%in%'activity')]
Sub_test=data.frame(test[,c(colnames(test)%in%c('subject_id'))])
colnames(Sub_test)<-"subject_id"
train_activity_ind<-which(Y_train%in%c(1,2,3,4,5,6))
test_activity_ind<-which(Y_test%in%c(1,2,3,4,5,6))

X_train=X_train[train_activity_ind,]
Y_train=Y_train[train_activity_ind]

X_test=X_test[test_activity_ind,]
Y_test=Y_test[test_activity_ind]


#Moving Vs Non Moving


Train_Walk=ifelse(Y_train<=3,1,0)
Test_Walk=ifelse(Y_test<=3,1,0)

Y_train_data=data.frame(Y_train,Train_Walk)
colnames(Y_train_data)<-c("activity","walking")
g<-ggplot(Y_train_data, aes(x=walking)) + geom_histogram(colour="White",fill="Blue",bins = 2,binwidth = 0.3)+scale_x_continuous(breaks = seq(0, 1, 1))
print(g)

Y_test_data=data.frame(Y_test,Test_Walk)
colnames(Y_test_data)<-c("activity","walking")
model_data=data.frame(X_train,Y_train_data$walking)


#Model1
#Logistic Regression
glm_model <- glm(Y_train_data.walking ~.,family=binomial,data=model_data)
summary(glm_model)

Y_pred <- predict(glm_model, X_test,"response")
Y_label <- rep(0, length(Y_pred))
Y_label[Y_pred > 0.5] <- 1
t<-table(Y_label, Test_Walk)
Con<-confusionMatrix(t)
con_mat<-Con$table
print("Confusion Matrix")
print(con_mat)
n = sum(con_mat) # number of instances
nc = nrow(con_mat) # number of classes
diag = diag(con_mat) # number of correctly classified instances per class 
rowsums = apply(con_mat, 1, sum) # number of instances per class
colsums = apply(con_mat, 2, sum) # number of predictions per class
p = rowsums / n # distribution of instances over the actual classes
q = colsums / n # distribution of instances over the predicted classes

accuracy = sum(diag) / n 
cat("\n\nAccuracy ",accuracy)

precision = diag / colsums 
recall = diag / rowsums 
cat("\n\nPrecision",precision)
cat("\nRecall",recall)

f1 = 2 * precision * recall / (precision + recall) 
cat("\nf1 ",f1)



ROC_logreg<-roc(Y_label,Test_Walk)
plot(ROC_logreg)
cat("AUC",auc(ROC_logreg))



#Model 2
#SVM
library(e1071)
SVM_clf = svm(formula = Y_train_data.walking ~ ., 
                   data = model_data, 
                   type = 'C-classification', 
                   kernel = 'linear') 
summary(SVM_clf)
y_pred_SVM = predict(SVM_clf, newdata = X_test) 
#Model Evaluation
t<-table(Y_label, y_pred_SVM)
Con<-confusionMatrix(t)
con_mat<-Con$table
print("Confusion Matrix")
print(con_mat)
n = sum(con_mat) # number of instances
nc = nrow(con_mat) # number of classes
diag = diag(con_mat) # number of correctly classified instances per class 
rowsums = apply(con_mat, 1, sum) # number of instances per class
colsums = apply(con_mat, 2, sum) # number of predictions per class
p = rowsums / n # distribution of instances over the actual classes
q = colsums / n # distribution of instances over the predicted classes

accuracy = sum(diag) / n 
cat("\n\nAccuracy ",accuracy)

precision = diag / colsums 
recall = diag / rowsums 
cat("\n\nPrecision",precision)
cat("\nRecall",recall)

f1 = 2 * precision * recall / (precision + recall) 
cat("\nf1 ",f1)


y_pred_SVM_prob = predict(SVM_clf, newdata = X_test,type="prob") 
ROC_SVM<-roc(as.factor(Y_label),y_pred_SVM_prob)
plot(ROC_SVM)
cat("AUC",auc(ROC_SVM))

#Model 3
#RandomForest
library(randomForest)  
RF_clf <- randomForest(Y_train_data.walking ~ ., data = model_data,ntree=20,  importance = TRUE)
y_pred_RF = predict(RF_clf, newdata = X_test,type="class") 
Y_label_RF <- rep(0, length(y_pred_RF))
Y_label_RF[y_pred_RF > 0.5] <- 1
print("Confusion Matrix")
t<-table(Y_label, Y_label_RF)
Con<-confusionMatrix(t)
con_mat<-Con$table
print("Confusion Matrix")
print(con_mat)
n = sum(con_mat) # number of instances
nc = nrow(con_mat) # number of classes
diag = diag(con_mat) # number of correctly classified instances per class 
rowsums = apply(con_mat, 1, sum) # number of instances per class
colsums = apply(con_mat, 2, sum) # number of predictions per class
p = rowsums / n # distribution of instances over the actual classes
q = colsums / n # distribution of instances over the predicted classes

accuracy = sum(diag) / n 
cat("\n\nAccuracy ",accuracy)

precision = diag / colsums 
recall = diag / rowsums 
cat("\n\nPrecision",precision)
cat("\nRecall",recall)

f1 = 2 * precision * recall / (precision + recall) 
cat("\nf1 ",f1)


ROC_RF<-roc(Y_label,Y_label_RF)
plot(ROC_RF)
cat("AUC",auc(ROC_RF))

