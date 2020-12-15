%% initialization
clear;
close all;
clc;

%% Read and normalized the input image and rewrite to the new one file 
% imgDataPath = '/Users/yuxuan/Desktop/INT301_Assessment2/ass2data/';
% imgDataDir  = dir(imgDataPath);             % 遍历所有文件
% savepath =  '/Users/yuxuan/Desktop/INT301_Assessment2/ass2_processed_data/'
% for i = 1:length(imgDataDir)
%     if(isequal(imgDataDir(i).name,'.')||... % 去除系统自带的两个隐文件夹
%        isequal(imgDataDir(i).name,'..')||...
%        isequal(imgDataDir(i).name,'.DS_Store')||...
%        ~imgDataDir(i).isdir)                % 去除遍历中不是文件夹的
%            continue;
%     end
%     imgDir = dir([imgDataPath imgDataDir(i).name '/*.jpeg']);
% 
%     
%     for j =1:length(imgDir)                 % 遍历所有图片
%         img = imread([imgDataPath imgDataDir(i).name '/' imgDir(j).name]);
%         imwrite(img, [savepath,imgDataDir(i).name,num2str(j),'.jpeg'])
% %         img_processed = double(img);
% %         img_normalized = img_processed/255;
% %         imwrite(img_normalized, [savepath,imgDataDir(i).name,num2str(j),'.jpeg'])
%     end
% end

%% Read the new processed file and output the data and target
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

%% train NN

% seperate the value 
% neurons = [8,16,32];
% lr_rate = 0.1;
% mc_rate = 0.9;
% lr_rate = [0.1,0.4,0.7];
% mc_rate = [0.6,0.75,0.9];
% perf_store = [];
neurons = 32;
lr_rate = 0.1;
mc_rate = 0.9;
epochs = 1000;

nhidden = neurons; %number of hidden layers
net=newff(data_tr,target_tr,[nhidden,nhidden,nhidden],{'tansig','tansig','tansig','purelin'},'traingd');
% set the hyperparameter (epochs, learning rate)
net.trainParam.epochs = epochs; %number of training epochs
net.trainParam.lr = lr_rate;
net.trainParam.mc = mc_rate;
% train a neural network
[net,tr,Y,E] = train(net,data_tr,target_tr);
% predict the value
y_predict = sim(net,data_ts);
perf = perform(net, y_test', y_predict);
fprintf('value of mse in neuron %d, learning rate %2.1f, momentum is %3.1f,is %6.4f\n ',neurons,lr_rate,mc_rate,perf);

%% test the performance
training_acc = rate(getcls(Y), target_tr)
testing_acc = rate(getcls(y_predict), target_ts)

%% transform to the vector format
y_predict_vec = vec2ind(y_predict);
y_test_vec = vec2ind(y_test');

%% Confusion mareix 
C = confusionmat(y_predict_vec,y_test_vec);
confusionchart(C)