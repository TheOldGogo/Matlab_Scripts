function [f]=fmaxmin(t,c,s,imaxmin,ioptim,ig,clos,cknown,sknown,nexp);
% function [f,g]=fmaxmin0(t,c,s,imaxmin,ioptim,ig,clos,cknown,nexp);

[nrow,nsign]=size(c);
if ig(1,1)==3,t=tconv(t,nsign);end

snew=t*s;
cnew=c/t;
tnorm=norm(cnew*snew,'fro'); % Original code
for k=1:1:size(cnew,2)  % Added to calculated the relative signal contribution
    n(k)=norm(cnew(:,k)*snew(k,:),'fro');
end
fnorm=sum(n);% Added to calculated the relative signal contribution
%fnorm=norm(c(:,ioptim)*s(ioptim,:),'fro'); 


% scalar funtion to be optimimized

if imaxmin==1,
    f=-norm(cnew(:,ioptim)*snew(ioptim,:)/tnorm,'fro'); %maximum band
    %f=-norm(fnorm/tnorm,'fro'); %maximum band
end
if imaxmin==2,
 	f=norm(cnew(:,ioptim)*snew(ioptim,:)/tnorm,'fro'); %minimum band
    %f=norm(fnorm/tnorm,'fro');
end

% if abs(f)>1
%    disp('bullshit happened')
% end