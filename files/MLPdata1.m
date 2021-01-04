clear, close all
clc
load("trafficsign.mat"); % load data

P = phogsamples'; 
T = phoglabels';

for i = 1:354 % transform data into several classes
 if T(1,i) == 1 
    T(2,i) = 1; 
    T(3,i) = 0; 
    T(4,i) = 0;
    T(5,i) = 0;
    T(6,i) = 0;
    T(7,i) = 0;
   
 elseif T(1,i) == 2 
    T(2,i) = 0; 
    T(3,i) = 1;
    T(4,i) = 0;
    T(5,i) = 0;
    T(6,i) = 0;
    T(7,i) = 0;
   
 elseif T(1,i) == 3 
    T(2,i) = 0; 
    T(3,i) = 0; 
    T(4,i) = 1;
    T(5,i) = 0;
    T(6,i) = 0;
    T(7,i) = 0;
 
 elseif T(1,i) == 4 
    T(2,i) = 0;
    T(3,i) = 0;
    T(4,i) = 0;
    T(5,i) = 1;
    T(6,i) = 0;
    T(7,i) = 0;
 
 elseif T(1,i) == 5 
    T(2,i) = 0; 
    T(3,i) = 0; 
    T(4,i) = 0;
    T(5,i) = 0;
    T(6,i) = 1;
    T(7,i) = 0;
 
 elseif T(1,i) == 6 
    T(2,i) = 0; 
    T(3,i) = 0;
    T(4,i) = 0;
    T(5,i) = 0;
    T(6,i) = 0;
    T(7,i) = 1;
 end   
end

T = T((2:7),:);

for l=1:100 % repeat training for 100 times
    
net = newff(P,T,[80],{'tansig','tansig'},'trainb'); % create a model

net.divideParam.trainRatio = 0.8; % training set [%]
net.divideParam.valRatio = 0;  % validation set [%]
net.divideParam.testRatio = 0.2; % test set [%]
net.trainParam.epochs = 2000; % epoch number
net.trainParam.lr =0.5; % learning rate
net.trainParam.mc = 0.8; % momentum

[net,tr,Y,E] = train(net,P,T); % train the model

train_index = extractfield(tr,'trainInd'); % create a index for train data
test_index = extractfield(tr,'testInd'); % create a index for test data

training_acc(l) = rate(getcls(Y(:,train_index)), T(:, train_index)); % calculate the training accuracy
testing_acc(l) = rate(getcls(Y(:,test_index)), T(:, test_index)); % calculate the testing accuracy

   if l ~= 100   % erase the previous records preventing from error so as to display the final run
   clear net
   clear tr
   clear Y
   clear E
   clear train_index
   clear test_index
   end
   
end

train_res = mean(training_acc);  % calculate the mean training accuracy
test_res = mean(testing_acc);  % calculate the mean testing accuracy

plotperform(tr)
view(net)
plotconfusion(T(:, test_index),Y(:,test_index))
