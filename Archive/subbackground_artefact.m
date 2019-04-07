function out=subbackground_artefact(strucin,t)

strucout = strucin;
back=mean(strucin.smootheddata(:,strucin.time>t(1)&strucin.time<t(2)),2);
figure
plot(back)
title('Background')
strucout.smootheddata(:,strucin.time<1.7e-6)=strucout.smootheddata(:,strucin.time<1.7e-6)-repmat(back,1,size(strucin.data(:,strucin.time<1.7e-6),2));
strucout.smootheddata(:,strucin.time>1.7e-6)=strucout.smootheddata(:,strucin.time>1.7e-6)+repmat(back,1,size(strucin.data(:,strucin.time>1.7e-6),2));
out=strucout;
