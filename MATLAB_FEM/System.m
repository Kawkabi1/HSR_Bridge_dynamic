function [Kf, Mf, Rf] = System(K, M, R, DES)
    %%% Computes System Matrix
    %%% K = global stiffness matrix
    %%% M = global mass matrix
    %%% R = global right hand side vector
    %%% debc = list of degrees of freedom to delete rows and columns
dof = length(R);
df = setdiff(1:dof, DES);
Kf = K(df, df);
Mf = M(df, df);
Rf = R(df);