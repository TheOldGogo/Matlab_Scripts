function plot_spec_shift(struc_in1)


hold on;
step = 3;
start = 25;
prec = 2;
cmap = jet(floor((size(struc_in1.smootheddata,2)-start)/step)+1);
i=1;
for k=start:step:size(struc_in1.smootheddata,2)
    plot(struc_in1.lam,struc_in1.smootheddata(:,k),'color',cmap(i,:))
    i=i+1;
end
legend_double = struc_in1.time(start:step:size(struc_in1.smootheddata,2));
legend_str = num2str(legend_double(:),prec);
legend(legend_str)
xlabel('wavelength / nm')
ylabel('\DeltaT/T')

% i=1;
% for k=start:step:size(struc_in2.smootheddata,2)
%     plot(struc_in2.smootheddata(:,k),'.','color',cmap(i,:))
%     i=i+1;
% end
