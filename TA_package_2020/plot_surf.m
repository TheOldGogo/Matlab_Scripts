function plot_surf(strucin)


if isfield(strucin,'eV') == 1
    display('Conversion to eV has already been done')
else
    strucin.eV = 1240./strucin.lam;
end
    
figure
if isfield(strucin,'data_eV') == 1
    pcolor(strucin.time,strucin.eV,strucin.smootheddata_eV)
else
    pcolor(strucin.time,strucin.eV,strucin.smootheddata)
end
set(gca,'Xscale','log','Layer','top','XMinorTick','on')
shading interp
end
