%% Julien - KAUST - KSC - 30-01-2020
% This script is supposed to open a result file of a setfos simulation of a
% device with an emiter sandwiched between two absorbers, and extract the
% emitted spectra for some condition. Basically, the calculation in Setfos
% was done for all possible combination of absorber thicknesses (within
% some bopundaries) and we want to keep only the cases for which sum of the
% absorber thicknesses is equal to a certain value

function chosen_ones = extract_relevant_data(file, thickness)

%first open the files

temp = importdata(file,'\t',15);
total_thickness = temp(:,1)+temp(:,2);
keep = ((total_thickness - thickness) == zeros(size(total_thickness)));
thickness_sub = temp(keep,1);
thickness_sup = temp(keep,2);
wavelength = temp(keep,3);
LightOut = temp(keep,15);

chosen_ones = [thickness_sub, thickness_sup, wavelength, LightOut]


