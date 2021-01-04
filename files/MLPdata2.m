clear, close all
clc
load("logo.mat");

P = eohsamples';
T = eohlabels';

for i = 1:117
 if T(1,i) == 1 
    T(2,i) = 1; 
    T(3,i) = 0; 
    T(4,i) = 0;
    T(5,i) = 0;
    T(6,i) = 0;
    
 elseif T(1,i) == 2 
    T(2,i) = 0; 
    T(3,i) = 1;
    T(4,i) = 0;
    T(5,i) = 0;
    T(6,i) = 0;
  
 elseif T(1,i) == 3 
    T(2,i) = 0; 
    T(3,i) = 0; 
    T(4,i) = 1;
    T(5,i) = 0;
    T(6,i) = 0;
    
 elseif T(1,i) == 4 
    T(2,i) = 0;
    T(3,i) = 0;
    T(4,i) = 0;
    T(5,i) = 1;
    T(6,i) = 0;
   
 elseif T(1,i) == 5 
    T(2,i) = 0; 
    T(3,i) = 0; 
    T(4,i) = 0;
    T(5,i) = 0;
    T(6,i) = 1;
    
 end  
 
end

T = T((2:6),:);

for l=1:100
    
net = newff(P,T,[40],{'tansig','tansig'},'trainb');

net.divideParam.trainRatio = 0.8; % training set [%]
net.divideParam.valRatio = 0;  % validation set [%]
net.divideParam.testRatio = 0.2; % test set [%]

net.trainParam.epochs = 2000;
net.trainParam.lr =0.3;
net.trainParam.mc = 0.85;

[net,tr,Y,E] = train(net,P,T);

train_index = extractfield(tr,'trainInd');
test_index = extractfield(tr,'testInd');

training_acc(l) = rate(getcls(Y(:,train_index)), T(:, train_index));
testing_acc(l) = rate(getcls(Y(:,test_index)), T(:, test_index));

   if l ~= 100
   clear net
   clear tr   
   clear Y
   clear E
   clear train_index
   clear test_index
   end
   
end

train_res = mean(training_acc);
test_res = mean(testing_acc);

plotperform(tr)
view(net)
plotconfusion(T(:, test_index),Y(:,test_index))

