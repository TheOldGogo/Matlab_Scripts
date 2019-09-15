%             Imaginary---->Real ?Yajun Gao, 10-18-2018, KAUST)
% Calculate the real component from the imaginary component, based on
%the Kramers-Kronig relation.
% 2019-09-15 JG: added a separate line for loading the directory +
%               automatized the extension ".txt"
%                  From my experience it seems like this one actually calculates the
%               real part, while the "Calculate real" actually calculates the imaginary
%               part. -> need to change names after discussing with Yajun

clear all
close all

%----load the data, the omega axis and the imaginary component.
path = 'C:\Users\gorenfjf\Documents\Programs stuff\Matlab_Scripts\20181017 Kramer-Kronig relation (Yajun)\Validation tests\'
omega=load(strcat(path,'Wavelength axis','.txt'));
imagi=load(strcat(path,'2HT_C70_CBCN_k','.txt'));

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