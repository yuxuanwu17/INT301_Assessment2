%% initialization
clear;
close all;
clc;

%% Read the input image 
imgDataPath = '/Users/yuxuan/Desktop/INT301_Assessment2/ass2data/';
imgDataDir  = dir(imgDataPath);             % 遍历所有文件
for i = 1:length(imgDataDir)
    if(isequal(imgDataDir(i).name,'.')||... % 去除系统自带的两个隐文件夹
       isequal(imgDataDir(i).name,'..')||...
       isequal(imgDataDir(i).name,'.DS_Store')||...
       ~imgDataDir(i).isdir)                % 去除遍历中不是文件夹的
           continue;
    end
    imgDir = dir([imgDataPath imgDataDir(i).name '/*.jpeg']);

    
    for j =1:length(imgDir)                 % 遍历所有图片
        img = imread([imgDataPath imgDataDir(i).name '/' imgDir(j).name]);
    end
end

%%
files = dir([imgDataPath])

%%

im = imread('/Users/yuxuan/Desktop/INT301_Assessment2/ass2data/B/20130425T121214_character(4545)_4.jpeg')
size(im)