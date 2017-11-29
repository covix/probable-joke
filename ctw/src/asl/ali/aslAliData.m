function aslData = aslAliData(aslSrc)
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

if m < 2
    ME = MException('MYFUN:BadFolder', ...
                    'Number of files is < 2 in %s', aslSrc);
    throw(ME)
end

% data

[Fs, Gs, BMs, BMFs]= cellss(1, m);

for i = 1 : m
    % mask
    src = srcs(i);
    frames = aslReadVideo([src.folder '/' src.name]);
    
    [gs, bms] = cellss(1, length(frames));
    for j = 1:length(frames)
    	bms{j} = double(~magicWand(frames{j}, [1 20], [1 20], 50));
        gs{j} = rgb2gray(double(frames{j}));
    end
    
    Fs{i} = frames;
    Gs{i} = mcat('horz', cellVec(gs));
    BMFs{i} = bms;
    BMs{i} = mcat('horz', cellVec(bms));
end

aslData = struct();
aslData.Fs = Fs;
aslData.Gs = Gs;
aslData.BMFs = BMFs;
aslData.BMs = BMs;


