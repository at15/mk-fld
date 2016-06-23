% requst http server

% http://cn.mathworks.com/help/matlab/ref/webread.html
url = 'http://localhost:8000/abc';
data = webread(url);
disp(data);