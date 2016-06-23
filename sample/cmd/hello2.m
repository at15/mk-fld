% use symbolic toolbox
diary('t.log');
diary on;
syms x;
y = x^2;
x = 2;
disp(subs(y));
diary off;