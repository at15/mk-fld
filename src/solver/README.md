# Solver 


## Usage 

Call from external application

- change to directory
- set parameters directly using syntax like `inputFile='test.fldin', they are reachable for the following script
- run the script
- `exit` is useful when `exit` is not called in the last executed m file

````
"C:\Program Files\MATLAB\R2016a\bin\matlab.exe" -nosplash -nodesktop -nojvm -noFigureWindows -minimize -r "cd('E:\workspace\src\github.com\at15\mk-fld\src\solver'); inputFile='c.fldin';run('E:\workspace\src\github.com\at15\mk-fld\src\solver\fld_solver_main.m');exit;"
````