% fld_solver_main is the main solve script, a cmd application

% Try to get log file location, if not specified, use default log location
if exist('logFile', 'var') 
	diary(logFile)
else
	diary('default.log');
end

% Start logging
diary on;

%% Bootstrap
p = fileparts(mfilename('fullpath'));
% log
addpath(fullfile(p, 'log'));

% Try to get input file (fldin) location
if ~exist('inputFile', 'var')
	log_fatal('input flle not specified');
end

%% Calculation
log_infof('Start calculation using %s', inputFile);

%% Clean Up: end logging and exit
diary off;
exit(0);