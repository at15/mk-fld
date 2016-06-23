# Command line application

## Use MATLAB without GUI

- `matlab -nosplash -nodesktop` this will popup an interactive command line.
- http://stackoverflow.com/questions/6657005/matlab-running-an-m-file-from-command-line

````
"C:\Program Files\MATLAB\R2016a\bin\matlab.exe" -nosplash -nodesktop -nojvm -noFigureWindows -minimize -r "cd('D:\workspace\src\github.com\at15\mk-fld\sample\cmd'); run('D:\workspace\src\github.com\at15\mk-fld\sample\cmd\hello2.m');exit;"
````

## Compile to command line application

- [Do not include the splash image when package the application](http://cn.mathworks.com/matlabcentral/answers/158788-how-do-i-suppress-the-splash-screen-for-compiled-applications-in-2014b)
- Toolbox CAN'T be used!
- `exit` need to be added in order to exit after finished. (NOTE: when exit is called in normal mode, MATLAB
will exit as well....)

so we have to start a full MATLAB instance instead of a standalone application.

## Use C++ API

- http://cn.mathworks.com/help/matlab/calling-matlab-engine-from-c-c-and-fortran-programs.html
- http://www.umiacs.umd.edu/~jsp/Downloads/MatlabEngine/MatlabEngine.pdf