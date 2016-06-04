# mk-fld

A MATLAB program that use M-K model to calculate FLD and FLSD

M-K (Marciniak and Kuczyński) is widely used for predicting forming limit diagram (FLD) and forming limit stress diagram. 
Banabic has created a program called **FORM-CERT** for FLD calculation, but it is not open source. **mk-fld** is part of my undergraduate thesis project. 
Another part is [bform](https://github.com/at15/bform), a database for blank forming.

**mk-fld** include the following functionalities 

- calculate FLD and FLSD use built in constitutive equations (hardening law and yield functions)
- transform experimental FLD data to FLSD
- A graphic user interface
- import and export data in csv format.
