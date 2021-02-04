pca_traindata<-data.frame(activity=Y_train_data$activity,pc$x)
pca_traindata<-pca_traindata[,1:100]
test_pca<-predict(pc,newdata=X_test)
test_pca<-as.data.frame(test_pca)
test_pca<-test_pca[,1:100]


#SVM
library(e1071)
svm_model <- svm(as.factor(activity) ~ ., data=pca_traindata)
#Preparing testing data for modelling with PCA(Principal Component Analysis)
summary(svm_model)
#PCA for test data

Svm_result<-predict(svm_model,test_pca,type="class")
#Generating Confusion Matrix
t<-table(Y_test,Svm_result)
evaluation_matrix(t)

multi_result_prob<-predict(multi_model,test_pca,type="prob")
ROC_multinom <- multiclass.roc(Y_test, multi_result_prob)
plot(ROC_multinom, col = "green", main = "ROC For Multinominal Logistic Regression")
ROC_multinom_auc <- auc(ROC_multinom)
paste("Area under curve of logistic regression: ", ROC_multinom_auc)


#Multinomial Log Regression

library("nnet")
multi_model<-multinom(activity~.,data=pca_traindata)
summary(multi_model)
multi_result=predict(multi_model,test_pca)

t<-table(Y_test,multi_result)
evaluation_matrix(t)
