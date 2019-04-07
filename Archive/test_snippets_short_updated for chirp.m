%% Prog from Fabian (or Ian?) 
%% Kindly commented for you by JG
%% 2015 - 05 - 12 JG: re-symetrized the Gaussian derivative used in convolution to find the zero (line 45), before it had more negative terms than positive (because the arrow had 9 pts (diff between 10 pts); now 10 (diff between 11 pts))) 
%% 2015 - 08 - 18 JG: add an "ordered_names" variable to know in which order the data are reordered.

clear all ; 

sample='SM27';
timeoffset=0;

dirname='C:\Users\gorenfjf\Documents\projects\SM27_28\XP\7- Transients\TA\20160425_SM27'
fnames=dir(dirname);                                                        % dir lists the files in directory -> return a structure with file names and infos

j=1;
for i=1:length(fnames)
    if strfind(fnames(i).name,'.cor')                                       % look in the list the files with matching names
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
    data_struc(j)=subbackground(data_struc_org(j),[-500 -8]);               % averages the signal between -500 and -8 ps, plots the average and substracts it -> write to corrected sturcture to datastruc
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
lam=[1 2.5];                                                              % J.G. 2015-05-13 I reduced the range a bit because the program doesn't plot if the measurement is on a smaller range
t=[-5 5];

offset=0.0;
master_time=data_struc(j).time;
%gaussian derivative to find zero time
Y = diff(pdf('norm',0:10,5,2));                                             % "derivative" (actually difference between successive elements) of a gaussian function 
interp_time=-10:.1:10;


hold all
for i=1:length(txtfnames)
    
    V=mean(abs(data_struc(j).smootheddata(data_struc(j).lam>lam(1)&data_struc(j).lam<lam(2),:))); % average (over lambda I guess) of the given wavelength range
    temp_time=data_struc(j).time(data_struc(j).time>t(1)&data_struc(j).time<t(2));           % take the part of the time within the range defined higher
    V_temp=interp1(data_struc(j).time,V,interp_time);      
    % make the interpolation... to find the zero... But I'm not sure what sense it makes without having substracted the background before
    % modify a bit because of the index shift induced by the use of the
    % 'valid' mode (because the result of the convolution in mode 'valid' 
    % is smaller than the original array -> without those zeros, the index would be slightly wrong):
    zeroness = conv(abs(V_temp),Y,'valid'); 
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
master_time = master_time-offset;
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

for i=1:length(txtfnames)
    
    subplot(3,3,j);
    myplot(data_struc(j),[1 2.5],[-5 5])
    view(2)
    D_shifted(:,:,j)=data_struc(j).smootheddata;                            % stored the data in the right order in D_shifted
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
t_min = 24;                                                                 % J.G changed from 55 to 29 where my zero approximately is 
t_max = size(master_time,2);
w_min = 1;
w_max = size(data_struc(1).lam,1);

D_temp=D_shifted(w_min:w_max,t_min:t_max,:);                                      % J.G. just adjust the data range to suppress NaNs
for i=1:size(D,3)                                                           
    % D is defined in line 31. it's a 3 D matrix, 
    % with the 3rd index = sample index
    % and the 2 first ones are the original smoothed data
    % so size(D,3) is simply the number of files loaded
    D_norm(:,:,i)=D_temp(:,:,i)/min(min(D_temp(:,:,i)));
end
master_time_reduced = master_time(t_min:t_max);                             % J.G.: not used but usefull for later applications
master_spectra_reduced = data_struc(1).lam(w_min:w_max);
figure()                                                                    % J.G.: figure was assigned to a "f" but f never used
hold all
for k=1:size(D,3)
    plot(master_time,D_shifted(150,:,k))                                    % this 150 (previously 200) is just a random wavelength
    axis([-5, 5, -Inf, inf]);
end

aug_mat=reshape(D_temp,size(D_temp,1),size(D_temp,2)*size(D_temp,3))';
aug_mat_norm=reshape(D_norm,size(D_norm,1),size(D_norm,2)*size(D_norm,3))';
for k = 1:size(data_struc,2)
    aug_mat_norm_single(:,:,k) = D_temp(:,:,k);
end

clear V V_temp junk index t_shift lam_min_index lam_max_index t_min t_max
clear j init_sig aix fnames interp_time lam t temp_time time i Y D f k offset timeoffset zeroness w_max w_min % J.G. added zeroness to the clearing
