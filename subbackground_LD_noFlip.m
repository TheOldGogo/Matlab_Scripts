function out=subbackground(strucin,t)

strucout = strucin;
back=mean(strucin.smootheddata(:,strucin.time>t(1)&strucin.time<t(2)),2);
figure
plot(back)
title('Background')
strucout.smootheddata=strucout.smootheddata-repmat(back,1,size(strucin.data,2));
strucout.data=strucout.data-repmat(back,1,size(strucin.data,2));
out=strucout;
