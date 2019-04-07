%% 2015_05_26 JG: extract spectra (time, aug_mat, wavelengths, Mestype)
%% 2017_11_19 JG: now saves one file per fluence
%% 2018_08_27 JG: added the option to extract a triplet reference (Mestype "RT") defaulty set to 5 - 7 ns on SD data

function out = extract_spectra_save(time, aug_mat, wavelengths, Mestype, dirname, fname)

Times_SD = [0.3, 1, 3, 10, 30, 100, 300, 1000, 3000, 8000];
Times_LD = [3e-10, 4.5e-10, 1e-9, 1.5e-9, 3e-9, 4.5e-9, 1e-8, 1.5e-8, 3e-8, 4.5e-8, 1e-7, 1.5e-7, 3e-7, 4.5e-7, 1e-6, 1.5e-6, 3e-6, 4.5e-6, 1e-5, 1.5e-5, 3e-5, 4.5e-5, 1e-4, 1.5e-4];
Time_Ref_Exc = [15,30];
Time_Ref_Tripl = [5000, 7000];
Time_Ref_Pols = [9e-9, 1.1e-8];

    if Mestype == 'LD'

        Times = Times_LD;
        scale = 's';

    end
        
    if Mestype == 'SD'

        Times = Times_SD;
        scale = 'ps';
    end
        
    if Mestype == 'RE'
 
        Times = Time_Ref_Exc;
        scale = 'ps';
    end
        
    if Mestype == 'RP'

        Times = Time_Ref_Pols;
        scale = 's';
    end

    
    if Mestype == 'RT'

        Times = Time_Ref_Tripl;
        scale = 'ps';
    end
    
    temp_spec = struct('spectra',zeros(size(aug_mat,2),size(Times,2)/2))
    
    for k = 1:size(aug_mat,1)/size(time,2)
    
        fluence = aug_mat((k-1)*size(time,2)+1:k*size(time,2),:);
    
        for i = 1:size(Times,2)/2
            index_t = time>Times(2*i-1) & time<Times(2*i);
            % temp_spec(:,i,k) = mean(fluence(time>Times(2*i-1)& time<Times(2*i),:),1)';
            temp_spec(k).spectra(:,i) = mean(fluence(index_t,:),1)';
        end
        figure(k)
        plot(wavelengths,temp_spec(k).spectra);
        fID = fopen([dirname filesep() fname(k).name(1:size(fname(k).name,2)-4) Mestype '.tst'], 'w');   
        fprintf(fID, ['Energy \t' repmat('dT/T \t',[1,size(Times,2)/2]) '\r\n'])
        fprintf(fID, 'eV \r\n');
        fprintf(fID, [' \t' repmat(['%0.5g - %0.5g ' scale '\t'],[1,size(Times,2)/2]) '\r\n'], Times);
        fprintf(fID, ['%0.5g \t' repmat('%0.5g \t',[1,size(Times,2)/2]) '\r\n'], [wavelengths temp_spec(k).spectra]');
        fclose(fID);
    end    


out = temp_spec
end