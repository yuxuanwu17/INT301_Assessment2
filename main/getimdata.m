function [ data,target ] = getimdata(path)
%GETIMDATA Summary of this function goes here
%   Detailed explanation goes here
    files = dir([path '*.jpeg']);
    data=[];
    target=[];
    
%   Generated the cell and zero matrix to store
    store = cell(1,24);
    tst_zero = zeros(1,24);
    
%   Fill the zeros matrix 
    for i = 1:24
        copy = tst_zero;
        copy(1,i) = 1;
        store{i} = copy;
    end 

    
    for file = files'
        im = imread([path file.name]);
        data = [data im(:)];
        test_zero = zeros(1,24);
        if strcmp(file.name(1),'A')
            target=[target store{1}];
        elseif strcmp(file.name(1),'B')
            target=[target store{2}];
        elseif strcmp(file.name(1),'C')
            target=[target store{3}];
        elseif strcmp(file.name(1),'D')
            target=[target store{4}];
        elseif strcmp(file.name(1),'E')
            target=[target store{5}];
        elseif strcmp(file.name(1),'F')
            target=[target store{6}];
        elseif strcmp(file.name(1),'G')
            target=[target store{7}];
        elseif strcmp(file.name(1),'H')
            target=[target store{8}];
        elseif strcmp(file.name(1),'J')
            target=[target store{9}];
        elseif strcmp(file.name(1),'K')
            target=[target store{10}];
        elseif strcmp(file.name(1),'L')
            target=[target store{11}];
        elseif strcmp(file.name(1),'M')
            target=[target store{12}];
        elseif strcmp(file.name(1),'N')
            target=[target store{13}];
        elseif strcmp(file.name(1),'P')
            target=[target store{14}];
        elseif strcmp(file.name(1),'Q')
            target=[target store{15}];
        elseif strcmp(file.name(1),'R')
            target=[target store{16}];
        elseif strcmp(file.name(1),'S')
            target=[target store{17}];
        elseif strcmp(file.name(1),'T')
            target=[target store{18}];
        elseif strcmp(file.name(1),'U')
            target=[target store{19}];
        elseif strcmp(file.name(1),'V')
            target=[target store{20}];
        elseif strcmp(file.name(1),'W')
            target=[target store{21}];
        elseif strcmp(file.name(1),'X')
            target=[target store{22}];
        elseif strcmp(file.name(1),'Y')
            target=[target store{23}];
        elseif strcmp(file.name(1),'Z')
            target=[target store{24}];
        end    
    end
end

