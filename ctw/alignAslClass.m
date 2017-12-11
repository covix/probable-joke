function alignAslClass(basedir, class, pv)
% TODO desc
%
% Input
%   basedir -   base folder of the ds
%   class   -   class to analyze
%   pv      -   preserved variance
%
% History
%   create  -   Luca Coviello (luca.coviello@gmail.com), 11-22-2017

%% algorithm parameter
parCca = st('d', 3, 'lams', .1); % CCA: reduce dimension to keep at least 0.95 energy
parGN = st('nItMa', 2, 'inp', 'linear'); % Gauss-Newton: 2 iterations to update the weight in GTW, 
parGtw = st('nItMa', 20);


%% src
% aslSrc = '/Users/covix/Projects/probable-joke/data/mp4';
aslSrc = strcat(basedir, '/', class);
% aslSrc = '/Users/covix/Projects/probable-joke/ctw/data/asl/inter_class';

%% data
saved_file = strcat('data/asl/bm_mat/BM_class_', class, '.mat');
if exist(saved_file) == 2
    disp("loading matlab ds");
    load(saved_file);
else
    disp("loading dataset");
    aslData = aslAliDataAll(aslSrc);
    save(saved_file, 'aslData')
end


%% transform data
X0s = aslAliDataX(aslData.BMs, st('d', pv));
Xs = pcas(X0s, st('d', min(cellDim(X0s, 1)), 'cat', 'n'));

s = size(Xs{1});
disp("Number of features:")
disp(s(1));

%% monotonic basis
ns = cellDim(Xs, 2);
l = round(max(ns) * 1.1);
bas = baTems(l, ns, 'pol', [5 .5], 'tan', [5 1 1]); % 2 polynomial and 3 tangent functions

%% utw (initialization)
aliUtw = utw(Xs, bas, []);

%% gtw
aliGtw = gtw(Xs, bas, aliUtw, [], parGtw, parCca, parGN);

%% save indexes
P = aliGtw.P;
csvwrite(strcat('data/asl/aligned_bm/ali_gtw_bm_P_', class, '.csv'), P)

%% show key-frame - feature
% idx = round(linspace(1, l, 7));
% shAslAli(aslData.BMFs, aliGtw.P(idx, :), 10);

%% show key-frame - image
% shAslAli(aslData.Fs, aliGtw.P(idx, :), 11);
