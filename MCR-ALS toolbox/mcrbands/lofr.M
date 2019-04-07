function [sigma]=lofr(de,c,s)
% function [sigma]=lof(de,c,s)

[nr,nc]=size(de);
[nr,ns]=size(c);
dr=c*s;
res=de-dr;
sst1=sum(sum(res.*res));
sst2=sum(sum(de.*de));
sigma=(sqrt(sst1/sst2))*100;
r2=(sst2-sst1)/sst2;
%disp(['lof in sd (%) = ',num2str(sigma)]);
% disp(['fit in var (%) = ',num2str(r2*100)]);
% disp(['R square is = ',num2str(r2)]);
%fprintf(1,'Rsquare is %15.12f\n',r2')
disp([ ])

