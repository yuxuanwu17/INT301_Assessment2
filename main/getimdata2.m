function [ data,target ] = getimdata2(path)
%GETIMDATA Summary of this function goes here
%   Detailed explanation goes here
    files = dir([path '*.jpeg']);
    data=[];
    target=[];
    
    for file = files'
        im = imread([path file.name]);
        % Normalize the data 
        im = double(im);
        im = im/255;
        
        data = [data im(:)];
        test_zero = zeros(1,24);
        if strcmp(file.name(1),'A')
            target=[target [1]];
        elseif strcmp(file.name(1),'B')
            target=[target [2]];
        elseif strcmp(file.name(1),'C')
            target=[target [3]];
        elseif strcmp(file.name(1),'D')
            target=[target [4]];
        elseif strcmp(file.name(1),'E')
            target=[target [5]];
        elseif strcmp(file.name(1),'F')
            target=[target [6]];
        elseif strcmp(file.name(1),'G')
            target=[target [7]];
        elseif strcmp(file.name(1),'H')
            target=[target [8]];
        elseif strcmp(file.name(1),'J')
            target=[target [9]];
        elseif strcmp(file.name(1),'K')
            target=[target [10]];
        elseif strcmp(file.name(1),'L')
            target=[target [11]];
        elseif strcmp(file.name(1),'M')
            target=[target [12]];
        elseif strcmp(file.name(1),'N')
            target=[target [13]];
        elseif strcmp(file.name(1),'P')
            target=[target [14]];
        elseif strcmp(file.name(1),'Q')
            target=[target [15]];
        elseif strcmp(file.name(1),'R')
            target=[target [16]];
        elseif strcmp(file.name(1),'S')
            target=[target [17]];
        elseif strcmp(file.name(1),'T')
            target=[target [18]];
        elseif strcmp(file.name(1),'U')
            target=[target [19]];
        elseif strcmp(file.name(1),'V')
            target=[target [20]];
        elseif strcmp(file.name(1),'W')
            target=[target [21]];
        elseif strcmp(file.name(1),'X')
            target=[target [22]];
        elseif strcmp(file.name(1),'Y')
            target=[target [23]];
        elseif strcmp(file.name(1),'Z')
            target=[target [24]];
        end    
    end
end

