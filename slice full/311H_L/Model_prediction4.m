close all
outputFolder = ['/Users/liyuanyuan/slice full/311H_L/slices 2568bit.net311Hxy4_8bit.net211xycl_41'];
if ~isfolder(outputFolder)
    mkdir(outputFolder); 
end

net1 = load('net311Hxy4_8bit.mat');
net1 = net1.net311Hxy4_8bit;

net2 = load('net211Hxycl_41.mat');
net2 = net2.net211Hxycl_41;


imageDir = fullfile('/Users/liyuanyuan/slice full/311H_L/slices 2568bit'); 
imageDataSet = imageDatastore(imageDir);
figure;


for t = 1:length(imageDataSet.Files)
    I = readimage(imageDataSet, t);
    Img_View = repmat(I, [1, 1, 3]);

    % Prediction using the first model
    C1 = semanticseg(I, net1);
    C1 = double(C1);

    % Prediction using the second model
    C2 = semanticseg(I, net2);
    C2 = double(C2);

    [h, w] = size(C1);
    
    for i = 1:h
        for j = 1:w
            % Marks the results of the first model (red)
            if C1(i, j) == 2
                Img_View(i, j, 1) = 0; 
                Img_View(i, j, 2) = 0;   
                Img_View(i, j, 3) = 255;  
            end
            
            % Marks the results of the second model (green) and ensures that it does not override the markings of the first model 
            if C2(i, j) == 2
                Img_View(i, j, 1) = 255; 
                Img_View(i, j, 2) = 0;   
                Img_View(i, j, 3) = 0;
            end
        end
    end
    
    imshow(Img_View);
    pause(0.05);
    
    [~, name, ext] = fileparts(char(imageDataSet.Files(t))); 
    outputFileName = sprintf('%s%s', name, ext);
    imwrite(Img_View, fullfile(outputFolder, outputFileName)); 
end
