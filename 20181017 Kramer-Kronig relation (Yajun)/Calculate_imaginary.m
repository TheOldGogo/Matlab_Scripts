%             Real---->Imaginary ?Yajun Gao, 10-18-2018, KAUST)
% Calculate the imaginary component from the real component, based on
%the Kramers-Kronig relation.

clear all
close all

%----load the data, the omega axis and the real component.
omega=load('the omega axis.txt');
real=load('real_data.txt');

%---initialize the imaginary
imagi=zeros(length(real),1);

%----evaluate the first and last component of imagi
delta_omega=abs(omega(2)-omega(1));
for i=2:length(omega)
    imagi(1)=imagi(1)+(-2*omega(1)/pi)*(real(i)/(omega(i)^2-omega(1)^2))*delta_omega;
end

en=length(omega);
for i=1:en-1
    imagi(en)=imagi(en)+(-2*omega(en)/pi)*(real(i)/(omega(i)^2-omega(en)^2))*delta_omega;
end

%----evaluate the other elements in the middle
for i=2:en-1
    for j=1:i-1
        imagi(i)=imagi(i)+(-2*omega(i)/pi)*(real(j)/(omega(j)^2-omega(i)^2))*delta_omega;
    end
    for j=i+1:en
        imagi(i)=imagi(i)+(-2*omega(i)/pi)*(real(j)/(omega(j)^2-omega(i)^2))*delta_omega;
    end   
end

%----plot
figure(2)
plot(omega,real,'r-',omega,imagi,'k-')
legend('real','imagi')
title('Real---->Imagi')

%save the evaluated imaginary component to file
%save('imagi_data.txt','imagi','-ascii')