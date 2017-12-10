function shAslCmp(Xs, X0s, alis, aliT, parCca, parDtw, parGN, fig)
% Show alignments.
% 
% Input
%   Xs      -  used by GTW
%   X0s     -  used by other method
%   alis    -  alignment result, 1 x m (cell)
%   aliT    -  ground-truth alignment
%   parCca  -  parameter for CCA
%   parDtw  -  parameter for DTW
%   fig     -  figure number
%
% History
%   create  -  Luca Coviello (luca.coviello@gmail.com), 11-28-2017

% parameter
parPca = st('d', 3, 'homo', 'y');
parPca0 = st('d', 3, 'homo', 'n');
parMk = st('mkSiz', 1, 'lnWid', 1, 'ln', '-');
parChan = st('nms', {'x', 'y', 'z'}, 'gapWid', 1, 'all', 'y');
parAx = st('mar', .1, 'ang', [30 80], 'tick', 'n');

% dimension
m = length(alis);

% figure
if ~exist('fig', 'var')
    fig = 1;
end
rows = 2; cols = m + 1;
Ax = iniAx(fig, rows, cols, [200 * rows, 200 * cols]);

% original time series
XX0s = pcas(X0s, parPca0);
shs(XX0s, parMk, parAx, 'ax', Ax{1, 1}); 
title(['original sequence']);
xlabel('x'); ylabel('y'); zlabel('z');
shChans(XX0s, parMk, parChan, 'ax', Ax{2, 1});
% legend('binary', 'Euclidean', 'Poisson');
% legend('Rotation', 'Euclidean', 'G-Force');

% per algorithm
algs = cellFld(alis, 'cell', 'alg');
for i = 1 : m
    col = i + 1;
    ali = alis{i};
    alg = algs{i};

    % truth
    if strcmp(alg, 'truth')
        Ys = gtwTra(homoX(Xs), ali, parCca, parDtw);
        YYs = pcas(Ys, parPca);
        shs(YYs, parMk, parAx, 'ax', Ax{1, col}); title(alg);
        shChans(YYs, parMk, stAdd(parChan, 'P', ali.P), 'ax', Ax{2, col});

    % utw
    elseif strcmp(alg, 'utw') || strcmp(alg, 'uni')
        shs(XX0s, parMk, parAx, 'ax', Ax{1, col}); title(alg);
%        set(gca, 'xlabel', 'x', 'ylabel', 'y', 'zlabel', 'z');
        shChans(XX0s, parMk, stAdd(parChan, 'P', ali.P), 'ax', Ax{2, col});
        
    % dtw    
    elseif strcmp(alg, 'dtw')
        shs(XX0s, parMk, parAx, 'ax', Ax{1, col}); title(alg);
        shChans(XX0s, parMk, stAdd(parChan, 'P', ali.P), 'ax', Ax{2, col});

    % ddtw
    elseif strcmp(alg, 'ddtw')
        YYs = pcas(ali.Ys, parPca0);
        shs(YYs, parMk, parAx, 'ax', Ax{1, col}); title(alg);
        shChans(YYs, parMk, stAdd(parChan, 'P', ali.P), 'ax', Ax{2, col});

    % pdtw
    elseif strcmp(alg, 'pdtw')
        shs(XX0s, parMk, parAx, 'ax', Ax{1, col}); title(alg);
        xlabel('x'); ylabel('y'); zlabel('z');
        shChans(XX0s, parMk, stAdd(parChan, 'P', ali.P), 'ax', Ax{2, col});

    % pddtw
    elseif strcmp(alg, 'pddtw')
        YYs = pcas(ali.Ys, parPca0);
        shs(YYs, parMk, parAx, 'ax', Ax{1, col}); title(alg);
        xlabel('x'); ylabel('y'); zlabel('z');
        shChans(YYs, parMk, stAdd(parChan, 'P', ali.P), 'ax', Ax{2, col});
        
    % pimw
    elseif strcmp(alg, 'pimw')
        Ys = pimwTra(X0s, ali);
        YYs = pcas(Ys, parPca0);
        shs(YYs, parMk, parAx, 'ax', Ax{1, col}); title(alg);
        xlabel('x'); ylabel('y'); zlabel('z');
        shChans(YYs, parMk, stAdd(parChan, 'P', ali.P), 'ax', Ax{2, col});

    % ctw
    elseif strcmp(alg, 'ctw') || strcmp(alg, 'pctw')
        Ys = gtwTra(homoX(Xs), ali, parCca, parDtw);
        YYs = pcas(Ys, parPca);
        shs(YYs, parMk, parAx, 'ax', Ax{1, col}); title(alg);
        shChans(YYs, parMk, stAdd(parChan, 'P', ali.P), 'ax', Ax{2, col});

    % hctw
    elseif strcmp(alg, 'hctw')
        Ys = gtwTra(homoX(Xs), ali, parCca, parDtw);
        YYs = pcas(Ys, parPca);
        shs(YYs, parMk, parAx, 'ax', Ax{1, col}); title(alg);
        shChans(YYs, parMk, stAdd(parChan, 'P', ali.P), 'ax', Ax{2, col});

    % ftw or gauss-newton
    elseif strcmp(alg, 'ftw') || strcmp(alg, 'gn')
        shs(XX0s, parMk, parAx, 'ax', Ax{1, col}); title(alg);
        shChans(XX0s, parMk, stAdd(parChan, 'P', ali.P), 'ax', Ax{2, col});

    % hftw
    elseif strcmp(alg, 'hftw')
        shs(XX0s, parMk, parAx, 'ax', Ax{1, col}); title(alg);
        shChans(XX0s, parMk, stAdd(parChan, 'P', ali.P), 'ax', Ax{2, col});
    
    % gtw
    elseif strcmp(alg, 'gtw')
        Ys = gtwTra(homoX(Xs), ali, parCca, parGN);
        YYs = pcas(Ys, parPca);
        shs(YYs, parMk, parAx, 'ax', Ax{1, col}); title(alg);
        xlabel('x'); ylabel('y');
        shChans(YYs, parMk, stAdd(parChan, 'P', ali.P), 'ax', Ax{2, col});
%         h = legend('distance transform', '3-d joint', 'shape context');
%         set(h, 'Orientation', 'horizontal');

    else
        error('unknown algorithm: %s', alg);
    end
end

