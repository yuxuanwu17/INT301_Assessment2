path = '/Users/yuxuan/Desktop/INT301_Assessment2/ass2_processed_data/';
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
    cell{i} = copy;
end 

    
for file = files'
    im = imread([path file.name]);
    data = [data im(:)];
    test_zero = zeros(1,24);
    if strcmp(file.name(1),'A')
        target=[target cell{1}];
    elseif strcmp(file.name(1),'B')
        target=[target cell{2}];
    elseif strcmp(file.name(1),'C')
        target=[target cell{3}];
    elseif strcmp(file.name(1),'D')
        target=[target cell{4}];
    elseif strcmp(file.name(1),'E')
        target=[target cell{5}];
    elseif strcmp(file.name(1),'F')
        target=[target cell{6}];
    elseif strcmp(file.name(1),'G')
        target=[target cell{7}];
    elseif strcmp(file.name(1),'H')
        target=[target cell{8}];
    elseif strcmp(file.name(1),'J')
        target=[target cell{9}];
    elseif strcmp(file.name(1),'K')
        target=[target cell{10}];
    elseif strcmp(file.name(1),'L')
        target=[target cell{11}];
    elseif strcmp(file.name(1),'M')
        target=[target cell{12}];
    elseif strcmp(file.name(1),'N')
        target=[target cell{13}];
    elseif strcmp(file.name(1),'P')
        target=[target cell{14}];
    elseif strcmp(file.name(1),'Q')
        target=[target cell{15}];
    elseif strcmp(file.name(1),'R')
        target=[target cell{16}];
    elseif strcmp(file.name(1),'S')
        target=[target cell{17}];
    elseif strcmp(file.name(1),'T')
        target=[target cell{18}];
    elseif strcmp(file.name(1),'U')
        target=[target cell{19}];
    elseif strcmp(file.name(1),'V')
        target=[target cell{20}];
    elseif strcmp(file.name(1),'W')
        target=[target cell{21}];
    elseif strcmp(file.name(1),'X')
        target=[target cell{22}];
    elseif strcmp(file.name(1),'Y')
        target=[target cell{23}];
    elseif strcmp(file.name(1),'Z')
        target=[target cell{24}];
    end    
end
