
%% [data, energies, times, dirname_out, files] = test_snippets_long_2018_fun(sample, dirname, extension, lam_stable, t_zero, t_raw, final_t_range, final_Erange)
%% Prog from Fabian (or Ian?) 
%% 2015 - 05 - 15 JG: start to play with it
%% 2015 - 08 - 17 JG: add an "ordered_names" variable to know in which order the data are reordered.
%% 2017 - 05 - 30 JG: change the background substraction to take into account the fact that the background changes sign at t0 but not the scattering (actually it's done in the function "subbackground_BGplusScat" called in line 28)
%% 2018 - 06 - 06 JG: change the background substraction to take into account the disappearing of the scatering peak after 20 us (actually it's done in the function "subbackground_BGplusScat" called in line 28)
%% 2018 - 06 - 06 JG: change the data sent to aug mat for the 3 first ns: now it is the non-smoothed data (still smoothed for the rest) 
%% 2018 - 06 - 22 JG: corrected the raw data so that it also takes the time zero correction
%% 2018 - 11 - 18 JG: added the "clearvars -except" instead of "clear all". thank you Jafar.
%% 2020 - 05 - 14 JG: make it a function
%% 2020 - 05 - 14 JG: calculating the zero from raw data rather than smooth
%% 2023 - 09 - 25 JG: modify for the data which is now in microseconds instead of seconds

function [data, energies, times, dirname_out, files] = test_snippets_long_2018_fun(sample, dirname, extension, lam_stable, t_zero, t_raw, final_t_range, final_Erange)

if ~exist('t_zero', 'var')
    t = [-5e-3 5e-3];
else
    t = t_zero;
end

if ~exist('lam_stable','var')
    lam = [1 2.5];
else 
    lam = lam_stable;
end

if ~exist('t_raw','var')
    t_raw = 1.0;
end

if ~exist('final_t_range','var')
    t_min = 0;
    t_max = 3e-4;
else
    t_min = final_t_range(1);
    t_max = final_t_range(2);
end

if ~exist('final_Erange','var')
    w_min = 0.7;
    w_max = 3.5;
else
    w_min = final_Erange(1);
    w_max = final_Erange(2);
end



%sample='PCE10-PSM95';
timeoffset=0;

%dirname='C:\Users\gorenfjf\Documents\MYdocuments\projects\h-ITIC\XP\TA\VisTA_PSM95\PCE10-PSM95_LD';
fnames=dir(dirname);

j=1;
for i=1:length(fnames)
    if strfind(fnames(i).name,extension)
        if strfind(fnames(i).name,sample)
        txtfnames(j)=fnames(i);
        j=j+1;
        end
    end
end

j=1;
for i=1:length(txtfnames)
    
    data_struc(j)=txt2strucfun([dirname filesep() txtfnames(j).name]);
    
    data_struc(j)=subbackground_LD_noFlip(data_struc(j),[-1e-2 -1e-3]);            
    data_struc(j).time=data_struc(j).time+timeoffset;
    D(:,:,j)=data_struc(j).smootheddata;
    if sum(data_struc(j).lam == data_struc(1).lam) == size(data_struc(1).lam,1)
        display('Lambda is okay!')
    else
        display('Different wavelength calibration is used for the different fluences!!!')
    end
    j=j+1;
end
D_initial = D;
%times = [data_struc(1).time' data_struc(2).time' data_struc(3).time' data_struc(4).time' data_struc(5).time' data_struc(6).time']

%% set the zero times using an SVD to find zero time between -5 and 5 ns, works only for long time data

j=1;
%lam=[0.9 1.7];
%t=[-5e-3 5e-3];
master_time=data_struc(1).time;
offset=0;

% %%%%
% %Manual zero time correction if automatic does not work!
% for i=1:length(txtfnames)
%     plotkin(data_struc(j),lam,t);
%     j = j+1;
% end
%     
% tshift_man = [-1e-10 -1e-10 -1e-10 -1e-10 -1e-10];
% j = 1;
% for i=1:length(txtfnames)
%     data_struc(j).time = data_struc(j).time - tshift_man(j);
%     data_struc(j).smootheddata = interp2(data_struc(j).time,data_struc(j).lam,data_struc(j).smootheddata,master_time,data_struc(j).lam,'linear',0);
%     data_struc(j).time = master_time;
%     j = j+1;
% end

%%%%

% gaussian derivative to find zero time
Y = diff(pdf('norm',0:10,5,2));                                             %JG: modified from 1:10 to 0:10 to make it symetric
interp_time=-5e-3:.05e-3:5e-3;

figure()
hold all
 for i=1:length(txtfnames)
    
    %    V=mean(abs(data_struc(j).smootheddata(data_struc(j).lam>lam(1)&data_struc(j).lam<lam(2),:)));   % average (over lambda I guess) of the given wavelength range
    V=mean(abs(data_struc(j).data(data_struc(j).lam>lam(1)&data_struc(j).lam<lam(2),:)));           % same but from the raw data instead of smoothed
    temp_time=data_struc(j).time(data_struc(j).time>t(1)&data_struc(j).time<t(2));           % take the part of the time within the range defined higher
    V_temp=interp1(data_struc(j).time,V,interp_time);      
    % make the interpolation... to find the zero... But I'm not sure what sense it makes without having substracted the background before
    % modify a bit because of the index shift induced by the use of the
    % 'valid' mode (because the result of the convolution in mode 'valid' 
    % is smaller than the original array -> without those zeros, the index would be slightly wrong):
    zeroness = conv(V_temp,Y,'valid'); 
    [junk index]=max(horzcat(zeros(1,4),zeroness,zeros(1,5)));
    t_shift=interp_time(index);
    data_struc(j).time=data_struc(j).time-t_shift;
    data_struc(j).smootheddata = interp2(data_struc(j).time,data_struc(j).lam,data_struc(j).smootheddata,master_time,data_struc(j).lam,'linear',0);
    data_struc(j).data = interp2(data_struc(j).time,data_struc(j).lam,data_struc(j).data,master_time,data_struc(j).lam,'linear',0);

    % note: in contrast to the SD version, the elements
    % outside of the range are equaled to zero rather than NaN
    data_struc(j).time=master_time-offset;
    plotkin(data_struc(j),lam,t,0);
    j=j+1;
    
end


%% sort the intensities into decreasing order
j=1;
time=[0 2e-3];
for i=1:length(txtfnames)
    
   % init_sig(j)=mean(data_struc(j).data(data_struc(j).lam>lam(1)&data_struc(j).lam<lam(2),data_struc(j).time==0));
    init_sig(j)=mean(mean(abs(data_struc(j).smootheddata(data_struc(j).lam>lam(1)&data_struc(j).lam<lam(2),data_struc(j).time>time(1)&data_struc(j).time<time(2)))));
    % note JG: just added an "abs" so that the bleaching is not substracted from the rest of the signal 
    j=j+1;
    
end

[init_sig aix]=sort(init_sig,'descend'); %thanks to the "abs" it's now really decreasing independently of the sign of the data
data_struc=data_struc(aix);
ordered_names = txtfnames(aix);

%Zero time gets wrong for highest fluences.. manaual correction
% Take out for other data sets than PSBTBT:PCBM71
% data_struc(6).time = data_struc(6).time + 4e-10;
% data_struc(6).data = interp2(data_struc(6).time,data_struc(6).lam,data_struc(6).data,master_time,data_struc(6).lam,'linear',0);
% data_struc(6).time = master_time;


%% plots the structures to make sure that they are in the correct order and zero times are also correct and reorderd D
figure;
%subplot(2,3,1)

j=1;

for i=1:length(txtfnames)
    
    subplot(3,4,j);
    myplot(data_struc(j),final_Erange,[-1e-3 1e-3])
    view(2)
    D_shifted(:,:,j)=[data_struc(j).data(:,data_struc(j).time<=t_raw), data_struc(j).smootheddata(:,data_struc(j).time>t_raw)];
    j=j+1;
    
end

%% make a normalized version of D
% lam_min_index = 18;
% lam_max_index = 290; %size(data_struc(1).lam,1);
% t_min_index = 12;
% t_max_index = 97;%size(master_time,2);

D_temp=D_shifted(data_struc(1).lam>=w_min & data_struc(1).lam<w_max,data_struc(1).time>=t_min & data_struc(1).time<t_max,:);   
for i=1:size(D,3)
    D_norm(:,:,i)=D_temp(:,:,i)/max(abs(max(abs(D_temp(:,:,i)))));
end
master_time_reduced = master_time(data_struc(1).time>=t_min & data_struc(1).time<t_max);
master_spectra_reduced = data_struc(1).lam(data_struc(1).lam>=w_min & data_struc(1).lam<w_max);
figure()
hold all
for k=1:size(D,3)
    plot(master_time,D_shifted(141,:,k))
    plot(master_time, data_struc(k).data(141,:))
    plot(master_time, data_struc(k).smootheddata(141,:))
    axis([-1e-3, 1e-3, -Inf, inf]);
end

aug_mat=reshape(D_temp,size(D_temp,1),size(D_temp,2)*size(D_temp,3))';
aug_mat_norm=reshape(D_norm,size(D_norm,1),size(D_norm,2)*size(D_norm,3))';
for k = 1:size(data_struc,2)
    aug_mat_norm_single(:,:,k) = D_temp(:,:,k);
end

data = aug_mat;
energies = master_spectra_reduced;
times = master_time_reduced;
dirname_out = dirname;
files = ordered_names;

end

