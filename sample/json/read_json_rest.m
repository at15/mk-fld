% Read JSON using jsonlab 
% https://github.com/fangq/jsonlab

url = 'http://localhost:8000/json';
data = webread(url);
% webread can parse json by default, by I think this should be a new
% feature in 2016a
disp(data.hello);