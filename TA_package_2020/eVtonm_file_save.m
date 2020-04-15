function out = eVtonm(dirname,sample,endname)

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
        t.time=temp(1,2:end)
        t.Energy=temp(2:end,1)
        t.lam = (1240./t.Energy)
        t.data=temp(2:end,2:end)
        
        t.data(find( ~isfinite(t.data))) = 0;  % find the infinite data and replace it by 0
        
    fp = [dirname filesep() txtfnames(i).name(1:end-3)];
    
    fID = fopen([fp 'lam'],'w'); 
        fprintf(fID, [repmat('%0.5g \t', [1,size(t.lam,1)+1]) '\r\n'],[0 fliplr(t.lam')]);
        fprintf(fID, ['%0.5g \t' repmat('%0.5g \t', [1,size(t.lam,1)]) '\r\n'],[t.time' fliplr(t.data')]');
    fclose(fID);
end
