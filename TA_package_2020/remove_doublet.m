function out = remove_doublet(dirname,sample,endname)

fnames=dir(dirname)

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
        t.data=temp(2:end,2:end)

    duplicate_index=find(t.time==t.time([2:end 1]))
    t.time(duplicate_index+1)=[];
    t.data(:,duplicate_index) = 0.5 * (t.data(:,duplicate_index) + t.data(:,duplicate_index+1));
    t.data(:,duplicate_index+1) = [];

    fp = [dirname filesep() txtfnames(i).name(1:end-4)]

    fID = fopen([fp '_NDP.txt'],'w'); 
        fprintf(fID, [repmat('%0.5g \t', [1,size(t.time,2)+1]) '\r\n'],[0 t.time]);
        fprintf(fID, ['%0.5g \t' repmat('%0.5g \t', [1,size(t.time,2)]) '\r\n'],[t.Energy t.data]');
    fclose(fID); 
    
end

