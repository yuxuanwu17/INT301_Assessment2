%% initialization
clear;
close all;
clc;
load train_test_data.mat 
rng(1);

%%
[ W, sigma, C ] = RBF_training( X_train, y_train, 22 );
%%
 y = RBF_predict( X_test, W, sigma, C )
 %%
y_pred = vec2ind(getcls(y'))
y_test = vec2ind(y_test')
%% plot confusio matrix
C = confusionmat(int64(y_pred'),int64(y_test));
confusionchart(C)