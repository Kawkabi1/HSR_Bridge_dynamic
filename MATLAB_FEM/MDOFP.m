function q = MDOFP(t,q,m)
load ('temp2.mat', 'omega', 'i' ,'zeta','step','nom_phi')
load ('INPUTS','TL','E','l','vsp','type','L','noe','DES','nod','EI','Dof')
F=FORCEMATRIX(type,TL,vsp,t,Dof,L);
Fs = Forcedim(F, DES);
NF=nom_phi'*Fs;
P = NF(i);
q = [q(2); -omega* omega*q(1)-2*zeta*omega*q(2)+P];