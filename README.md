# mk-fld

A MATLAB program that use M-K model to calculate FLD and FLSD

M-K (Marciniak-Kuczyński) is widely used for predicting forming limit diagram (FLD) and forming limit stress diagram (FLSD). 
Banabic[1] has created a program called **FORM-CERT** for FLD calculation, but it is not open source. **mk-fld** is part of my undergraduate thesis project. 
Another part is [bform](https://github.com/at15/bform), a database for blank forming.

**mk-fld** include the following functionalities 

- calculate FLD and FLSD use built in constitutive equations (hardening law and yield functions).
- transform experimental FLD data to FLSD.
- A graphic user interface.
- import and export data in csv format.

**mk-fld** is made up of the following parts

- symbolic expressions for constitutive equations.
- function generators, transform symbolic expressions to numeric, prefixed with `s2f`.
- subroutines, fixed strain path, fixed groove orientation.

The code for FLD calculation is based on Butuc's paper[2] and FLSD part is based on another paper by Butuc[3].

## Reference

- [1] Jurco, P., and D. Banabic. "A user-frienldy programme for calculating Forming Limit Diagrams." Proc. 8th ESAFORM Conference on Material Forming. Cluj-Napoca April. 2005.
- [2] Butuc, M. C., et al. "A more general model for forming limit diagrams prediction." Journal of materials processing technology 125 (2002): 213-218.
- [3] Butuc, M. C., J. J. Gracio, and A. Barata Da Rocha. "An experimental and theoretical analysis on the application of stress-based forming limit criterion." International Journal of Mechanical Sciences 48.4 (2006): 414-429.