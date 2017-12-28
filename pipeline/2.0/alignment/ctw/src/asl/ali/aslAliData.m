function aslData = aslAliData(aslSrc)
% Read .mp4 binary masked files
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
[Fs, Gs, BMs, BMFs] = cellss(1, m);

for i = 1 : m
    disp(i);
    % mask
    src = srcs(i);
    frames = aslReadVideo([src.folder '/' src.name]);
        
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
