function out=plotcs(c,s)
lam=1:1:size(s,2);
time=1:size(c,1);

axh1 = subplot(1,2,1);
hold(axh1,'all')
plot(lam,s);

axh2 = subplot(1,2,2);
hold(axh2,'all')
plot(time,c);