% TODO desc
%
% History
%   create  -  Luca Coviello (luca.coviello@gmail.com), 11-22-2017

clear variables;


%% algorithm parameter
parDtw = [];
parPimw = st('lA', 1, 'lB', 1); % IMW: regularization weight
parCca = st('d', 3, 'lams', .1); % CCA: reduce dimension to keep at least 0.95 energy
parPctw = [];
parGN = st('nItMa', 2, 'inp', 'linear'); % Gauss-Newton: 2 iterations to update the weight in GTW, 
parGtw = st('nItMa', 20);

%% src
aslSrc = '/Users/covix/Downloads/ctw/data/asl/intra_class/';

%% data
aslData = aslAliData(aslSrc);
X0s = aslAliDataX(aslData.BMs, st('d', .999));
Xs = pcas(X0s, st('d', min(cellDim(X0s, 1)), 'cat', 'n'));
XTs = pcas(aslData.BMs, st('d', .9, 'cat', 'y')); % sequences in same feature, used for computing the approximated ground-truth

%% monotonic basis
ns = cellDim(Xs, 2);
l = round(max(ns) * 1.1);
bas = baTems(l, ns, 'pol', [5 .5], 'tan', [5 1 1]); % 2 polynomial and 3 tangent functions

%% utw (initialization)
aliUtw = utw(Xs, bas, []);

%% truth (approximated by DTW on aligning sequences with the same feature)
aliT = pdtw(XTs, aliUtw, [], parDtw); 
aliT.alg = 'truth';

%% pdtw
aliPdtw = pdtw(Xs, aliUtw, aliT, parDtw);

%% pddtw
aliPddtw = pddtw(Xs, aliUtw, aliT, parDtw);

%% pimw
aliPimw = pimw(Xs, aliUtw, aliT, parPimw, parDtw);

%% pctw
aliPctw = pctw(Xs, aliUtw, aliT, parPctw, parCca, parDtw);

%% gtw
aliGtw = gtw(Xs, bas, aliUtw, aliT, parGtw, parCca, parGN);

%% show result
shAliCmp(Xs, Xs, {aliPdtw, aliPddtw, aliPimw, aliPctw, aliGtw}, aliT, parCca, parDtw, parGN, 1);

%% show basis
rows = 1; cols = 1;
Ax = iniAx(4, rows, cols, [270 * rows, 270 * cols], 'wGap', .3, 'hGap', .3);
[mks, cls] = genMkCl;
shAliP(bas{1}.P, 'ax', Ax{1}, 'lnWid', 1, 'mkSiz', 0, 'cl', cls, 'G', eye(size(bas{1}.P, 2)));
set(gca, 'XTick', [], 'YTick', []);
title('bases used by GTW');

%% show key-frame - feature
idx = round(linspace(1, l, 7));
shAslAli(aslData.BMFs, aliGtw.P(idx, :), 10);

%% show key-frame - image
shAslAli(aslData.Fs, aliGtw.P(idx, :), 11);
