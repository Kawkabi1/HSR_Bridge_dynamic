clc
clear
EI=(40*10^9)*(45);
L=50;
m=63500;
df=0;
v=82.5;
type='t2';
[a,b]=FORCEMATRIX(type);
U1=0;
U2=0;x=L/2;
i=0;
dd=0.01;
t=0:dd:L/v;
tt=6;
for j=1:length(a)
    p=1000*b(j);
syms n

%_______________________________________________________________________%
%                            CALCULATIONS                               %
%_______________________________________________________________________%

for n=1:1
ef=(n*pi*v)/L;
omega_n=(((n^2)*pi^2)/L^2)*sqrt((EI)/m);
S_n=ef/omega_n;
omega_nd=omega_n*sqrt(1-(df^2));
%_______________________________________________________________________%
B=2*df*S_n*cos(omega_nd*t)+(S_n/sqrt(1-df^2))*(2*(df^2)+(S_n^2)-1)*sin(omega_nd*t);
A=(1-S_n^2)*sin(ef*t)-2*df*S_n*cos(ef*t)+(exp(-df*omega_n*t).*B);
A1=(1-S_n^2)*sin(ef*t)+1;
B1=(S_n)*((S_n)-1)*sin(omega_nd*t);
C=sin((n*pi*x)/L);
D=(2*p*(L^3))/(EI*n^4*pi^4);
E=(1-(S_n^2))^2+(2*df*S_n)^2;
E1=(1-S_n)^2;
U1=1000*(D/E).*A.*C;
U2=1000*(D/E1).*A1.*B1.*C;
%U21=symsum(U2,n,1,10)
end
U(j,:)=U1;
end
TIME=0:dd:tt;
LL=zeros(length(a),length(TIME));
LL(1,1:length(t))=U(1,:);
for jj=2:length(a)
    DIS(jj)=a(jj)/v;
    numm=round(DIS(jj)/dd);
    LL(jj,numm:numm+length(t)-1)=U(jj,:);
end
LM=sum(LL);
plot(TIME,LM)
final =[TIME' LM'];