
function out = extract_kins(master_time_reduced, features, wavelengths, aug_mat) % 'feature': n x 2 matrix with on each line the spectral range of the feature to study.

temp_kins = struct('features', features , 'dynamics', zeros(size(master_time_reduced,2),size(features,1))) ;

    for k = 1:size(features,1)
        index_feature = wavelengths>features(k,1) & wavelengths<features(k,2);   % look for the index corresponding to the feature of which you want the kinetics
        full_kins(:,k) = mean(aug_mat(:,index_feature),2);                       % average the data on the feature spectra
    end

    for i = 1:size(aug_mat,1)/size(master_time_reduced,2)
        temp_kins(i).dynamics = full_kins(1+(i-1)*size(master_time_reduced,2):i*size(master_time_reduced,2),:)  % separate the different fluences
        figure(i)
        plot(temp_kins(i).dynamics)
    end
    
out = temp_kins
end