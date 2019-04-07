function out = eVtonm(dirname,sample,endname,offset,coeff)
% 1/ eVtonm create an ascii file readable by CarpetView:
% means:    lines = one delay
%           column = spectral position in nm
% so transposed and converted to nm compared to our original data
% 2/ additionally you can correct for bad calibration with "offset" and
% "coeff" optional arguments: New_eV = old_eV*coeff + offset
% the transposed ascii file has the same name but extension ".lam"


if ~exist('offset','var')
    offset = 0
end

if ~exist('coeff','var')
    coeff = 1
end


fnames=dir(dirname);

j=1;
for i=1:length(fnames)
    if strfind(fnames(i).name,endname)
        if strfind(fnames(i).name,sample)
        txtfnames(j)=fnames(i)
        j=j+1;
        end
    end
end





for i=1:length(txtfnames)
    fp = [dirname filesep() txtfnames(i).name];
    
    temp=load(fp,'-ascii');
        t.time=temp(1,2:end);
        t.Energy=temp(2:end,1)*coeff+offset;
        t.lam = (1240./t.Energy);
        t.data=temp(2:end,2:end);
        
    fp = [dirname filesep() txtfnames(i).name(1:end-3)];
    
    fID = fopen([fp 'lam'],'w'); 
        fprintf(fID, [repmat('%0.5g \t', [1,size(t.lam,1)+1]) '\r\n'],[0 fliplr(t.lam')]);
        fprintf(fID, ['%0.5g \t' repmat('%0.5g \t', [1,size(t.lam,1)]) '\r\n'],[t.time' fliplr(t.data')]');
    fclose(fID);
end
