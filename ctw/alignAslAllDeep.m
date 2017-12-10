% TODO desc
%
% History
%   create  -  Luca Coviello (luca.coviello@gmail.com), 11-22-2017

clear variables;
addPath

%% algorithm parameter
parCca = st('d', 3, 'lams', .1); % CCA: reduce dimension to keep at least 0.95 energy
parGN = st('nItMa', 2, 'inp', 'linear'); % Gauss-Newton: 2 iterations to update the weight in GTW, 
parGtw = st('nItMa', 20);


%% src
% aslSrc = '/Users/covix/Projects/probable-joke/data/mp4';
% aslSrc = '/Users/covix/Projects/probable-joke/ctw/data/asl/inter_class';
% aslSrc = '/Users/covix/Projects/probable-joke/ctw/data/asl/deep_features';
aslSrc = '/Users/covix/Projects/probable-joke/ctw/data/asl/deep_pca_features';

%% data
% aslData = aslAliDataAll(aslSrc);
aslData = aslAliDataFeatures(aslSrc);
% X0s = aslAliDataX(aslData.DPs, st('d', .96));
X0s = aslData.DPs;
Xs = pcas(X0s, st('d', min(cellDim(X0s, 1)), 'cat', 'n'));

%% monotonic basis
ns = cellDim(Xs, 2);
l = round(max(ns) * 1.1);
bas = baTems(l, ns, 'pol', [5 .5], 'tan', [5 1 1]); % 2 polynomial and 3 tangent functions

%% utw (initialization)
aliUtw = utw(Xs, bas, []);

%% gtw
aliGtw = gtw(Xs, bas, aliUtw, [], parGtw, parCca, parGN);

%% save indexes
save('aliGtw.mat', 'aliGtw');

%% show result
shAslCmp([], [], {aliGtw}, [], parCca, [], parGN, 1);


%% show key-frame - feature
% idx = round(linspace(1, l, 7));
% shAslAli(aslData.BMFs, aliGtw.P(idx, :), 10);

%% show key-frame - image
% shAslAli(aslData.Fs, aliGtw.P(idx, :), 11);
