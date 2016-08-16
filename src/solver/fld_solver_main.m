% fld_solver_main is the main solve script, a cmd application
diary('a.log');
diary on;
try
    disp(inputFile);
    disp('a');
    pause(3);
catch e
    disp(e);
    exit(1);
end
diary off;