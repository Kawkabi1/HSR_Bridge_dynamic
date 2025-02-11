% ********************************************
% * HSLM-A Trains                            *
% * type 1-10                                *
% * prEN 1991-2:2002 final draft (p.83)      *
% * Raid Karoumi 2003-12-14                  *
% ********************************************
function [TRAINLOAD,TRAINDIST]=HSLMA(type)
N=[18 17 16 15 14 13 13 12 11 11]; % number of intermediate coaches
D=[18 19 20 21 22 23 24 25 26 27]; % coach length (m)
d=[2 3.5 2 3 2 2 2 2.5 2 2]; % bogi-axle spacing (m)
P=[170 200 180 190 170 180 190 190 210 210]; % point force (KN)
N=N(type);D=D(type);d=d(type);P=P(type);
da=D-d;
% ---> Power car, end coach and intermediate coach <---
l1=0; % total length of car (m)
ax=[P]; % axle data vector. in kg
TRAINLOAD=ones(7+N*2+7,1)*ax; % all axles of the train, in kN
% calculate and store the TRAINDIST of each axels (m)
TRAINDIST=[];TRAINDIST2=[]; TRAINDIST3=[];
%Two first and two lasts vagons
TRAINDIST1=[0; 3; 14; 17;
20.525; 20.525+d; 20.525+D-d/2-3.525/2;];
for vagn=1:N
if vagn==1
a=TRAINDIST1(7);
else
a=TRAINDIST2(size(TRAINDIST2,1));
end
TRAINDIST22=[a+d; a+d+da;];
TRAINDIST2=[TRAINDIST2; TRAINDIST22];
end
a=TRAINDIST2(size(TRAINDIST2,1));
TRAINDIST3=[a+d; a+d+D-d/2-d-3.525/2; a+d+D-d/2-d-3.525/2+d;];
a=TRAINDIST3(size(TRAINDIST3,1));
TRAINDIST3=[TRAINDIST3; a+3.525; a+3.525+3; a+3.525+3+11; a+3.525+3+11+3;];
TRAINDIST=[TRAINDIST1; TRAINDIST2; TRAINDIST3];
% All cars are placed before the bridge left support
TRAINDIST=TRAINDIST.*(1);