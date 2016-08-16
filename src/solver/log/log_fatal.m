function log_fatal(message)
%log_fatal log message and exit
%   N/A
fprintf('[FATAL] %s\n',message);
diary off;
exit(1);

end

