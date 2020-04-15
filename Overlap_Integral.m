%% 2019-11-25 JG: Overlap integral to calculate FRET transfer, integrals, radii, rates, and so on.
%% Returns??
%% Imputs??

function out = Overlap_Integral(wavelength_PL, donor_PL, wavelength_abs, acceptor_extn_coeff, wavelength_n, ref_index)

wavelength = wavelength_abs;                                                % reference wavelength axis is gonna be the absorption one
PL_interp = interp1(wavelength_PL, donor_PL, wavelength,'linear', 0);       % interpolates the PL on the wavelength axis of the extinction coeff, extrapolated to zero if N/D
norm_PL = PL_interp/ trapz(PL_interp,wavelength);                           % normalized PL (in area).

stuff_to_integrate = acceptor_extn_coeff .* wavelength.^4 .* norm_PL;
result = trapz(stuff_to_integrate, wavelength);

out = result;

if (nargin == 6)
    
    n_interp = interp1(wavelength_n, ref_index, wavelength, 'linear', 'extrap');
    n_weighted = trapz(stuff_to_integrate.*n_interp,wavelength)/result;
    out = {result, n_weighted,stuff_to_integrate};
end



end