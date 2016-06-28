% Bootstrap Add folders to MATLAB search path 
clc;
disp('start bootstrap');

% Add third party libs

addpath('../third_party/jsonlab');

addpath('./gui');
addpath('./post_process');
addpath('./solver');

disp('bootstrap finished');