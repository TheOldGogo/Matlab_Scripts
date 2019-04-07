function struc_out = back_corr(struc_in,time)

% Substracts background
struc_out = struc_in;
background = mean(struc_in.smootheddata(:,struc_in.time>time(1)&struc_in.time<time(2)),2);

struc_out.data = struc_out.data - repmat(background,1,size(struc_in.data,2));
struc_out.smootheddata = struc_out.smootheddata - repmat(background,1,size(struc_in.smootheddata,2));
plot(background)

