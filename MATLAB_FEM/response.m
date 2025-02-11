clc
clear all
close all
clc
clear
load ('INPUTS','TL','E','l','vsp','type','L','noe','DES','nod','EI','Dof','n_a','VSP')
%___________________________________________________________________________
% Inputs:
% M, K
% F = forcing function
% t = Time period
% u0 = initial displacement
% v0 = initial velocity
%___________________________________________________________________________
load ('temp0.mat', 'Mf', 'Kf', 'Rf')
M = Mf;
% Deifne Stiffness Matrix
K = Kf;
[n,n]= size(M);
F = Rf;
u0 = zeros(n,1); u0(1) =0;
v0 = zeros(n,1); v0(1) =0;
[n,n]= size(M);
%___________________________________________________________________________
% Solve the eigenvalue problem and normalized the eigenvectors
%___________________________________________________________________________
[a, D] = eig(K, M); % Solve for eigenvalues (D) and eigenvectors (a)
[omegas,k] = sort(sqrt(diag(D))); % Natural Frequencies
a = a(:,k);
T = 2*pi./omegas; % Natural Periods
aMa = diag(a'*M*a); % aMa = {a}'*[M]*(a}
nom_phi = (a)*inv(sqrt(diag(aMa))); % Normalized modal matrix
orth_M = nom_phi'*M*nom_phi; % Check the orthogonality condition for Mass Matrix
orth_K = nom_phi'*K*nom_phi; % Check the orthogonality condition for StiffnessMatrix
%___________________________________________________________________________
% Initial conditions
%___________________________________________________________________________
P = nom_phi'*F; % Normalized force, P = nom_F
q0 = nom_phi'*M*u0;
dq0 = nom_phi'*M*v0;
%___________________________________________________________________________
% Damping matrix using the proportional damping matrix
% [C] = a[M]+b[K]
% zetas = damping ratios
%___________________________________________________________________________
a = .5;
b = .006;

nom_C = nom_phi'*(a*M+b*K)*nom_phi;
zetas = diag((1/2)*nom_C*inv(diag(omegas)));
save ('temp1.mat', 'omegas', 'P' ,'zetas','q0','dq0','M','nom_phi')

q = [];
r = [];
s=0;

tt = 500/vsp;
step=tt/10000;
t=[0:step:tt];

%%
for i=1:n
disp(i)
tic
load ('temp1.mat', 'omegas', 'P' ,'zetas','q0','dq0','M','nom_phi')
q0_i = q0(i,:);
dq0_i = dq0(i,:);
omega = omegas(i,:);
P = P(i,:);
m = M(i,i);
zeta = zetas(i,:);
save ('temp2.mat', 'omega', 'i' ,'zeta','step','nom_phi');
[t,q] = ode45(@MDOFP, t, [q0_i dq0_i]',[]);
r(:,i) = q(:,1);
save ('temp3.mat', 'r')
toc
end

%%
figure(1)
yim = nom_phi*[r'];
udotdot = gradient(yim(2,:),t);
plot(t, yim(2,:)) % Node 2: y dipl (in.).
title ('Node 2'); xlabel ('Time (sec)'); ylabel ('u_3(in.)'); grid on
figure(2)
plot(t, udotdot) % Node 2: y dipl (in.).
s=1000000*(udotdot');
u=1000000*(yim(2,:)');
if n_a==1
MAX=[];
else
load ('Iteration', 'MAX');;
end
am=max(s);
um=max(u);
MAX(n_a,:)=[VSP um am];
save ('Iteration', 'MAX');