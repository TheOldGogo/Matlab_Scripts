%% JG 2019-04-14: Added the zero line on the spectra (+ grid)
% And also the title and axis

function out=plotcs(c,s, time_axis, spectr_axis)

n_fluences = size(c,1)/length(time_axis);

if ~exist('spectr_axis', 'var')
    lam=1:1:size(s,2);
else 
    lam = spectr_axis;
end

if ~exist('time_axis','var')
    time=1:size(c,1);
else 
    time = repmat(time_axis,1,n_fluences);
end
    
axh1 = subplot(1,2,1);
%hold(axh1,'all')
plot(lam,s);
axis tight;
line(xlim(), [0,0], 'Color', 'k');
grid on;
xlabel('Energy (eV)');
ylabel('Signal (Norm.)');

axh2 = subplot(1,2,2);
%hold(axh2,'all');
semilogx(time,c);
axis tight;
set(gca, 'xtick', [1,10,100,1000,10000]);
set(gca, 'xticklabel', {'1 ps','10 ps','100 ps', '1 ns', '10 ns'});
xlabel('Time');
ylabel('Density (Arb. Unit)');