%% Clear Variables, Close Current Figures
tic
clc;
clear all;
close all;

%% Set up video Category set

% create video data stores for training and testing videos

% for Traing data
rootFolder1 = fullfile('trainingSet');
trainingSet = imageDatastore(fullfile(rootFolder1),'IncludeSubfolders',1,'FileExtensions','.avi','LabelSource','foldernames') %Datastore for image data
tbl_tr      = countEachLabel(trainingSet)
label_tr    = cellstr([tbl_tr.Label])% cell array : so need to convert to character vector
count_train = [tbl_tr.Count];

% for testing data
rootFolder2 = fullfile('testingSet');
testingSet  = imageDatastore(fullfile(rootFolder2),'IncludeSubfolders',1,'FileExtensions','.avi','LabelSource','foldernames') %Datastore for image data
tbl_te      = countEachLabel(testingSet)
label_te    = cellstr([tbl_te.Label])% cell array : so need to convert to character vector
count_test  = [tbl_te.Count];
%% Find the Minimum frames of the training set

% for training
minFrames_tr = Inf;
for i = 1:count_train
    vidPath_tr = char(trainingSet.Files(i));
    tr = VideoReader(vidPath_tr);
    n = tr.numberofFrames;
    if (n<minFrames_tr)
        minFrames_tr = n;
    end
end

minFrames_tr

% for testing
minFrames_te = Inf;
for i = 1:count_test
    vidPath_te = char(testingSet.Files(i));
    te = VideoReader(vidPath_te);
    n = te.numberofFrames;
    if (n<minFrames_te)
        minFrames_te = n;
    end
end
minFrames_te