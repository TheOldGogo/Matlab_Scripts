%% Prog from Fabian (or Ian?) 
%% 2015 - 05 -15 JG: start to play with it
%% 2015 - 08 -17 JG: add an "ordered_names" variable to know in which order the data are reordered.
%% 2017 - 05 -30 JG: change the background substraction to take into account the fact that the background changes sign at t0 but not the scattering (actually it's done in the function "subbackground_BGplusScat" called in line 28)

%clear all;
sample='Purified_Batch';
timeoffset=0;

dirname='C:\Users\gorenfjf\Documents\MYdocuments\projects\Anger''s molecules\PushPull\TA\20170105_Agen_Dyad_LDVis';
fnames=dir(dirname);

j=1;
for i=1:length(fnames)
    if strfind(fnames(i).name,'nJ.txt')
        if strfind(fnames(i).name,sample)
        txtfnames(j)=fnames(i);
        j=j+1;
        end
    end
end

j=1;
for i=1:length(txtfnames)
    
    data_struc(j)=txt2strucfun([dirname filesep() txtfnames(i).name]);
    
    data_struc(j)=subbackground_BGplusScat(data_struc(j),[-1e-7 -1e-8]);            
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
lam=[1.2 3.2];
t=[-10e-9 10e-9];
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
interp_time=-10e-9:.05e-9:10e-9;

figure()
hold all
 for i=1:length(txtfnames)
    
    V=mean(abs(data_struc(j).smootheddata(data_struc(j).lam>lam(1)&data_struc(j).lam<lam(2),:))); % average (over lambda I guess) of the given wavelength range
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
    % note: in contrast to the SD version, the elements
    % outside of the range are equaled to zero rather than NaN
    data_struc(j).time=master_time-offset;
    plotkin(data_struc(j),lam,t,0);
    j=j+1;
    
end


%% sort the intensities into decreasing order
j=1;
time=[0 2e-9];
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
    
    subplot(3,3,j);
    myplot(data_struc(j),[1.05 3.4],[-5e-9 5e-9])
    view(2)
    D_shifted(:,:,j)=data_struc(j).smootheddata;
    j=j+1;
    
end

%% make a normalized version of D
lam_min_index = 32;
lam_max_index = 258;%size(data_struc(1).lam,1);
t_min_index = 17;
t_max_index = 180;%size(master_time,2);

D_temp=D_shifted(lam_min_index:lam_max_index,t_min_index:t_max_index,:);
for i=1:size(D,3)
    D_norm(:,:,i)=D_temp(:,:,i)/max(abs(max(abs(D_temp(:,:,i)))));
end
LDto100us_master_time_reduced = master_time(t_min_index:t_max_index);
LDto100us_master_spectra_reduced = data_struc(1).lam(lam_min_index:lam_max_index);
figure()
hold all
for k=1:size(D,3)
    plot(master_time,D_shifted(200,:,k))
    axis([-5e-9, 5e-9, -Inf, inf]);
end

LDto100us_aug_mat=reshape(D_temp,size(D_temp,1),size(D_temp,2)*size(D_temp,3))';
LDto100us_aug_mat_norm=reshape(D_norm,size(D_norm,1),size(D_norm,2)*size(D_norm,3))';
for k = 1:size(data_struc,2)
    LDto100us_aug_mat_norm_single(:,:,k) = D_temp(:,:,k);
end

clear V V_temp junk index t_shift lam_min_index lam_max_index t_min_index t_max_index
clear j init_sig aix fnames interp_time lam t temp_time time i Y D

