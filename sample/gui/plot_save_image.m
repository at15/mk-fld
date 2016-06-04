% sample of plot <http://cn.mathworks.com/help/matlab/ref/plot.html>

clear all;
clc;

% plot and save image to current folder
% <http://cn.mathworks.com/help/matlab/ref/print.html>
plot(1:10);
print('line','-dpng');

% plot with style and save file to user specified location
% <http://cn.mathworks.com/help/matlab/ref/uiputfile.html>
x = 1:10;
y = [10 9 8 7 6 5 6 7 8 9];
plot(x,y, '*-');
[filename, pathname] = uiputfile('*.png', 'Select save location');
[~, filename, ~] = fileparts(filename);
path_without_extension = strcat([pathname, filename]);
print(path_without_extension, '-dpng');