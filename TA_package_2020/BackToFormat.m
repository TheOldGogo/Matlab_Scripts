function out = BackToFormat(dirname,sample,endname,time)
% 1/ Takes all the files you want and retransposes them
% so from times in lines and energies in columns
% to times in columns and energies in lines
% 2/ Interpolates the time values to the original timepoint (contained in the "time" imput)
% 3/ saves as a ".corr" file



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
%get the data
fp = [dirname filesep() txtfnames(i).name];
    
    temp=load(fp,'-ascii');
        t.time=temp(2:end,1);
        t.Energy=temp(1,2:end);     
        t.data=temp(2:end,2:end);

%interpolates the data
    data = interp1(t.time,t.data,time(2:end-1)', 'nearest', 'extrap');

%saves the data (transposed)
        
    fp = [dirname filesep() txtfnames(i).name(1:end-3)];
    
    fID = fopen([fp 'corr'],'w'); 
        fprintf(fID, [repmat('%0.5g \t', [1,size(time,2)-1]) '\r\n'],[0 time(2:end-1)]);
        fprintf(fID, ['%0.5g \t' repmat('%0.5g \t', [1,size(time,2)-2]) '\r\n'],[t.Energy' data']');
    fclose(fID);
end
