%% initialization
clear;
close all;
clc;
load train_test_data.mat 
rng(1);

%%
[ W, sigma, C ] = RBF_training_kmeans( X_train, y_train, 360 );

%% Return the predicted results of X_train

y_train_pred = RBF_predict(X_train, W, sigma, C);

%% Return the predicted results of X_test

y_test_pred = RBF_predict(X_test, W, sigma, C);

%% Calculate the training and testing accuracy

training_acc = rate(getcls(y_train_pred'), y_train')
testing_acc = rate(getcls(y_test_pred'), y_test')

%%
y_pred = vec2ind(getcls(y_test_pred'));
y_test = vec2ind(y_test');
C_rbf_kmeans = confusionmat(int64(y_pred'),int64(y_test));
confusionchart(C_rbf_kmeans)

save C_rbf_kmeans.mat

