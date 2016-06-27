% Read JSON using jsonlab 
% https://github.com/fangq/jsonlab

url = 'http://localhost:8000/json';
data = webread(url);
% webread can parse json by default, it is new feaure since 2014a
disp(data.hello);

% Add jsonlab to PATH
addpath('../../third_party/jsonlab');
% urlread is introduced since 2006a
data = urlread(url);
disp(data);
parsed_data = loadjson(data);
disp(parsed_data.hello);
