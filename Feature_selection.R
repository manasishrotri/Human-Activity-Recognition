data <- read.csv(file="Final_x_train.csv", header=TRUE, sep=",")

ncol(data)
nrow(data)
head(data)
#data$fold<-sample(rep(1:10,length=nrow(data)),replace=T)
set.seed(1234)
subset=sample(nrow(data),nrow(data)*0.7)
train = data[subset,]
test = data[-subset,]


lm_fit<-lm(data$activity~.,data=data)
anova(lm_fit)

#######################Feature Selection####################
library(glmnet)
tr_matrix <- model.matrix(activity ~ ., data = train)
te_matrix <- model.matrix(activity ~ ., data = test)



###LASSO
    myAlpha=1
    myLambda = 10^(seq(3,-1,length=100))
    #https://web.stanford.edu/~hastie/glmnet/glmnet_alpha.html
    glm_lasso = glmnet(tr_matrix,train$activity ,alpha=myAlpha,lambda=myLambda)
    print(glm_lasso)
    plot(glm_lasso,xvar = "lambda",label=TRUE)
    plot(glm_lasso,xvar = "dev",label=TRUE)
    
    #Crossvalidation
    cv.lasso = cv.glmnet(tr_matrix,train$activity , type.measure = "mse",nfolds = 10,alpha=myAlpha,lambda=myLambda)
    plot(cv.lasso)
    
    lamda_lasso <- cv.lasso$lambda.min
    print(lamda_lasso)
    #predict
    pred3 <-predict(cv.lasso, s = lamda_lasso, newx = te_matrix)
    mean((pred3 - test$activity)^2)
    
    coef_lasso=coef(cv.lasso,s = "lambda.min")
    inds<-which(coef_lasso!=0)
    variables<-row.names(coef_lasso)[inds]
    variables=variables[-1]
    print(variables)
    #newx <- model.matrix(activity ~ ., data = test[,colnames(test)%in%c(variables,'activity')])
    
    #new_pred <- predict(cv.lasso,newx=newx , s = mylamba2,type="response")
    
###RIDGE
    myAlpha=0
    myLambda = 10^(seq(4,-1,length=100))
    
    glm_ridge = glmnet(tr_matrix,train$activity ,alpha=myAlpha,lambda=myLambda)
    print(glm_ridge)
    plot(glm_ridge,xvar = "lambda",label=TRUE)
    plot(glm_ridge,xvar = "dev",label=TRUE)

    #Crossvalidation
    cv.ridge= cv.glmnet(tr_matrix, train$activity,type.measure = "mse",nfold=10,alpha=myAlpha,lambda=myLambda,thresh = 1e-08)
    plot(cv.ridge)

    mylamba_ridge <- cv.ridge$lambda.min
    print(mylamba_ridge)
    #predict
    pred_ridge <-predict(cv.ridge, s = mylamba_ridge, newx = te_matrix)
    mean((pred_ridge - test$activity)^2)
    
    coef_ridge=coef(cv.ridge,s = "lambda.min")
    #inds<-which(coef_lasso>1e-2&coef_lasso1e-2)
    #variables<-row.names(coef_lasso)[inds]
    #variables=variables[-1]
    print(coef_ridge)
    

###PCA
    #https://www.analyticsvidhya.com/blog/2016/03/practical-guide-principal-component-analysis-python/
    prin_comp <- prcomp(train, scale. = T)
    names(prin_comp)
    #outputs the mean of variables
    prin_comp$center
    #outputs the standard deviation of variables
    prin_comp$scale
    #The rotation measure provides the principal component loading. Each column of rotation matrix contains the principal component loading vector. This is the most important measure we should be interested in.
    dim(prin_comp$rotation)
    prin_comp$rotation[1:5,1:4]
    
    dim(prin_comp$x)
    
    biplot(prin_comp, scale = 0)
    
    
    std_dev <- prin_comp$sdev
    pr_var <- std_dev^2
    #check variance of first 10 components
    pr_var[1:10]
    
    #We aim to find the components which explain the maximum variance. This is because, we want to retain as much information as possible using these components. So, higher is the explained variance, higher will be the information contained in those components.
    #To compute the proportion of variance explained by each component, we simply divide the variance by sum of total variance. This results in:
    #proportion of variance explained
    
    prop_varex <- pr_var/sum(pr_var)
    prop_varex[1:20]
    
    
    #scree plot
    plot(prop_varex[1:100], xlab = "Principal Component",
         ylab = "Proportion of Variance Explained",
         type = "b")
    
    plot(cumsum(prop_varex[1:100]), xlab = "Principal Component",
         ylab = "Proportion of Variance Explained",
         type = "b")
    abline(h=0.90,col="Red")
    abline(v=60,col="red")