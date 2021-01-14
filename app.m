%% Clear Variables, Close Current Figures
tic
clc;
clear all;
close all;
diary

%% Set up video Category set

% create video data stores for training and testing videos

% for Traing data
rootFolder1 = fullfile('train');
trainingSet = fileDatastore(fullfile(rootFolder1),'IncludeSubfolders',true,'ReadFcn',@load,'FileExtensions','.txt')

% for testing data
rootFolder2 = fullfile('test');
testingSet  = fileDatastore(fullfile(rootFolder2),'IncludeSubfolders',true,'ReadFcn',@load,'FileExtensions','.txt') 


%% Codebook Construction

noLabel = 6;
count_train = [64 63 64 64 64 64];
codebook = codebookConstruction(trainingSet,noLabel,count_train);
save('codebook.txt','codebook','-ASCII');

%% Feature representation
count_test = [36 36 36 36 36 36];
[fetVector1,fetVector2] = featureRep(testingSet,noLabel,count_train,count_test);
save('fetVectorTrain.txt','fetVector1','-ASCII');
save('fetVectorTest.txt','fetVector2','-ASCII');

%% Classification

[rate,ind] = SVMclassify(noLabel);
disp('rate='); disp(rate);

t1 = toc;
timeString = datestr(t1/(24*60*60), 'DD:HH:MM:SS.FFF')

% rate=
%     0.6806
% 
% 
% timeString =
% 
%     '00:02:35:31.206'
%%

