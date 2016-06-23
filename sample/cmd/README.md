# Command line application

## Use MATLAB without GUI

- `matlab -nosplash -nodesktop` this will popup an interactive command line.
- http://stackoverflow.com/questions/6657005/matlab-running-an-m-file-from-command-line

````
"C:\Program Files\MATLAB\R2016a\bin\matlab.exe" -nodisplay -nosplash -nodesktop -r "cd('D:\workspace\src\github.com\at15\mk-fld\sample\cmd'); run('D:\workspace\src\github.com\at15\mk-fld\sample\cmd\hello-symbolic.m');exit;"
````

## Compile to command line application

- [Do not include the splash image when package the application](http://cn.mathworks.com/matlabcentral/answers/158788-how-do-i-suppress-the-splash-screen-for-compiled-applications-in-2014b)
- Toolbox CAN'T be used!
- `exit` need to be added in order to exit after finished. (NOTE: when exit is called in normal mode, MATLAB
will exit as well....)

so we have to start a full MATLAB instance instead of a standalone application.
