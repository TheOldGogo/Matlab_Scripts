%% JG: created on 2019-04-14. If it works it should carry out multiple  
% function out = rotnplotcs(c,s,range, time_axis, spectr_axis)
% rotation of MCR results (spec 1 rotates around spec 2), display the results
% and return them in a structure
% it works


function out = rotnplotcs(c,s,range, time_axis, spectr_axis)

rotatedcs_struc(1:length(range)) = struct('rot',0,'cnew',zeros(size(c)), 'snew', zeros(size(s)));

figure()
plotcs(c,s,time_axis, spectr_axis);
suptitle('original MCR result');



for i = 1:length(range)
    rotatedcs_struc(i).rot = range(i);
    [rotatedcs_struc(i).cnew,rotatedcs_struc(i).snew] = rotcs(c,s,1,range(i),1);
    figure()
    plotcs(rotatedcs_struc(i).cnew,rotatedcs_struc(i).snew, time_axis, spectr_axis)
    suptitle(['rot = ', num2str(range(i))])
end

out = rotatedcs_struc;

end