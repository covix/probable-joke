function List = cmuList(act, varargin)
% Obtain list of CMU mocap sequences.
%
% Input
%   act     -  act name, 'walk' | 'run' | 'jump' | 'complex'
%   varargin
%     ran   -  flag of using range, {'y'} | 'n'
%
% Output
%   List    -  list of sequences, n x 4
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 09-02-2010
%   modify  -  Feng Zhou (zhfe99@gmail.com), 10-09-2011

% function option
isRan = psY(varargin, 'ran', 'y');

% walk
if strcmp(act, 'walk')
    List = { 2,  1, 'normal', [ 74, 272]; ... 
             2,  2, 'normal', [ 76, 257]; ...
             5,  1, 'normal', [ 36, 252]; ...
             6,  1, 'normal', [ 27, 248]; ...
             7,  1, 'normal', [  1, 192]; ...
             7,  2, 'normal', [ 11, 207]; ...
             7,  3, 'normal', [138, 351]; ...
             7,  4, 'slow', []; ...
             7,  5, 'slow', []; ...
             7,  6, 'normal', []; ...
             7,  7, 'normal', []; ...
             7,  8, 'normal', []; ...
             7,  9, 'normal', []; ...
             7, 10, 'normal', []; ...
             7, 11, 'normal', []; ...
             7, 12, 'brisk',  [ 80, 263]; ...
             8,  1, 'normal', [ 19, 200]; ...
             8,  2, 'normal', [ 71, 266]; ...
             8,  3, 'normal', [ 81, 277]; ...
             8,  4, 'slow',   [113, 360]; ...
             8,  5, 'stride', [ 31, 247]; ...
             8,  6, 'normal', [ 14, 178]; ...
             8,  7, 'stride', [ 80, 302]; ...
             8,  8, 'normal', [ 60, 220]; ...
             8,  9, 'normal', [ 76, 249]; ...
             8, 10, 'normal', [101, 275]; ...
             8, 11, 'stride', [ 43, 305]; ...
            10,  4, 'normal', [233, 432]; ...
            16, 15, 'normal', [ 65, 279]; ...
            17,  1, 'anger', []; ...
            17,  2, 'anger', []; ...
            17,  3, 'stealthily', []; ...
            17,  4, 'stealthily', []; ...
            17,  5, 'hobble', []; ...
            17,  6, 'jauntily', []; ...
            17,  7, 'jauntily', []; ...
            17,  8, 'muscular', []; ...
            17,  9, 'muscular', []; ...
            35,  1, 'normal', [ 84, 280]; ...
            35,  2, 'normal', [136, 335]; ...
            35,  3, 'normal', [126, 332]; ...
            35,  4, 'normal', [ 28, 222]; ...
            82,  9, 'confident', []; ...
            82, 10, 'sad', []; ...
            82, 11, 'normal', []; ...
            82, 12, 'happy',  [ 35, 221]};

elseif strcmp(act, 'run')
    List = { 2,  3, 'normal', [1, 91]; ...
             9,  1, 'normal', [30, 112]; ...
             9,  2, 'normal', [23, 113]; ...
             9,  3, 'normal', [17, 111]; ...
             9,  4, 'normal', [28, 122]; ...
             9,  5, 'normal', [25, 119]; ...
             9,  6, 'normal', [12, 107]; ...
             9, 10, 'normal', [12, 97]; ...
             9, 11, 'normal', [40, 130]; ...
            16,  8, 'suddently stop', [16, 119]; ...
            16, 35, 'normal', [44, 140]; ...
            16, 36, 'normal', [22, 131]; ...
            16, 37, 'veer left', []; ...
            16, 38, 'veer left', []; ...
            16, 39, 'veer right', []; ...
            16, 40, 'veer right', []; ...
            16, 41, '90-degree left turn', []; ...
            16, 42, '90-degree left turn', []; ...
            16, 43, '90-degree right turn', []; ...
            16, 44, '90-degree right turn', []; ...
            16, 45, 'normal', [1, 89]; ...
            16, 46, 'normal', [1, 92]; ...
            16, 55, 'normal', [62, 133]; ...
            16, 56, 'normal', [46, 134]; ...
            16, 57, 'suddently stop', []; ...
            35, 17, 'normal', [64, 167]; ...
            35, 18, 'normal', [64, 175]; ...
            35, 19, 'normal', [64, 160]; ...
            35, 20, 'normal', [63, 163]; ...
            35, 21, 'normal', [62, 161]; ...
            35, 22, 'normal', [2, 87]; ...
            35, 23, 'normal', [1, 77]; ...
            35, 25, 'normal', [51, 143]; ...
            35, 26, 'normal', [20, 112]; ...
            38,  3, 'long around', []};

