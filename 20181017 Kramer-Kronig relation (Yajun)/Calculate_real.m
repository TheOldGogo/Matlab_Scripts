%             Imaginary---->Real ?Yajun Gao, 10-18-2018, KAUST)
% Calculate the real component from the imaginary component, based on
%the Kramers-Kronig relation.

clear all
close all

%----load the data, the omega axis and the imaginary component.
omega=load('the omega axis.txt');
imagi=load('the imagi component.txt');

%---initialize the imaginary
real=zeros(length(omega),1);

%----evaluate the first and last component.
delta_omega=abs(omega(2)-omega(1));
for i=2:length(omega)
    real(1)=real(1)+(2/pi)*(omega(i)*imagi(i)/(omega(i)^2-omega(1)^2))*delta_omega;
end

en=length(omega);
for i=1:en-1
    real(en)=real(en)+(2/pi)*(omega(i)*imagi(i)/(omega(i)^2-omega(end)^2))*delta_omega;
end

%----evaluate the other elements in the middle
for i=2:en-1
    for j=1:i-1
        real(i)=real(i)+(2/pi)*(omega(j)*imagi(j)/(omega(j)^2-omega(i)^2))*delta_omega;
    end
    for j=i+1:en
        real(i)=real(i)+(2/pi)*(omega(j)*imagi(j)/(omega(j)^2-omega(i)^2))*delta_omega;
    end   
end

%----plot
figure(1)
plot(omega,imagi,'k-',omega,real,'r-')
legend('imagi','real')
title('Imagi---->Real')

%----save the evaluated real component to file
%save('real_data.txt','real','-ascii')