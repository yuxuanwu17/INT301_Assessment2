function [ W, sigma, C ] = RBF_training_som( data, label,net)

    % Return the center of som net
    C = net.IW{1,1};
    % Calculate the variance (sigma) of RBF kernel
    
    size_center = size(C);
    n_center_vec = size_center(1);
    
    for i = 1:n_center_vec
        dis = sqrt(sum((C-C(i,:)).^2)); % calculate variance for each center
%         cMax = max(dis);  % select the Cmax，the longest distance between two centers
        cMax = mean(dis);  % select the Cmax，the longest distance between two centers
        sigma(i,:) = cMax;
    end 

    % calculate the k weight matrix

    for i=1:n_center_vec
        r = bsxfun(@minus, data, C(i,:)).^2;
        r = sqrt(sum(r,2));
        k_mat(:,i) = exp((-r.^2)/(2*sigma(i)^2));
    end
    %% Obtain the weights by pseudo inverse

    W = pinv(k_mat'*k_mat)*k_mat'*label;
