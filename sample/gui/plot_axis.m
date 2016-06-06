% sample of plot <http://cn.mathworks.com/help/matlab/ref/plot.html>
% chang Axis range

x = 1:10;
y = 1:10;

% use subplot to draw two plot in one figure
% <http://cn.mathworks.com/help/matlab/ref/subplot.html>
figure
subplot(2,1,1);
plot(x,y);

subplot(2,1,2);
plot(x,y);
% set axis limits of current plot <http://cn.mathworks.com/help/matlab/ref/axis.html>
axis([0 20 -5 10]);