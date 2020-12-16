%%
clc;
clear;
%%
imgDataPath = '/Users/yuxuan/Desktop/INT301_Assessment2/ass2data/';
imgDataDir  = dir(imgDataPath);             % 遍历所有文件
savepath =  '/Users/yuxuan/Desktop/INT301_Assessment2/ass2_processed_data/';
for i = 1:length(imgDataDir)
    if(isequal(imgDataDir(i).name,'.')||... % 去除系统自带的两个隐文件夹
       isequal(imgDataDir(i).name,'..')||...
       isequal(imgDataDir(i).name,'.DS_Store')||...
       ~imgDataDir(i).isdir)                % 去除遍历中不是文件夹的
           continue;
    end
    imgDir_jpeg = dir([imgDataPath imgDataDir(i).name '/*.jpeg']);
    imgDir_jpg = dir([imgDataPath imgDataDir(i).name '/*.jpg']);
    imgDir = [imgDir_jpeg',imgDir_jpg']';

    
    for j =1:length(imgDir)                 % 遍历所有图片
        img = imread([imgDataPath imgDataDir(i).name '/' imgDir(j).name]);
        imwrite(img, [savepath,imgDataDir(i).name,num2str(j),'.jpeg'])

    end
end
