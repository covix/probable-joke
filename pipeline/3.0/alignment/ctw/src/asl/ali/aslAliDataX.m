function [Xs, X0s] = aslAliDataX(aslData, parPca)
% Obtain ASL BM feature for alignment.
%
% Input
%   aslData     -  asl data
%   parPca      -  pca parameter, see function pca for more details
%
% Output
%   Xs          -  feature matrix, 1 x m (cell), di x ni
%   X0s         -  feature matrix with same dimension, 1 x m (cell), min(d1, ..., dm) x ni
%
% History
%   create      -  Luca Coviello (luca.coviello@gmail.com), 11-22-2017


% projection
Xs = pcas(aslData, parPca);
X0s = pcas(Xs, st('d', min(cellDim(Xs, 1)), 'cat', 'n'));
