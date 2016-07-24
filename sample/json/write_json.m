% Write JSON using jsonlab

% Add jsonlab to PATH
addpath('../../third_party/jsonlab');

clc;

jsonmesh=struct('MeshNode',[0 0 0;1 0 0;0 1 0;1 1 0;0 0 1;1 0 1;0 1 1;1 1 1],...
    'MeshTetra',[1 2 4 8;1 3 4 8;1 2 6 8;1 5 6 8;1 5 7 8;1 3 7 8],...
    'MeshTri',[1 2 4;1 2 6;1 3 4;1 3 7;1 5 6;1 5 7;...
    2 8 4;2 8 6;3 8 4;3 8 7;5 8 6;5 8 7],...
    'MeshCreator','FangQ','MeshTitle','T6 Cube',...
    'SpecialData',[nan, inf, -inf]);
% With rootname jmesh
disp(savejson('jmesh',jsonmesh));
% Without rootname
disp(savejson('',jsonmesh,'ArrayIndent',0,'FloatFormat','\t%.5g'));
% Write to file
fid = fopen('test.json', 'w');
fprintf(fid, '%s', savejson('', jsonmesh));
fclose(fid);