clc
clear all
close all
outputFolder = '/Users/liyuanyuan/slice full/311H_L/XYtrain_image';
if ~isfolder(outputFolder) 
mkdir(outputFolder); 
end
outputFolder = '/Users/liyuanyuan/slice full/311H_L/XYtrain_label';
if ~isfolder(outputFolder) 
mkdir(outputFolder); 
end

outputFolder = '/Users/liyuanyuan/slice full/311H_L/XYval_image';
if ~isfolder(outputFolder) 
mkdir(outputFolder); 
end
outputFolder = '/Users/liyuanyuan/slice full/311H_L/XYval_label';
if ~isfolder(outputFolder) 
mkdir(outputFolder);  
end

PathL=dir('./XYLabel/*.png');
PathI=dir('./XYImg/*.png');

for t=1:length(PathL)
    Img_L=imread(strcat(PathL(t).folder,'/',PathL(t).name));
    Img_I=imread(strcat(PathI(t).folder,'/',PathI(t).name));
    
    if mod(t,5)==0
        imwrite(Img_I,strcat('./XYval_image/',PathI(t).name));
        imwrite(Img_L,strcat('./XYval_label/',PathL(t).name));
    else
        imwrite(Img_I,strcat('./XYtrain_image/',PathI(t).name));
        imwrite(Img_L,strcat('./XYtrain_label/',PathL(t).name));
    end
        
end
