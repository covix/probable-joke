function align_deep_pca_gctw_class_train(inputFolder, class, outputFolder, ctwFolder)
% TODO desc
%
% History
%   create  -  Luca Coviello (luca.coviello@gmail.com), 01-16-2018

%% add libraries path
footpath = cd;
disp("Adding to path: ");
disp(genpath([footpath '/' ctwFolder '/ctw/src']));
addpath(genpath([footpath '/' ctwFolder '/ctw/src']));
addpath(genpath([footpath '/' ctwFolder '/ctw/lib']));

%% algorithm parameter
parCca = st('d', 0.95, 'lams', .1); % CCA: reduce dimension to keep at least 0.95 energy
parGN = st('nItMa', 2, 'inp', 'linear'); % Gauss-Newton: 2 iterations to update the weight in GTW,
parGtw = st('nItMa', 100);

%% data
aslData = aslAliDataFeatures(inputFolder);
X0s = aslData.DPs;
Xs = pcas(X0s, st('d', min(cellDim(X0s, 1)), 'cat', 'n'));

%% monotonic basis
ns = cellDim(Xs, 2);
l = round(max(ns) * 1.1);
bas = baTems(l, ns, 'pol', [5 .5], 'tan', [5 1 1]); % 2 polynomial and 3 tangent functions

%% utw (initialization)
aliUtw = utw(Xs, bas, []);

%% gctw
aliGtw = gtw(Xs, bas, aliUtw, [], parGtw, parCca, parGN);

%% save indexes
P = aliGtw.P;
csvwrite(strcat(outputFolder, '/ali_gctw_deep_', class, '_P.csv'), P)
