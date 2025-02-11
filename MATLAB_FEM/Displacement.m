function U = Displacement(Kf, Rf, Dof, df)
% function to find solution in terms of global displacements
U1=Kf\Rf;
U=zeros(Dof,1);
U(df)=U1;


