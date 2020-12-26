%%
clc;
clear;
%%
imgDataPath = '/Users/yuxuan/Desktop/INT301_Assessment2/ass2data/';
imgDataDir  = dir(imgDataPath);             % Iterate through all the files
savepath =  '/Users/yuxuan/Desktop/INT301_Assessment2/ass2_processed_data/';
for i = 1:length(imgDataDir)
    if(isequal(imgDataDir(i).name,'.')||... % Remove two default hidden file folders 
       isequal(imgDataDir(i).name,'..')||...
       isequal(imgDataDir(i).name,'.DS_Store')||...
       ~imgDataDir(i).isdir)                % Remove the folder not belong to this iteration
           continue;
    end
    imgDir_jpeg = dir([imgDataPath imgDataDir(i).name '/*.jpeg']);
    imgDir_jpg = dir([imgDataPath imgDataDir(i).name '/*.jpg']);
    imgDir = [imgDir_jpeg',imgDir_jpg']';

    
    for j =1:length(imgDir)                 % Iterate all the figures
        img = imread([imgDataPath imgDataDir(i).name '/' imgDir(j).name]);
        imwrite(img, [savepath,imgDataDir(i).name,num2str(j),'.jpeg'])

    end
end
