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

%% Save the processed data
save 'train_test_data.mat'
