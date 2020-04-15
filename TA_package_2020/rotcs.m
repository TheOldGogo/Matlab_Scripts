function [cnew,snew]=rotcs(c,s,f1,f3,f4)

%assumes that the data is rank defficient so that spectra s2 is known

data=c*s;

rot=[f1 f3;0 f4];

snew=rot*s;
cnew=c*inv(rot);

temp=sum(snew(1,:).^2);
snew(1,:)=snew(1,:)./temp^.5;
cnew(:,1)=cnew(:,1).*temp^.5;

% c1new=(1/f1*f4)*(f4*c(:,1)-f3*c(:,2));
% c2new=f1*c(:,2);
% 
% s1new=f1*s(1,:);
% s2new=f3*s(1,:)+f4*s(2,:);
% 
% cnew=[c1new c2new];
% snew=[s1new; s2new];
% 
 datanew=cnew*snew;
 sum(sum(data-datanew));
 
%  dev_old = sum(sum((org_data-data).^2));
%  dev_new = sum(sum((org_data-datanew).^2));
%  disp(['Deviation of initial solution from experimental data: ',num2str(dev_old)])
%  disp(['Deviation of rotated solution from experimental data: ',num2str(dev_new)])

% if sum(sum(data-datanew));
%     disp('this did not work')
% end

