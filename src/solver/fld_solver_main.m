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
% json
addpath(fullfile(p, '../../third_party/jsonlab'));

if usejava('desktop')
    log_info('GUI mode');
else
    log_info('Headless mode');
end

% Must have input file (fldin) location
if ~exist('inputFile', 'var')
    log_fatal('inputFlle not specified, pass it from command line');
else
    log_infof('input file %s', inputFile);
end
% Must have job id
if ~exist('jobId', 'var')
    log_fatal('jobId not specified, pass it from command line');
else
    log_infof('job id %s', jobId);
end
% Get the pid, TODO: may report it to golang server to let it monitor
pid = feature('getpid');
log_infof('pid %d', pid);

%% Calculation
log_infof('Start calculation using %s', inputFile);

% Simulate calc
pause(30);

%% Clean Up: end logging and exit
diary off;
exit(0);