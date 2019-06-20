%% 2019-05-07 JG: integrate_feature(spect_struc,wavelength)
%% Returns the integral of each feature (space between 2 sign changes) of a spectrum
%% takes imput spectra as a structure

function out = Integrate_features(spect_struc,wavelength,lim)

        

for i = 1:size(spect_struc,2)                                              % take one fluence...
    for k = 1:size(spect_struc(i).spectra,2)                                        % one time delay range
        limits = find(diff(sign(spect_struc(i).spectra(1:find(wavelength>=lim,1),k))));                            % find where the signs changes
        temp = [1,limits';limits',find(wavelength>=lim,1)]
        fluence(i).delay(k).features = wavelength(temp)
        for j = 1:size(temp,2)
            fluence(i).delay(k).integral(j) = trapz(wavelength(temp(1,j):temp(2,j)),spect_struc(i).spectra(temp(1,j):temp(2,j),k),1);
        end
        fluence(i).delay(k).PB = sum(fluence(i).delay(k).integral(fluence(i).delay(k).integral>=0));
    end
end

out = fluence;
end
        
        
        