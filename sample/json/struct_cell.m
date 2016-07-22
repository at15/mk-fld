% convert struct to cell array for use in uitable
clear all;
clc;

s.name = 'mie';
s.sex = 'male';

disp('result of using struc2cell');
disp(struct2cell(s));

disp('convert manually');

names = fieldnames(s);
disp(class(names));

transformed = cell([length(names) 2]);
i = 1;

for n = 1:length(names)
    name = names(n);
    disp(name);
    disp(i);
    disp(class(name));
    % FIXME: Argument to dynamic structure reference must evaluate to a valid field name.
    % disp(s.(name));
    name2 = char(name);
    disp(name2);
    disp(s.(name2));
    
    % transformed{n,1} = name;
    transformed{n,1} = name2;
    % i = i + 1;
    % FIXME: Conversion to cell from char is not possible.
    % transformed(i) = s.(name2);
    % FIXED: use {} instead of () http://cn.mathworks.com/help/matlab/matlab_prog/access-data-in-a-cell-array.html
    % i = i + 1;
    transformed{n,2} = s.(name2);
end

disp(transformed);
disp({1, 2; 3, 4});