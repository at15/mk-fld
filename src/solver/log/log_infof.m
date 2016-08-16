function log_infof(message, varargin)
%log_infof log message with info prefix
%   N/A
 message = strcat(['[INFO] ', message, '\n']);
        fprintf(message,varargin{:});

end