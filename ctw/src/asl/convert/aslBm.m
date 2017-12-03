% extract binary mask from file
%
% Input
%   frame   -   frame, h x w
%
% Output
%   bmV      -  , h x w
%
% History
%   create  -  Luca Coviello (luca.coviello@gmail.com), 11-22-2017


footpath = cd;

dirs = ["/data/asl/inter_class/*.mp4"
"/data/asl/intra_class/*.mp4"];

for d = dirs'
    files = dir([footpath char(d)]);
    for file = files'
        disp([file.folder '/' file.name])
        vidObj = VideoReader([file.folder '/' file.name]);

        vidHeight = vidObj.Height;
        vidWidth = vidObj.Width;

        s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
            'colormap',[]);

        k = 1;
        while hasFrame(vidObj)
            s(k).cdata = readFrame(vidObj);
            k = k+1;
        end

        bms = cell(1, length(s));

        for i = 1:length(s)
            bms{i} = double(~magicWand(s(i).cdata, [1 20], [1 20], 50));
        end
        
        fname_ext = split(file.name, '.');
        v = VideoWriter([file.folder '/' fname_ext{1} '-bm.' fname_ext{2}], 'MPEG-4');
        open(v);
        for i = 1:length(s)
            writeVideo(v, bms{i});
        end
        close(v);
    end
end



