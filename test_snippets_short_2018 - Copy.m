%% Prog from Fabian (or Ian?) 
%% Kindly commented for you by JG
%% 2015 - 05 - 12 JG: re-symetrized the Gaussian derivative used in convolution to find the zero (line 45), before it had more negative terms than positive (because the arrow had 9 pts (diff between 10 pts); now 10 (diff between 11 pts))) 
%% 2015 - 08 - 18 JG: add an "ordered_names" variable to know in which order the data are reordered.
%% 2018 - 02 - 15 JG: change the data sent to aug mat for the first ps: now it is the non-smoothed data (still smoothed for the rest)
%% 2018 - 06 - 25 JG: accordingly applied the subbackground and zero substraction also to the unsmoothed data
%% 2018 - 07 - 25 JG: Added the "clearvars - except" option (currently commented line 10) as an alternative to "clear all" (thank you Jafar)
%% 2019 - 05 - 13 JG: The spectral and temporal boundaries are now entered by actual value instead of pixel number l 157 -> 160 
%% 2019 - 05 - 13 JG: The time to switch from raw to smoothed data is now oFn a specific line (currently l 130)

%clear all ; 
%clearvars -except Constr_Spec Ref_Spectra; 


sample='OIDTBR';
timeoffset=0;

dirname='/home/gorenfjf/Temp_Workspace/DR3 project/DR3_OIDTBR_SD/720nm_excitation/'
fnames=dir(dirname);                                                        % dir lists the files in directory -> return a structure with file names and infos

j=1;
for i=1:length(fnames)
    if strfind(fnames(i).name,'.cor')                                   % look in the list the files with matching names
        if strfind(fnames(i).name,sample)                                   % goes on
        txtfnames(j)=fnames(i);                                             % saves the file name in 'txtfnames'
        j=j+1;
        end
    end
end

j=1;
for i=1:length(txtfnames)
    
    data_struc_org(j)=txt2strucfun([dirname filesep() txtfnames(i).name]);  % not quite sure what the txt2strucfun does but must be similar to text2struc -> extract for each time, lam, data, smootheddata (smoothed with 5x5 neighbours) 
    D_org(:,:,j) = data_struc_org(j).smootheddata;                          % saving the smoothed data
    data_struc(j)=subbackground_SD2018(data_struc_org(j),[-400 -8]);               % averages the signal between -400 and -8 ps, plots the average and substracts it -> write to corrected sturcture to datastruc
    % Pb: the last "figure" reused for the next plot -> have to correct
    % that.
    % data_struc(j).time=data_struc(j).time+timeoffset;
    D(:,:,j)=data_struc(j).smootheddata;
    j=j+1;
    
end
figure(j)                                                                   % just so that the next picture is not drawn on top of the last one of the loop
D_initial = D;

%% set the zero times using an SVD to find zero time between -5 and 5 ns, works only for long time data

j=1;
lam=[1 2.5];
t=[-15 15];
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
interp_time=-15:.1:15;

figure()
hold all
 for i=1:length(txtfnames)
    
    V=mean(abs(data_struc(j).smootheddata(data_struc(j).lam>lam(1)&data_struc(j).lam<lam(2),:)));   % average (over lambda I guess) of the given wavelength range
    temp_time=data_struc(j).time(data_struc(j).time>t(1)&data_struc(j).time<t(2));                  % take the part of the time within the range defined higher
    V_temp=interp1(data_struc(j).time,V,interp_time);      
    % make the interpolation... to find the zero... But I'm not sure what sense it makes without having substracted the background before
    % modify a bit because of the index shift induced by the use of the
    % 'valid' mode (because the result of the convolution in mode 'valid' 
    % is smaller than the original array -> without those zeros, the index would be slightly wrong):
    zeroness = conv(V_temp,Y,'valid'); 
    [junk index]=max(horzcat(zeros(1,4),zeroness,zeros(1,5)));
    t_shift=interp_time(index)
    data_struc(j).time=data_struc(j).time-t_shift;
    data_struc(j).smootheddata = interp2(data_struc(j).time,data_struc(j).lam,data_struc(j).smootheddata,master_time,data_struc(j).lam,'linear',0);
    data_struc(j).data = interp2(data_struc(j).time,data_struc(j).lam,data_struc(j).data,master_time,data_struc(j).lam,'linear',0);
    % note: in contrast to the SD version, the elements
    % outside of the range are equaled to zero rather than NaN
    data_struc(j).time=master_time-offset;
    plotkin(data_struc(j),lam,t,0);
    j=j+1;
    
