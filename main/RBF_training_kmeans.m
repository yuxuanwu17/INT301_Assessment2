function [ W, sigma, C ] = RBF_training_kmeans( data, label, n_center_vec )

    % Kmeans analysis to find the center location
    % the higher number of clusters, the higher performance, but overfitting would come
    [idx, C] = kmeans(data,n_center_vec);

    % Calculate the variance (sigma) of RBF kernel

    for i = 1:n_center_vec
        dis = sqrt(sum((C-C(i,:)).^2)); % calculate variance for each center
        cMax = max(dis);  % select the Cmax，the longest distance between two centers
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
