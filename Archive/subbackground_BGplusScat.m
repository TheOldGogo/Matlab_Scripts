function out=subbackground_BGplusScat(strucin,t)

strucout = strucin;
back=mean(strucin.smootheddata(:,strucin.time>t(1)&strucin.time<t(2)),2);
figure
plot(back)
title('Background')
%%no scatter part, before t0
strucout.smootheddata(or(strucin.lam<2.2, strucin.lam>2.58),strucin.time<1.7e-6)=strucout.smootheddata(or(strucin.lam<2.2, strucin.lam>2.58),strucin.time<1.7e-6)-repmat(back(or(strucin.lam<2.2, strucin.lam>2.58)),1,size(strucin.data(or(strucin.lam<2.2, strucin.lam>2.58),strucin.time<1.7e-6),2));
%%no scatter part after t0
strucout.smootheddata(or(strucin.lam<2.2, strucin.lam>2.58),strucin.time>=1.7e-6)=strucout.smootheddata(or(strucin.lam<2.2, strucin.lam>2.58),strucin.time>=1.7e-6)+repmat(back(or(strucin.lam<2.2, strucin.lam>2.58)),1,size(strucin.data(or(strucin.lam<2.2, strucin.lam>2.58),strucin.time>=1.7e-6),2));
%%scatering
strucout.smootheddata(and(strucin.lam>=2.2, strucin.lam <= 2.58),:)=strucout.smootheddata(and(strucin.lam>=2.2, strucin.lam <= 2.58),:)-repmat(back(and(strucin.lam>=2.2, strucin.lam <= 2.58)),1,size(strucin.data(and(strucin.lam>=2.2, strucin.lam <= 2.58),:),2));
out=strucout;
