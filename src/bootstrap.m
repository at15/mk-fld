% Bootstrap Add folders to MATLAB search path 
clc;
disp('start bootstrap');
% disp(mfilename('fullpath'));
p = fileparts(mfilename('fullpath'));
% disp(p);
% disp(strcat([p '../third_party/jsonlab']));
% disp(fullfile(p, '../third_party/jsonlab'));


% Add third party libs
addpath(fullfile(p, '../third_party/jsonlab'));

% Add GUIs
addpath(fullfile(p,'ui_config'));
addpath(fullfile(p,'ui_post_process'));
addpath(fullfile(p,'ui_solver'));

disp('bootstrap finished');