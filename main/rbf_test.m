%% initialization
clear;
close all;
clc;
load train_test_data.mat 
rng(1);


%% Kmeans analysis to find the center location
n_cluster = 360; % the higher number of clusters, the higher performance, but overfitting would come
[idx, C] = kmeans(X_train,n_cluster);

%% Calculate the variance (sigma) of RBF kernel

for i = 1:n_cluster
    dis = sqrt(sum((C-C(i,:)).^2)); % calculate variance for each center
    cMax = max(dis);  % select the Cmax，the longest distance between two centers
    sigma(i,:) = cMax;
end 


%% calculate the k weight matrix

for i=1:n_cluster
    r = bsxfun(@minus, X_train, C(i,:)).^2;
    r = sqrt(sum(r,2));
    k_mat(:,i) = exp((-r.^2)/(2*sigma(i)^2));
end
%% Obtain the weights by pseudo inverse

weights = pinv(k_mat'*k_mat)*k_mat'*y_train;

%% Return the predicted results of X_train
n_data = size(X_train, 1);
n_center_vec = size(C, 1);
if numel(sigma) == 1
   sigma = repmat(sigma, n_center_vec, 1);
end

% kernel matrix
k_mat = zeros(n_data, n_center_vec);
for i=1:n_center_vec
    r = bsxfun(@minus, X_train, C(i,:)).^2;
    r = sqrt(sum(r,2));
    k_mat(:,i) = exp((-r.^2)/(2*sigma(i)^2));
end

% kernel matrix
k_mat = zeros(n_data, n_center_vec);
for i=1:n_center_vec
    r = bsxfun(@minus, X_train, C(i,:)).^2;
    r = sqrt(sum(r,2));
    k_mat(:,i) = exp((-r.^2)/(2*sigma(i)^2));
end
y_train_pred = k_mat*weights;
%% Return the predicted results of X_test

n_data = size(X_test, 1);
n_center_vec = size(C, 1);
if numel(sigma) == 1
   sigma = repmat(sigma, n_center_vec, 1);
end

% kernel matrix
k_mat = zeros(n_data, n_center_vec);
for i=1:n_center_vec
    r = bsxfun(@minus, X_test, C(i,:)).^2;
    r = sqrt(sum(r,2));
    k_mat(:,i) = exp((-r.^2)/(2*sigma(i)^2));
end

y_test_pred = k_mat*weights;

%%
training_acc = rate(getcls(y_train_pred'), y_train')
testing_acc = rate(getcls(y_test_pred'), y_test')


%%
y_pred = vec2ind(getcls(y_test_pred'));
y_test = vec2ind(y_test');
C = confusionmat(int64(y_pred'),int64(y_test));
confusionchart(C)


