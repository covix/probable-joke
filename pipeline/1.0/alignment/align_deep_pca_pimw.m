function align_deep_pca_pimw(inputFolder, outputFolder, ctwFolder)
% TODO desc
%
% History
%   create  -  Luca Coviello (luca.coviello@gmail.com), 11-22-2017

%% add libraries path
footpath = cd;
addpath(genpath([footpath '/' ctwFolder '/ctw/src']));
addpath(genpath([footpath '/' ctwFolder '/ctw/lib']));

%% algorithm parameter
parPimw = st('lA', 1, 'lB', 1); % IMW: regularization weight

%% data
aslData = aslAliDataFeatures(inputFolder);
X0s = aslData.DPs;
Xs = pcas(X0s, st('d', min(cellDim(X0s, 1)), 'cat', 'n'));

%% utw (initialization)
aliUtw = utw(Xs, [], []);

%% pimw
aliPimw = pimw(Xs, aliUtw, [], parPimw, []);

%% save indexes
P = aliPimw.P;
csvwrite(strcat(outputFolder, '/ali_pimw_deep_all_P.csv'), P)
