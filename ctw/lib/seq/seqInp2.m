function Xs = seqInp2(X0s, P, par)
% Sequence replication and interpolation.
% 
% Remark
%   If P denote a contiunous time warping, we need to 
%   do interploation betten frames.
%
%   The interploation between each frame is a 2-D operation
%   based on the Matlab function "interp1".
%
% Input
%   X0s     -  original sequence, 1 x m (cell), dim x n
%   P       -  warping path, l x m | 1 x m (cell), li x 1
%   par     -  parameter
%     inp   -  interpolation algorithm, {'exact'} | 'nearest' | 'linear' | 'cubic'
%                'exact': exact replication (copy) of each frame
%                'nearest', 'linear', 'cubic': 1-D interpolation (see Matlab help on "interp1")
%
% Output
%   Xs      -  new sequence, 1 x m (cell), dim x li
%
% History
%   create  -  Luca Coviello (luca.coviello@gmail.com), 11-27-201

% function parameter
inp = ps(par, 'inp', 'exact');

% dimension
dims = cellDim(X0s, 1);

% warping path
if iscell(P)
    Ps = P;
    m = length(Ps);
    ls = cellDim(Ps, 1);
else
    [l, m] = size(P);
    Ps = cell(1, m);
    for i = 1 : m
        Ps{i} = P(:, i);
    end
    ls = zeros(1, m) + l;
end

% per sequence
Xs = cell(1, m);
for i = 1 : m
    X0 = zeros(size(X0s{i}));
    
    X0s{i}{j}
    p = Ps{i};
    
    % exact replication
    if strcmp(inp, 'exact')
        Xs{i} = X0(:, p);

    % continous interpolation
    else
        % insert phantom frame
        X0 = [X0(:, 1), X0, X0(:, end)];
        p = p + 1;

        % interpolation
        Xs{i} = zeros(dims(i), ls(i));
        for d = 1 : dims(i)
            Xs{i}(d, :) = interp2(X0(d, :), p, inp);
        end
    end
end