elseif strcmp(act, 'jump')
    List = {13, 11, 'forward', [100, 381]; ...
            13, 13, 'forward', [57, 364]; ...
            13, 19, 'forward', [74, 360]; ...
            13, 32, 'forward', [40, 300]; ...
            13, 39, 'upperward', [8, 351]; ...
            13, 40, 'upperward', [30, 300]; ...
            13, 41, 'upperward', [30, 350]; ...
            13, 42, 'upperward', [30, 360]; ...
            16,  1, 'upperward', [49, 242]; ...
            16,  2, 'upperward', [158, 341]; ...
            16,  3, 'upperward', [97, 317]; ...
            16,  4, 'upperward', [85, 310]; ...
            16,  5, 'forward', [60, 240]; ...
            16,  6, 'forward', [160, 350]; ...
            16,  7, 'forward', [80, 380]; ...
            16,  9, 'forward', [190, 480]; ...
            16, 10, 'forward', [184, 430]; ...
            75,  1, 'run jump', []; ...
            75,  2, 'run jump', []; ...
            75,  3, 'run jump', []; ...
            75, 10, 'forward twice', []; ...
            75, 11, 'forward twice', []; ...
            75, 15, 'long jump', []; ...
            91, 39, 'forward', [1, 313]; ...
            91, 40, 'forward', [20, 382]; ...
            91, 41, 'forward', [90, 445]; ...
            91, 42, 'forward', [70, 460]; ...
            91, 43, 'forward small', [22, 213]; ...
            91, 44, 'forward small', [80, 290]; ...
            91, 45, 'forward', [1, 310]; ...
            105, 39, 'forward', [20, 370]; ...
            105, 40, 'forward', [20, 390]; ...
            105, 41, 'forward', [60, 423]; ...
            105, 43, 'forward small', [20, 200]; ...
            105, 44, 'forward small', [130, 290]; ...
            105, 45, 'forward', [10, 340]; ...
            118,  1, 'forward small', [118, 570]; ...
            118,  2, 'forward small', [60, 500]; ...
            118,  3, 'forward small', [120, 350]; ...
            118,  4, 'forward small', [130, 410]; ...
            118,  5, 'forward small', [90, 440]; ...
            118,  6, 'forward', [70, 270]; ...
            118,  7, 'forward', [220, 470]; ...
            118,  8, 'forward', [190, 400]; ...
            118,  9, 'forward', [35, 290]; ...
            118, 10, 'forward', [78, 310]; ...
            118, 11, 'forward', [140, 475]; ...
            118, 12, 'forward', [210, 480]; ...
            118, 13, 'forward', [220, 500]; ...
            118, 14, 'forward', [230, 520]; ...
            118, 15, 'forward', [220, 440]; ...
            118, 16, 'forward', [240, 460]};

elseif strcmp(act, 'jack')
    List = {13, 29, 'forward', [139, 275]; ... % 1-cycle
            13, 29, 'forward', [139, 411]};    % 2-cycle

elseif strcmp(act, 'wave')
    List = {13, 26, 'forward', [1, 270]; ...
            111, 37, 'normal', [1, 270]};

elseif strcmp(act, 'kick')
    List = {10, 1, 'kick', []; ...
            10, 2, 'kick', [292 390]; ...
            10, 3, 'kick', []; ...
            10, 5, 'kick', []; ...
            10, 6, 'kick', []; ...
            11, 1, 'kick', [348 441]};

elseif strcmp(act, 'complex')
    List = {86, 1, 'walking, sitting, looking, stand up', []; ...
            86, 2, 'walking, sitting, looking, stand up', []; ...
            86, 3, 'walking, sitting, looking, stand up', []; ...
            86, 4, 'walking, sitting, looking, stand up', []; ...
            86, 9, 'walking, sitting, looking, stand up', []};

else
    error(['unknown act: ' act]);
end

% remove range
if ~isRan
    for i = 1 : size(List, 1)
        List{i, 4} = [];
    end
end
