%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% FITTING TDCF DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Written by Vincent LE CORRE
%lecorre.vlc@outlook.fr
clear all
close all hidden

%% Import data
data=importdata('ahmed.txt');
Tdelay=data.data(:,1); % s
Qpre=data.data(:,2);   % C
Qcol=data.data(:,3);   % C
Qtot=data.data(:,4);   % C
A=0.01*1e-0;           % cm^2
th=210e-7;              % cm
e=1.602*1e-19;         % C
%% Fit
idx=1;
for i=2:length(Qcol)
    DQcol(idx)=Qcol(i)-Qcol(i-1);
    DQpre(idx)=Qpre(i)-Qpre(i-1);
    Dt(idx)=Tdelay(i)-Tdelay(i-1);
    idx=idx+1;
end
for i=1:length(Qcol)
    Qcol2(i)=Qcol(i)^2;
end
Qcol2(1)=[];
x=-DQpre;
y=-Qcol2.*Dt/(e*A*th);
z=DQcol;
xdata=[x' y'];
fun= @(gamma,xdata) xdata(:,1)+gamma*xdata(:,2);
gamma0=1e-18;
[gamma,R,J,CovB,MSE,ErrorModelInfo]=nlinfit(xdata,z',fun,gamma0);
gamma;
Qcolfit(1)=Qcol(1);
for i=2:length(Qcol)
    Qcolfit(i)=Qcol(i-1)-DQpre(i-1)-gamma*Dt(i-1)*Qcol(i-1)*Qcol(i-1)/(e*A*th);
end
figure(1)
%semilogx(Tdelay*1e6,Qtot,'ko',Tdelay*1e6,Qpre,'bo',Tdelay*1e6,Qcol,'ro',Tdelay*1e6,Qcolfit,'r')
semilogx(Tdelay*1e6,Qtot,'ko',Tdelay*1e6,Qpre,'bo',Tdelay*1e6,Qcol,'ro',Tdelay*1e6,Qcolfit,'r')
xlabel('Delay [\mus]')
ylabel('q [C]')
legend('q_{tot}','q_{pre}','q_{col}','q_{col} fit')
dim = [0.3 0.5 0.3 0.3];
str=strcat('\gamma=',num2str(gamma,3));
annotation('textbox',dim,'String',str,'FitBoxToText','on');
xlswrite('Charges_vs_Tdelay_1.5 uJ.xls',[Qcolfit',Tdelay]);