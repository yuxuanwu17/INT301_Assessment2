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

%%
% target_ts;
sample1 = target_ts(:,1)
