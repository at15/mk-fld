function log_fatal(message)
%log_fatal log message and exit
%   N/A
fprintf('[FATAL] %s\n',message);
diary off;

% Stop in GUI mode and exit in headless mode
% http://stackoverflow.com/questions/3408492/how-to-exit-a-matlab-m-file-not-the-matlab-itself-if-the-user-enters-bad-input
if usejava('desktop') 
    error('fatal error occured, see log for detail');
else
    exit(1);
end

end

