function aslData = aslAliDataFeatures(aslSrc)
% Read .mp4 files and compute the BM
%
% Input
%   aslSrc  -  path of the deep features
%
% Output
%   aslData
%
% History
%   create  -  Luca Coviello (luca.coviello@gmail.com), 11-22-2017

% src
srcs = dir([aslSrc '/*csv']);

% dimension
m = length(srcs);

% data
DPs = cell(1, m);

for i = 1 : m
    disp(i);
    
    src = srcs(i);
    frames = csvread([src.folder '/' src.name]);
    
    DPs{i} = frames.';
end

aslData = struct();
aslData.DPs = DPs;
