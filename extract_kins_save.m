function out = extract_kins(master_time_reduced, features, feature_type,  wavelengths, aug_mat, fname, dirname) % 'feature': n x 2 matrix with on each line the spectral range of the feature to study.

temp_kins = struct('features', features , 'dynamics', zeros(size(master_time_reduced,2), size(features,1)), 'feature_type', -1*ones(size(features,1),1));

    for k = 1:size(features,1);
        index_feature = wavelengths>features(k,1) & wavelengths<features(k,2);   % look for the index corresponding to the feature of which you want the kinetics
        full_kins(:,k) = mean(aug_mat(:,index_feature),2);                       % average the data on the feature spectra
    end

    for i = 1:size(aug_mat,1)/size(master_time_reduced,2)
        temp_kins(i).dynamics = full_kins(1+(i-1)*size(master_time_reduced,2):i*size(master_time_reduced,2),:)  % scuts out the different fluences
        temp_kins(i).features = features;
        figure(i)
        plot(temp_kins(i).dynamics)
        %build a file with all the infos
        fID = fopen([dirname '\' fname(i).name(1:size(fname(i).name,2)-3) 'ktst'], 'w');                      % open file
        fprintf(fID, ['Time' repmat('\t dT/T',[1,size(features,1)]) '\r\n']);                              % Long Names line
        fprintf(fID, 'ps \r\n');                                                                               % Units line
        fprintf(fID, [repmat(' \t %0.5g eV - %0.5g eV',[1,size(features,1)]) '\r\n'], features');         % Feature position (comment) line
        fprintf(fID, [repmat('\t %0.5g',[1,size(features,1)]) '\r\n'], feature_type);                   % Feature type (+1 = PB -1 : PA)
        fprintf(fID, ['%0.5g' repmat('\t %0.5g',[1,size(features,1)]) '\r\n'], [master_time_reduced' temp_kins(i).dynamics]'); % Data
        fclose(fID);
        %build a file with all the infos
        %kins = [master_time_reduced', temp_kins(i).dynamics]
        %save([path '\' filenames(i).name '.xkn'],'kins', '-ascii', '-double', '-tabs')
    end
    
out = temp_kins
end