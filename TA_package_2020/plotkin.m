function out=plotkin(struc,lam,t,norm)
% Takes in struc,wavelength region, time region and norm variable and gives
% out data and a plotted kinetic.
% norm == 1 -> norm to max or min
% norm == 0 -> unnormed data
% norm == any timepoint, like 5e-9, data gets normalized to signal height
% at that time.
% F.E.

in.time=struc.time(struc.time>t(1)&struc.time<t(2));
in.lam=struc.lam(struc.lam>lam(1)&struc.lam<lam(2));
in.data=mean(struc.data(struc.lam>lam(1)&struc.lam<lam(2),struc.time>t(1)&struc.time<t(2)));

if norm ~= 0
    if norm == 1
        if mean(in.data) > 0
            in.data = in.data/max(in.data);
        else
            in.data = in.data/min(in.data);
        end
    else
        tmp = abs(in.time -norm);
        [~, idx] = min(tmp); 
        in.data = in.data/in.data(idx);
    end
end
%plot(linspace(struc.time(1),struc.time(end),10),zeros(1,10),'LineWidth',6,'Color','black');
semilogx(in.time,in.data,'LineWidth',2,'Color',[0 1 0]);
out=[in.time;in.data]';
xlabel('Time /ps','FontSize',12)
ylabel('\Delta T/T','FontSize',12)
%set(gca,'FontSize',12,'Box','on','LineWidth',4,'FontWeight','bold','XGrid','on',...
    %'YGrid','on','GridLineStyle','-')
set(gca,'FontSize',12,'Box','on')
xlim([in.time(1) in.time(end)]);
%ylim([0 5E-3]);
%set(gcf,'position',[1 1 1000 500]);
%set(gca,'XScale','log')

%hold off;
