#include "mex.h"

// use mex heelo.c to compile, you need to have supported compiler installed
void mexFunction(int nlhs, mxArray *plhs[],
        int nrhs, const mxArray *prhs[])
{
    mexPrintf("Hello, world!\n");
    return;
}