% MATLAB Script Written for Modal Analysis of a simply support bridge
% superstrucure
% written by :                              KAWKABI KHAJA WAHAAJUDDIN
%                                            NWPU 2020 MASTER STUDENT 
clc
clear
%% First Part: Input Data
TL=24;                     %Span Lenght
E=35*10^9;                 %E(PA)
l=1200;                    %l(cm.)
inertia =5.93;             %Second Moment of Inertia (m^4)
m_b=19375*1.5;                 %Mass per unit length (Kg/m)
VSP=250;
type='cs';
n_a=1;
%% Second Part: Defining the Elements
L=l/100;                      %Length of Each Element in meters
noe=TL/L;                     %Number of Elemnts
DES=[1,noe*2+1];              %Dofs are eliminated at supports
nod =[0:L:noe*L];             %Coordinates of nodes
EI = E*inertia;               %Beam stiffness
Dof = 2*length(nod);          %Total No. Degrees of Freedom
vsp=VSP/3.6;
save('INPUTS','TL','E','l','vsp','type','L','noe','DES','nod','EI','Dof','n_a','VSP')
K= zeros(Dof);
M= zeros(Dof);
%% Third Part: Generation of General Stiffness Matrix
for i=1:noe
lm=[2*(i-1)+1,2*(i-1)+2,2*(i-1)+3,2*(i-1)+4];
ke = BeamEl(EI, nod([i:i+1]));
K(lm, lm) = K(lm, lm) + ke;
end
%% Fourth Part: Generating Mass Matrix
for i=1:noe
lm=[2*(i-1)+1,2*(i-1)+2,2*(i-1)+3,2*(i-1)+4];
m = BeamCM(m_b,nod([i:i+1]));
M(lm,lm) = M(lm, lm) + m;
end
%% Define The Load Vector
F = zeros(Dof,1);                       % Applied force at specific dofs
[Kf, Mf, Rf] = System(K, M, F, DES);    % System Matrices 
%% Solve the eigenvalue problem and normalized eigenvectors
[a, D] = eig(Kf, Mf);
[omegas,ii] = sort(sqrt(diag(D)));         %Natural Frequencies
a = a(:,ii);                               %Mode Shapes
T = 2*pi./omegas;                          %Natural Periods
f = 1./T;                                  %Natural Frequency (cps)
save ('temp0.mat', 'Mf', 'Kf' ,'Rf');