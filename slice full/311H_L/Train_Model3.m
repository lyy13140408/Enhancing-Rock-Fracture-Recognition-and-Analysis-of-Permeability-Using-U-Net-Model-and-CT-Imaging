 clc,
clear all
close all

rootDir = './'; % Root directory where data is stored
imageDir = fullfile('XYtrain_image'); % Path to image data
labelDir = fullfile('XYtrain_label'); % Path where the tag data is stored
% The image value of the tag and its corresponding category
labelIDs = [0,1];
classNames = ["background","zone"]; 

% Create training dataset
imageDataSet = imageDatastore(imageDir);
labelDataSet = pixelLabelDatastore(labelDir,classNames,labelIDs);
trainingDataSet = pixelLabelImageDatastore(imageDataSet,labelDataSet);

% Create validation dataset as above
imageDir = fullfile('XYval_image');
labelDir = fullfile('XYval_label');
imageDataSet = imageDatastore(imageDir);
labelDataSet = pixelLabelDatastore(labelDir,classNames,labelIDs);

% Create validation dataset
valDataSet = pixelLabelImageDatastore(imageDataSet,labelDataSet);


imageSize = [256,256,1]; 
numClasses = 2; 
encoderDepth = 2; 


[netLayers,outsize] = unetLayers(imageSize,numClasses,'EncoderDepth',encoderDepth); % UNet modelling


options = trainingOptions('sgdm', ...                    % Define the optimiser           
                          'InitialLearnRate',1e-4, ...    % Define the initial learning rate
                          'Plots','training-progress',...  % Plotting training curves in real time
                          'MaxEpochs',30, ...             % Iteration rounds
                          'MiniBatchSize',8,...          % Batch size
                          'VerboseFrequency',20,...       % Frequency of accuracy assessments
                          'ExecutionEnvironment', 'auto',...  % Running environment ‘Shuffle’, ‘every-epoch’,... Sample input order randomisation
                          'ValidationData',valDataSet,...      % Validation dataset
                          'ValidationFrequency',50,...        % Verification accuracy assessment frequency
                          'WorkerLoad',4);           % Save model intermediate results
% Training models
net311Hxy4_8bit = trainNetwork(trainingDataSet, netLayers, options);      % Models start training
save net311Hxy4_8bit;
figure
plot(netLayers)
