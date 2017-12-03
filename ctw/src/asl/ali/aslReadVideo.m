function aslFrames= aslReadVideo(path)
% TODO desc.
%
% Input
%   path        -  video path
%
% Output
%   aslFrames   - loaded frames
%
% History
%   create      -  Luca Coviello (luca.coviello@gmail.com), 11-22-2017
               
% % load
% if ~exist('arg1', 'var')
%   svl=true;
% end

% if svl && exist(path, 'file')
%     wsData = matFld(path, 'wsData');
%     prInOut('weiAliData', 'old, %s', prex);
%     return;
% end
% prIn('weiAliData', 'new, %s', prex);


v = VideoReader(path);

h = v.Height;
w = v.Width;

frames = struct('cdata', zeros(h, w, 'logical'));

k = 1;
while hasFrame(v)
    frames(k).cdata = readFrame(v);
    k = k + 1;
end

aslFrames = {frames.cdata};
