
% 
% %% Read the data (This time we used the imds format to handle the figure)
% F = '/Users/yuxuan/Desktop/INT301_Assessment2/ass2data'
% imds = imageDatastore(F,'IncludeSubfolders',true,'LabelSource','foldernames');
% 
% %% Have a view of the inside components
% % Return the number of labels and corresponding counts
% labelCount = countEachLabel(imds);
% % labelCount
% 
% %% Divide the dataset into two parts (8:2)
% 
% numTrainFiles = 80;
% [imdsTrain, imdsTest] = splitEachLabel(imds, numTrainFiles,'randomize');
% 
% %% 
% 
% data = []
% files = imdsTrain.Files;
% x = 0
% for file = files'
%     im = imread(file{1});
%     data = [data im];
% end 
% %%
% X_train = reshape(data,48,24,1920);
% X_train = double(X_train);
% y_train = imdsTrain.Labels;
% y_train = double(y_train);
% 
% %%
% % imshow(X_train)
% %%
% data = []
% files = imdsTest.Files;
% x = 0
% for file = files'
%     im = imread(file{1});
%     data = [data im];
% end 
% %%
% X_test = reshape(data,48,24,480);
% X_test = double(X_test);
% y_test = imdsTest.Labels;
% y_test = double(y_test);
% 
% %%
% net = newrb(X_train,y_train,0.2,1,20,1);
%%
clc;
clear;
close all;


%%
imgDataPath_processed = '/Users/yuxuan/Desktop/INT301_Assessment2/ass2_processed_data/';
[X, y] = getimdata(imgDataPath_processed);

%%
X_trans = transpose(X);
y_trans = transpose(y);
%% split data into 8:2

rng(1)
[ndata, D] = size(X_trans);        %ndata，D: feature dimension
R = randperm(ndata);         %1到n randomize the number as index
num_test = floor(ndata*0.2);
X_test = X_trans(R(1:num_test),:);  
R(1:num_test) = [];
X_train = X_trans(R,:);          
num_training = size(X_train,1);

y_test = y_trans(R(1:num_test),:);
y_train = y_trans(R,:);

%% Assign the new value
data_tr = X_train';
target_tr = y_train';
data_ts = X_test';
target_ts = y_test';

%% Train the network
net = newrb(data_tr,target_tr);
% net = newrb(data_tr,target_tr,0.2,1,20,25);

%% Simulate the test value
y_predict = sim(net,data_ts);

%% transform to the vector format
y_predict_vec = vec2ind(y_predict);
y_test_vec = vec2ind(y_test');

%% Confusion mareix 
C = confusionmat(y_predict_vec,y_test_vec);
confusionchart(C)
