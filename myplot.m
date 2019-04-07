function out=myplot(struc,lam,t)

underset=2;

in.time=struc.time(struc.time>t(1)&struc.time<t(2));
in.lam=struc.lam(struc.lam>lam(1)&struc.lam<lam(2));
in.data=struc.data(struc.lam>lam(1)&struc.lam<lam(2),struc.time>t(1)&struc.time<t(2));


out=surf(in.time,in.lam,in.data);
set(out,'FaceAlpha',0.5,'EdgeColor','flat')
%set(gca,'XScale','log')
xlabel('Time /ps')
ylabel('Wavelength /nm')
zlabel('\Delta T/T')

hold all;
ns=zeros(length(in.time),length(in.lam))+ min(in.data(:))*underset;
under=surf(in.time,in.lam,ns',in.data);
set(under,'LineStyle','none')
end