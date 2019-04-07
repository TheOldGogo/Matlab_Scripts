function out=txt2struc()


    [filename, pathname, filterindex] = uigetfile( ...
    {  '*.txt','txt-files (*.txt)'; ...
       '*.cor','chirp-corrected files (*.cor)'; ...
       '*.*',  'All Files (*.*)'}, ...
       'Select Data Files to Process','C:\Dokumente\Messungen\TA', ...
       'MultiSelect', 'on');

    if iscell(filename)
        for i=1:length(filename)
            fp=[pathname filename{i}];
            process(fp, filename{i});
        end
    else
        fp=[pathname filename];
        process(fp, filename);
    end
end

function out2=process(fp,filename)
temp=load(fp,'-ascii');
t.time=temp(1,2:end);
t.lam=temp(2:end,1);
t.data=temp(2:end,2:end);
t.smootheddata=smooth2a(t.data,2);%conv2(t.data,ones(5),'same')/sum(sum(ones(5)));
assignin('base',genvarname(filename(1:end-4)),t);

end
