function aslData = aslAliDataRaw(aslSrc)
% Read .mp4 files and compute the BM
%
% Input
%   aslSrc  -  path of the video folder
%
% Output
%   aslData
%
% History
%   create  -  Luca Coviello (luca.coviello@gmail.com), 11-22-2017

% src
srcs = dir([aslSrc '/*mp4']);

% dimension
m = length(srcs);

% data
BMs = cell(1, m);
ratio = 0.1;

for i = 1 : m
    disp(i);
    % mask
    src = srcs(i);
    frames = aslReadVideo([src.folder '/' src.name]);
    
    bms = cell(1, length(frames));
    for j = 1:length(frames)
    	bms{j} = imresize(~magicWand(frames{j}, [1 20], [1 20], 50), ratio);
    end
    
    BMs{i} = mcat('horz', cellVec(bms));
end

aslData = struct();
aslData.BMs = BMs;
