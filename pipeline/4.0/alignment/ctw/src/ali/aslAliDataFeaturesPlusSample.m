function aslData = aslAliDataFeaturesPlusSample(aslSrc, filepath)
%
% Input
%   aslSrc      -  path of the deep features
%   filepath    -  path of the additional sample
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
DPs = cell(1, m + 1);

for i = 1 : m
    disp(i);
    
    src = srcs(i);
    frames = csvread([src.folder '/' src.name]);
    
    DPs{i} = frames.';
end

sample = csvread(filepath);
DPs{m} = sample.';

aslData = struct();
aslData.DPs = DPs;
