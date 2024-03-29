%             Real---->Imaginary ?Yajun Gao, 10-18-2018, KAUST)
% Calculate the imaginary component from the real component, based on
%the Kramers-Kronig relation.
<<<<<<< HEAD

clear all
close all

%----load the data, the omega axis and the real component.
omega=load('the omega axis.txt');
real=load('real_data.txt');
=======
% 2019-09-15 JG: added a separate line for loading the directory +
%               automatized the extension ".txt"
%                  From my experience it seems like this one actually calculates the
%               real part, while the "Calculate real" actually calculates the imaginary
%               part. -> need to change names after discussing with Yajun

% clear all
% close all

%----load the data, the omega axis and the real component.
% path = 'C:\Users\gorenfjf\Documents\Programs stuff\Matlab_Scripts\20181017 Kramer-Kronig relation (Yajun)\'
% omega=load(strcat(path,'Wavelength axis','.txt'));
% real=load(strcat(path,'PCE10_hITIC_k','.txt'));

function out = Calculate_real_fun(omega,imagi) 
>>>>>>> 028808127a990ffc3507d4ce20d9f572b7814d0c

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

<<<<<<< HEAD
=======
%----output the n indexes
out = real;

end

>>>>>>> 028808127a990ffc3507d4ce20d9f572b7814d0c
%save the evaluated imaginary component to file
%save('imagi_data.txt','imagi','-ascii')