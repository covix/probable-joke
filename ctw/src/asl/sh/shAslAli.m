function shAslAli(aslData, P, fig)
% Show alinged frames of the Weizmann sequences.
%
% Input
%   aslData   -  data
%     pFss   -  frame index, 1 x m (cell)
%   P        -  time warping, l x m 
%   feats    -  feature names, 1 x m (cell)
%   wsMixs   -  data, 1 x m (cell)
%   fig      -  figure number
%
% History
%   create   -  Feng Zhou (zhfe99@gmail.com), 12-29-2008
%   modify   -  Feng Zhou (zhfe99@gmail.com), 04-24-2013

% srcs
% [srcs, parFs] = stFld(wsSrc, 'srcs', 'parFs');


% dimension  
[l, m] = size(P);

% mask
% wsMasks = cellss(1, m);
% for i = 1 : m
%     wsMasks{i} = weiMask(srcs{i}, parFs{i}, 'svL', 2);    
% end

% figure
rows = m; cols = l;
figSiz = [25 * rows, 25 * cols];
Ax = iniAx(fig, rows, cols, figSiz, 'wGap', 0, 'hGap', .03);

% plot
for i = 1 : m
    for t = 1 : l
        tF = round(P(t, i));
        M = aslData{i}{tF};
        shImg(M, 'ax', Ax{i, t}, 'eq', 'y'); axis off;
    end
end
