%% 2015_05_26 JG: extract spectra

function out = extract_spectra(time, aug_mat, wavelengths, Mestype)

Times_SD = [0, 0.3, 1, 1.5, 3, 4.5, 10, 15, 30, 45, 100, 150, 300, 450, 1000, 1500, 3000, 8000];
Times_LD = [0, 3e-10, 1e-9, 1.5e-9, 3e-9, 4.5e-9, 1e-8, 1.5e-8, 3e-8, 4.5e-8, 1e-7, 1.5e-7, 3e-7, 4.5e-7, 1e-6, 1.5e-6, 3e-6, 4.5e-6, 1e-5, 1.5e-5, 3e-5, 4.5e-5, 1e-4, 1.5e-4, 3e-4, 4.5e-4];
Time_Ref_Exc = [0.1,1];
Time_Ref_Pols = [1e-8, 5e-7];

    if Mestype == 'LD'

        Times = Times_LD;

    end
        
    if Mestype == 'SD'

        Times = Times_SD;
    end
        
    if Mestype == 'RE'
 
        Times = Time_Ref_Exc;
    end
        
    if Mestype == 'RP'

        Times = Time_Ref_Pols;
    end

    temp_spec = struct('spectra',zeros(size(aug_mat,2),size(Times,2)/2))
    
    for k = 1:size(aug_mat,1)/size(time,2)
    
        fluence = aug_mat((k-1)*size(time,2)+1:k*size(time,2),:)
    
        for i = 1:size(Times,2)/2
            index_t = time>Times(2*i-1) & time<Times(2*i)
            % temp_spec(:,i,k) = mean(fluence(time>Times(2*i-1)& time<Times(2*i),:),1)';
            temp_spec(k).spectra(:,i) = mean(fluence(index_t,:),1)';
        end
        figure(k)
        plot(wavelengths,temp_spec(k).spectra)
    end    


out = temp_spec
end