end

%% sort the intensities into decreasing order - 
% note J.G: so far it was actually increasing because it was sorted after 
% decreasing signal (and signal takes negative values -> decreasing 
% -> increasing in absolute value)
j=1;
time=[0 1];
for i=1:length(txtfnames)
    
    init_sig(j)=mean(mean(abs(data_struc(j).smootheddata(data_struc(j).lam>lam(1)&data_struc(j).lam<lam(2),data_struc(j).time>time(1)&data_struc(j).time<time(2)))));
    % signal averaged over all wavelengths within the first ps. J.G. I add a
    % "abs" to compensate the possible effects of changeing photobleach - TA 
    % + values being negatives
    % note the double mean s for averageing over time then over wavelengths
    % or the opposite :p
    
    j=j+1;
    
end

[init_sig aix]=sort(init_sig,'descend');
data_struc=data_struc(aix);
ordered_names = txtfnames(aix);
%% plots the structures to make sure that they are in the correct order and zero times are also correct and reorderd D
% note: it's the original data which is plotted, not the chipcorrected.
figure
%subplot(2,3,1)

j=1;
t_raw = 0.8;

for i=1:length(txtfnames)
    
    subplot(3,3,j);
    myplot(data_struc(j),[1.2 3],[-5 5])
    view(2)
    D_shifted(:,:,j)=[data_struc(j).data(:,data_struc(j).time<=t_raw), data_struc(j).smootheddata(:,data_struc(j).time>t_raw)];  % stored the data in the right order in D_shifted.
    %note: direct data before 1ps, smoothed data after   
    j=j+1;
    
end

%% make a normalized version of D

% D_temp=D(1:136,32:end,:);
% for i=1:size(D,3)
%     D_norm(:,:,i)=D_temp(:,:,i)/max(max(D_temp(:,:,i)));
% end
% 
% din_1=reshape(D_temp,size(D_temp,1),size(D_temp,2)*size(D_temp,3));
% din_2=reshape(D_norm,size(D_norm,1),size(D_norm,2)*size(D_norm,3));

%% make a normalized version of D
%lam_min_index = 1;
%JG: commented because not used (and the next one too)
%lam_max_index = size(data_struc(1).lam,1);
t_min = 0;                                                                 % J.G changed from 55 to 29 where my zero approximately is 
t_max = 8000;
w_min = 0.82;
w_max = 3.5;%size(data_struc(1).lam);

D_temp=D_shifted(data_struc(1).lam>=w_min & data_struc(1).lam<w_max,data_struc(1).time>=t_min & data_struc(1).time<t_max,:);                                      % J.G. just adjust the data range to suppress NaNs
for i=1:size(D,3)                                                           
    % D is defined in line 31. it's a 3 D matrix, 
    % with the 3rd index = sample index
    % and the 2 first ones are the original smoothed data
    % so size(D,3) is simply the number of files loaded
    D_norm(:,:,i)=D_temp(:,:,i)/min(min(D_temp(:,:,i)));
end
master_time_reduced_SD = master_time(data_struc(1).time>=t_min & data_struc(1).time<t_max);                             % J.G.: not used but usefull for later applications
master_spectra_reduced_SD = data_struc(1).lam(data_struc(1).lam>=w_min & data_struc(1).lam<w_max);
figure()                                                                    % J.G.: figure was assigned to a "f" but f never used
hold all
for k=1:size(D,3)
    plot(master_time,D_shifted(200,:,k))                                    % this 150 (previously 200) is just a random wavelength
     plot(master_time, data_struc(k).data(200,:))
    plot(master_time, data_struc(k).smootheddata(200,:))
    axis([-5, 5, -Inf, inf]);
end

aug_mat_SD=reshape(D_temp,size(D_temp,1),size(D_temp,2)*size(D_temp,3))';
aug_mat_norm_SD=reshape(D_norm,size(D_norm,1),size(D_norm,2)*size(D_norm,3))';
for k = 1:size(data_struc,2)
    aug_mat_norm_single_SD(:,:,k) = D_temp(:,:,k);
end

clear V V_temp junk index t_shift lam_min_index lam_max_index t_min t_max k
clear j init_sig aix fnames interp_time lam t temp_time time i Y D f k offset timeoffset zeroness w_max w_min % J.G. added zeroness to the clearing
clear D_initial D_norm D_shifted k offset D_temp D_org
