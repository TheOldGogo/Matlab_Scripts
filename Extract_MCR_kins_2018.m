function out = extract_MCR_kins(master_time_reduced, copt, species_Name,...% species_Names has to be given as a cell:
    fname, dirname)                                                         % {'species1', 'species2'}

    n_fluences = size(copt,1)/size(master_time_reduced,2);                 % number of studied fluences

    for i = 1:size(copt,2)
        
        %temp_kins = matrix(copt(:,i),size(master_time_reduced,2),-1);      % put the column array of the ith species as a matrix
        temp_kins = reshape(copt(:,i),size(master_time_reduced,2),[]);                    %  with one column per fluence
        
                                                                                
        figure();
        plot(temp_kins);
        title(species_Name(i));
        
        %build a file with all the infos
        fID = fopen([dirname '\' char(species_Name(i)) '.MCR'], 'w');      % create file
        fprintf(fID, ['Time' repmat('\t \\ g(D)T/T',[1,n_fluences]) '\r\n']);    % Long Names line
        fprintf(fID, 's \r\n');                                           % Units line
       % fprintf(fID, [repmat(' \t %0.5s ',[1,n_fluences]) '\r\n'], ...
       %     extractfield(fname,'name'));                            % Fluence/file
        fprintf(fID, ['%0.5g' repmat('\t %0.5g',[1,n_fluences]) '\r\n'],...
            [master_time_reduced' temp_kins]');                            % Data
        fclose(fID);
        %build a file with all the infos
        %kins = [master_time_reduced', temp_kins(i).dynamics]
        %save([path '\' filenames(i).name '.xkn'],'kins', '-ascii', '-double', '-tabs')
    end
    

end