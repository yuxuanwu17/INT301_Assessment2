%% initialization
clear;
close all;
clc;
load som_net.mat
%% Reformat the figure format (uncomment it if you run it first time)
% figure_preprocessing

% Read the new processed file and output the data and target
imgDataPath_processed = '/Users/yuxuan/Desktop/INT301_Assessment2/ass2_processed_data/';
[X, y] = getimdata2(imgDataPath_processed);

%% transpose the X and y for easy manipulation
X = transpose(X);

%% Seperate the data format in 8 : 2
[train_idx, test_idx] = crossvalind('HoldOut', y', 0.2);
X_train = X(train_idx,:);
X_test = X(test_idx,:);
%% Define the SOM network

dimensions = [18,20]; % creat a 18X20 neuron matrix %% sqrt(sqrt(1152)*5)=13
% net = selforgmap(dimensions);
coverSteps = 10; 
initNeighbor = 80; 
topologyFcn = 'hextop'; 
distanceFcn = 'dist';

net = selforgmap(dimensions,coverSteps,initNeighbor,topologyFcn,distanceFcn);
[net,tr] = train(net,X_train');


%% extract the centers 
centers = net.IW{1,1}';
size_center = size(centers);
n_cluster = size_center(2);

%%
for i = 1:n_cluster
    dis = sqrt(sum((centers-centers(:,i)).^2)); % calculate variance for each center
    cMax = max(dis);  % select the Cmax，the longest distance between two centers
    var_square(i) = cMax;
end 

%% calculate the k weight matrix

X_train = X_train';
X_train_size = size(X_train);
X_train_num = X_train_size(2); % return the number of X_train (1920)

% centers = transpose(centers);
for i=1:1920  
    for j=1:n_cluster 
        dis1 = sqrt(sum((X_train(:,i)-centers(:,j)).^2));
        K(i,j)=exp(-dis1^2/(2*var_square(j)^2));  
    end 
end 

% for i=1:X_train_num  
%     for j=1:n_cluster 
%         dis1 = sqrt(sum((X_train(:,i)-centers(:,j)).^2));
%         n = dis1^2/(2*var_square(j)^2);
%         K(i,j)=radbas(-n);  
%     end 
% end 
%% obtain the weights
y=transpose(y);
y_train = y(train_idx,:);
y_test = y(test_idx,:);

weights=pinv(K'*K)*K'*y_train;

%% Return the training results
for i=1:X_train_num % calculate the simulated training output
    ww1=0; 
    for j=1:n_cluster 
        dist = sqrt(sum((X_train(:,i)-centers(:,j)).^2));
        curr2=weights(j)*exp(-dist^2/(2*var_square(j)^2)); 
        ww1=ww1 + curr2; 
    end 
    y_train_return(i) = ww1; 
end 

% obtain the training target
newtr = int64(y_train_return);

%% Calculate the testing results

X_test = X_test';
X_test_size = size(X_test);
X_test_num = X_test_size(2);

for i=1:X_test_num % calculate simulated testing output
    ww2=0; 
    for j=1:n_cluster 
        curr11=sqrt(sum((X_test(:,i)-centers(:,j)).^2));
        curr22=weights(j)*exp(-curr11^2/(2*var_square(j)^2)); 
        ww2=ww2 + curr22; 
    end 
    y_test_return(i) = ww2; 
end 
newtt = int64(y_test_return);

%%
n=1;
for i = newtt
    if i <=0 
        y_pred(:,n) = 25;
    elseif i>24
        y_pred(:,n) = 25;
    else
        y_pred(:,n) = i;
    end 
    n = n+1;
end 
%%
training_acc = rate(newtr,y_train')
testing_acc = rate(newtt, y_test')

%% plot confusio matrix
C = confusionmat(int64(y_pred'),int64(y_test));
confusionchart(C)
