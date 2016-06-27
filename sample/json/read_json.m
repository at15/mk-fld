% Read JSON using jsonlab 
% https://github.com/fangq/jsonlab

% Add jsonlab to PATH
addpath('../../third_party/jsonlab');

% Read from string
data = loadjson('{"obj":{"string":"value","array":[1,2,3]}}');
disp(data.obj.array(1)); % should be 1
disp(data.obj.string); % should be value

% Read from file 
dataAA5083 = loadjson('aa5083.json');
disp(dataAA5083.name);
disp(dataAA5083.hardening);

