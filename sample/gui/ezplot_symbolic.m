% use ezplot to draw symbolic expressions
% <http://cn.mathworks.com/help/matlab/ref/ezplot.html>

figure;

syms x y;
circle = x^2 + y^2 - 25;
subplot(2,2,1);
ezplot(circle);

line = x - y;
subplot(2,2,2);
ezplot(line);

subplot(2,2,3);
ezplot(sin(x));

subplot(2,2,4);
ezplot(sin(x) + cos(y));