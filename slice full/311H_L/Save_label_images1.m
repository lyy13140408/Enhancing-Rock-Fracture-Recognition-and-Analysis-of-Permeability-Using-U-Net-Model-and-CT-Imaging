clc
clear all
close all

outputFolder = '/Users/liyuanyuan/slice full/311H_L/XYImg';
if ~isfolder(outputFolder) 
mkdir(outputFolder); 
end
outputFolder = '/Users/liyuanyuan/slice full/311H_L/XYlabel';
if ~isfolder(outputFolder) 
mkdir(outputFolder); 
end

qq=load('./gTruth.mat');

figure;
for t = 1:length(qq.gTruth.DataSource.Source) 
aa = qq.gTruth.DataSource.Source{t}; 

    aa=char(aa);
    Index=find(aa=='/');
    name=aa(max(Index)+1:end);
    
    Img_View=imread(strcat('./3-1-1Hxy256.2.8bit/',name));
    bb=qq.gTruth.LabelData{t,1};
    bb=char(bb);
    Index=find(bb=='/');
    name=bb(max(Index)+1:end);
    if ~isempty(name)
        Img_mask_fin=imread(strcat('./PixelLabelData/PixelLabelData/',name));
        
    else
        Img_mask_fin=zeros(size(Img_View));
    end
    
    [h,w,~]=size(Img_View);
    
    if h>w
        zeros1=zeros(h,h-w,3);
        Img_View=[Img_View,zeros1(:,:,1)];
        Img_mask_fin=[Img_mask_fin,zeros1(:,:,1)];
    elseif h<w
        zeros1=zeros(w-h,w,3);
        Img_View=[Img_View;zeros1(:,:,1)];
        Img_mask_fin=[Img_mask_fin;zeros1(:,:,1)];
    end
    
 imwrite(Img_View,strcat('./XYImg/Img_',[num2str(t), '.png']));
imwrite(Img_mask_fin,strcat('./XYlabel/Label_',[num2str(t), '.png']));
Img_View=repmat(Img_View,[1,1,3]);

[h,w,~]=size(Img_View);
for i=1:h
for j=1:w
if Img_mask_fin(i,j)==1
Img_View(i,j,1)=0;
Img_View(i,j,2)=255;
Img_View(i,j,3)=0;
end
end
end

    
    imshow(Img_View);
    pause(0.05);
end