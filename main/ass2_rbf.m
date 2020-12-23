%% initialization
clear;
close all;
clc;

%% Reformat the figure format (uncomment it if you run it first time)
% figure_preprocessing

%% Read the new processed file and output the data and target
imgDataPath_processed = '/Users/yuxuan/Desktop/INT301_Assessment2/ass2_processed_data/';
[X, y] = getimdata2(imgDataPath_processed);

%% transpose the X and y for easy manipulation
X = transpose(X);
y = transpose(y);

%% Seperate the data format in 8 : 2
[train_idx, test_idx] = crossvalind('HoldOut', y, 0.2);
X_train = X(train_idx,:);
X_test = X(test_idx,:);
y_train = ind2vec(y(train_idx,:)')';
y_test = ind2vec(y(test_idx,:)')';

%% Use parallel computing
stream = RandStream('mlfg6331_64');  % Random number stream
options = statset('UseParallel',1,'UseSubstreams',1,...
    'Streams',stream);

%% Kmeans analysis 
n_cluster = 160;
[idx, C] = kmeans(X_train,n_cluster,'Options',options,'MaxIter',10000,...
    'Display','final','Replicates',5);

centers = C';
%% Calculate the variance of 

for i = 1:n_cluster
dis_square = sum((centers-centers(:,i)).^2); % calculate variance for each center
    curr = max(dis_square); 
    var_square(i) = curr/(2*n_cluster);
end 

%%
X_train = X_train';
X_train_size = size(X_train);
X_train_num = X_train_size(2);
for i=1:X_train_num  % calculate the k weight matrix
    for j=1:n_cluster 
        dis1 = sqrt(sum((X_train(:,i)-centers(:,j)).^2));
        K(i,j)=exp(-dis1^2/(2*var_square(j)));  
    end 
end 

%% update the weights
weights=pinv(K'*K)*K'*y_train;

%% Return the y value
for i=1:1920 % calculate the simulated training output
    ww1=0; 
    for j=1:n_cluster 
        dis1 = sqrt(sum((X_train(:,i)-centers(:,j)).^2));
        curr2=weights(j)*exp(-dis1^2/(2*var_square(j))); 
        ww1=ww1 + curr2; 
    end 
    y_train_return(i) = ww1; 
end 

%% Calculate the Gaussian basis function
% n = 0;
% X_train_size = size(X_train);
% X_train_num = X_train_size(1);
% for j = 1:X_train_num
%     for i=1:n_cluster
%         dist = (X_train(j,:)'-centers(i,:)).^2;
%         rbf_up = exp(-dist);
%         rbf_down = var_square(i)*2;
%         rbf_function = rbf_up/rbf_down;
%     end 
% end 
% 
%%
% K = rbf_function;
% psedu = inv(corr);
% weights=pinv(K'*K)*K'*y_train;
%%
% tforT = y_train;
% K = rbf_function;
% corr = K'*K;
% psedu = pinv(corr)

% 
%% Train the network

%% Simulate the test value
% y_predict = sim(net,X_test);
% 
% %% transform to the vector format
% y_predict_vec = vec2ind(y_predict);
% y_test_vec = vec2ind(y_test');
% 
% %% Confusion mareix 
% C = confusionmat(y_predict_vec,y_test_vec);
% confusionchart(C)
