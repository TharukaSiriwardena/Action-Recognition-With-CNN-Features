function dscr= STIP(VideoPath,Frames)
% [filename pathname] = uigetfile({'*.avi'},'Select A Video File'); %Open standard dialog box for retrieving files
% obj = VideoReader([pathname,filename]);

obj = VideoReader(VideoPath);
%noFrames = obj.NumberOfFrames
noFrames = Frames;

%figure;
for i=1:noFrames
    img{i} = read(obj,i);
    img{i} = rgb2gray(img{i});
    points = detectHarrisFeatures(img{i});
    %[features ,validPoints] = extractHOGFeatures(img{i},points);
    [features ,validPoints] = extractFeatures(img{i},points);
    im_features{i} = features.Features;
 
%     imshow(img{i}); hold on
%     plot(validPoints);
    
end

dscr = vertcat(im_features{:});%Concatenate arrays vertically
dscr = double(dscr);
[idx,dscr] = kmeans(dscr,200,'MaxIter',1000);  % k cluster centroid locations in the k-by-p matrix C. , idx is cluster indices of each observation, (k-total*1) vector

