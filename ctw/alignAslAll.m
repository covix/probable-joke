% TODO desc
%
% History
%   create  -  Luca Coviello (luca.coviello@gmail.com), 11-22-2017

%% 
clear variables

%%
basedir = '/Users/covix/Projects/probable-joke/data/mp4_split/';
pv = 0.75;

for class = 15:43
    disp(class);
    class_pad = sprintf('%02d', class);
    alignAslClass(basedir, class_pad, pv)
end
