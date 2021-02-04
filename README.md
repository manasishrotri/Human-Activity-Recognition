# Human Activity Recognition using Smartphone data
## Goal: 
We seek to develop a human physical activity recognition model based on the UCI Machine learning [Human Activity Recognition dataset ](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Dataset information

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
> Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.
> Using its embedded accelerometer and gyroscope,3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz was captured
> The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

## Project steps:
### 1. Exploratory data analysis : 
> Checking the distribution of physical activities available in the data set
> Eliminating activities having very few data points
Number of observations for each activity 
![image](https://user-images.githubusercontent.com/60999947/106921137-b412cf00-66d9-11eb-846d-bcc1171f723b.png)

Activities per individual: 

![image](https://user-images.githubusercontent.com/60999947/106921277-ddcbf600-66d9-11eb-9b1c-72e901bf75ed.png)

> Distribution of moving vs non moving activities

![image](https://user-images.githubusercontent.com/60999947/106921490-0fdd5800-66da-11eb-8480-735a542faba2.png)

### 2. Predicting moving vs non moving activities:
> Logistic regression

Confusion Matrix\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; Test_Label\
Y Label &nbsp;&nbsp;&nbsp;&nbsp; Moving &nbsp;&nbsp;Non-Moving\
Moving &nbsp; &nbsp; &nbsp;&nbsp; 1609  &nbsp;&nbsp;      0\
Non Moving &nbsp;&nbsp;  0  &nbsp;&nbsp; 1387

> Support vector machines

Confusion Matrix \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;  Test_Label\
Y Label &nbsp;&nbsp;&nbsp;&nbsp; Moving &nbsp;&nbsp;Non-Moving\
Moving &nbsp;&nbsp;&nbsp;&nbsp;    1608   &nbsp;&nbsp;     1\
Non Moving &nbsp; 0    &nbsp;&nbsp;     1387

> Random Forest

Confusion Matrix\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;  Test_Label\
Y Label &nbsp;&nbsp;&nbsp;&nbsp;   Moving   &nbsp;&nbsp;   Non-Moving\
Moving &nbsp;&nbsp;&nbsp;&nbsp;   1609     &nbsp;&nbsp;   0\
Non Moving &nbsp;&nbsp; 0   &nbsp;&nbsp;      1387

### Feature selection:
> PCA
![image](https://user-images.githubusercontent.com/60999947/106923723-5fbd1e80-66dc-11eb-812c-faa9c745f2af.png)


### 3. Multiclass classification

> Multinomial logistic regression:

> Multiclass SVM:

