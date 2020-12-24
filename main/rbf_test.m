%% initialization
clear;
close all;
clc;

%% Reformat the figure format (uncomment it if you run it first time)
% figure_preprocessing

%% Read the new processed file and output the data and target
imgDataPath_processed = '/Users/yuxuan/Desktop/INT301_Assessment2/ass2_processed_data/';
[A, T] = getimdata2(imgDataPath_processed);

for l=1:5
[trainInd, testInd] = crossvalind('HoldOut', T, 0.2);% randomly divide data into two parts

Training = A(:,trainInd); 
Testing = A(:,testInd);
cn = 160; 

%%
[cluster,train6]=kmeans(Training',cn,'Replicates',5); % calculate the center coordinates by k means
centers = train6';
%%
% how to do RBF using k means 

for i=1:cn

    dis = sqrt(sum((centers-centers(:,i)).^2)); % calculate variance for each center
    curr=max(dis); 
    delta(i) = curr;
end
%%

for i=1:1920  % calculate the k weight matrix
    for j=1:cn 
        dis1 = sqrt(sum((Training(:,i)-centers(:,j)).^2));
        K(i,j)=exp(-dis1^2/(2*delta(j)^2));  
    end 
end 

%%
tforT = T(:,trainInd);
weights=pinv(K'*K)*K'*tforT'; % calculate the weight by matrix transformation

%%
for i=1:1920 % calculate the simulated training output
    ww1=0; 
    for j=1:cn 
        curr1=sqrt(sum((Training(:,i)-centers(:,j)).^2));
        curr2=weights(j)*exp(-curr1^2/(2*delta(j)^2)); 
        ww1=ww1 + curr2; 
    end 
    y_train(i) = ww1; 
end 

newtr = int64(y_train); % transform output into integer

% training_acc(l) = rate(newtr, T(:,trainInd))

for i=1:480 % calculate simulated testing output
    ww2=0; 
    for j=1:cn 
        curr11=sqrt(sum((Testing(:,i)-centers(:,j)).^2));
        curr22=weights(j)*exp(-curr11^2/(2*delta(j)^2)); 
        ww2=ww2 + curr22; 
    end 
    y_test(i) = ww2; 
end 

newtt = int64(y_test);
%%
training_acc = rate(newtr, T(:,trainInd))
testing_acc = rate(newtt, T(:,testInd))
%
testing_acc(l) = rate(newtt, T(:,testInd));

  if l~=100
     clear ww1
     clear ww2
  end
end

% training_res = mean(training_acc);
% testing_res = mean(testing_acc);

%  for e = 1:71 % transform simulated output into the form of several classes
%    
%       if newtt(:,e) == 1
%       test_res(:,e) = [1,0,0,0,0,0]';
%     
%       elseif newtt(:,e) == 2
%       test_res(:,e) = [0,1,0,0,0,0]';
%     
%       elseif newtt(:,e) == 3
%       test_res(:,e) = [0,0,1,0,0,0]';
%     
%       elseif newtt(:,e) == 4
%       test_res(:,e) = [0,0,0,1,0,0]';
%     
%       elseif newtt(:,e) == 5
%       test_res(:,e) = [0,0,0,0,1,0]';
%     
%       elseif newtt(:,e) == 6
%       test_res(:,e) = [0,0,0,0,0,1]';
%       
%       else
%       test_res(:,e) = [0,0,0,0,0,0]';
%       end      
%  end     
%  
%  target = T';
%  
%  for r = 1:354
%    
%       if target(:,r) == 1
%       t_res(:,r) = [1,0,0,0,0,0]';
%     
%       elseif target(:,r) == 2
%       t_res(:,r) = [0,1,0,0,0,0]';
%     
%       elseif target(:,r) == 3
%       t_res(:,r) = [0,0,1,0,0,0]';
%     
%       elseif target(:,r) == 4
%       t_res(:,r) = [0,0,0,1,0,0]';
%     
%       elseif target(:,r) == 5
%       t_res(:,r) = [0,0,0,0,1,0]';
%     
%       elseif target(:,r) == 6
%       t_res(:,r) = [0,0,0,0,0,1]';
%       
%       end      
%  end     
%  %%
%  plotconfusion(t_res(:, testInd),test_res)