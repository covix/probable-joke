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
aslSrc = [cd '/data/asl/intra_class/'];
% aslSrc = [cd '/data/asl/inter_class/'];

%% data
aslData = aslAliData(aslSrc);
X0Gs = aslAliDataX(aslData.Gs, st('d', .999));
XGs = pcas(X0Gs, st('d', min(cellDim(X0Gs, 1)), 'cat', 'n'));

X0BMs = aslAliDataX(aslData.BMs, st('d', .999));
XBMs = pcas(X0BMs, st('d', min(cellDim(X0BMs, 1)), 'cat', 'n'));


%% monotonic basis
ns = cellDim(XBMs, 2);
l = round(max(ns) * 1.1);
bas = baTems(l, ns, 'pol', [5 .5], 'tan', [5 1 1]); % 5 polynomial and 5 tangent functions

%% utw (initialization)
aliUtw = utw(XBMs, bas, []);

%% pdtw
aliPdtw = pdtw(XBMs, aliUtw, [], parDtw);

%% pddtw
aliPddtw = pddtw(XBMs, aliUtw, [], parDtw);

%% pimw
aliPimw = pimw(XBMs, aliUtw, [], parPimw, parDtw);

%% pctw
aliPctw = pctw(XBMs, aliUtw, [], parPctw, parCca, parDtw);

%% gtw
aliGtwG = gtw(XGs, bas, aliUtw, [], parGtw, parCca, parGN);

%% gtw BM
aliGtwBM = gtw(XBMs, bas, aliUtw, [], parGtw, parCca, parGN);

%% show result
shAslCmp(XBMs, XBMs, {aliPdtw, aliPddtw, aliPimw, aliPctw, aliGtwBM, aliGtwG}, [], parCca, parDtw, parGN, 1);

%% show basis
rows = 1; cols = 1;
Ax = iniAx(4, rows, cols, [270 * rows, 270 * cols], 'wGap', .3, 'hGap', .3);
[mks, cls] = genMkCl;
shAliP(bas{1}.P, 'ax', Ax{1}, 'lnWid', 1, 'mkSiz', 0, 'cl', cls, 'G', eye(size(bas{1}.P, 2)));
set(gca, 'XTick', [], 'YTick', []);
title('bases used by GTW');

%% show key-frame - feature
idx = round(linspace(1, l, 7));
shAslAli(aslData.BMFs, aliGtwBM.P(idx, :), 10);

%% show key-frame - image
shAslAli(aslData.Fs, aliGtwBM.P(idx, :), 11);
