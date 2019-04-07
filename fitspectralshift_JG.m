%Inputs: data structure, and smooth variable to decide if smoothed or raw
% data is used ( 1 -> smoothedata, 0-> raw, empty ->defaultvalue smooth =1
%outputs: graph of peak position of each guassian with time
% Uncomment the block of code to determine the number of gaussians used
%Written by Ian Howard January 2008. iahoward@gmail.com
%Modified by FE
%Corrected by JG for 

function [out]=fitspectralshift_1(structin,smooth)

if nargin < 2
    smooth = 1;
end
%set up figure for goodness of fit monitoring
isgood=figure();
hold all;
tmax=8000;

shiftfig=figure();
hold all;

%sets fitting options
% fname='Gauss5';
% options=fitoptions(fname);
% options.Lower=[-0.002    1.4     0            0      1.5     0       0         1.6   0  0      1.6   0    -.002        2   0];
% options.Upper=[0         1.5     0.5          .003     1.65    .2    0.002     1.8   .5 0.002  1.9  0.5     0            2.2 1];

% fname='Gauss1';
% options=fitoptions(fname);
% options.Lower=[0 1.5 0];
% options.Upper=[1 1.9 0.7];

fname='Gauss2';
options=fitoptions(fname);
options.Lower=[   0    1.8     0.1     0         0.9      0.05];
options.Upper=[   1   2.2    2         1         1.3     .5];

% fname='Gauss3';
% options=fitoptions(fname);
% options.Lower=[    0       2      0.1     0       1.8   0.05     -5e-3    1.3     0.1  ];
% options.Upper=[    1e-2    2.3    0.5     1e-2    2     0.5      0        1.75   0.6  ];


% fname='Gauss3';
% options=fitoptions(fname);
% options.Lower=[-0.001    1.5     0.0   0        1.8    0.05     0       1.95    0.1];
% options.Upper=[0.0      1.8     0.5   0.001    2.05    .5   0.001     2.15   .5];

% fname='Gauss4';
% options=fitoptions(fname);
% options.Lower=[    0       2.15   0.1     0       2        0.05     0     1.8   0.1  -5e-3    1.3     0.1  ];
% options.Upper=[    6e-3    2.3    0.5     6e-3    2.15     0.8      1e-2  2     0.5   0        1.75   0.6  ];

% fname='Gauss4';
% options=fitoptions(fname);
% options.Lower=[    0      0.8     0.1      0       1       0.1      -1e-3     1.5     0.1   -1e-3    2      0.1  ];
% options.Upper=[    1e-3   1.25    0.5      1e-3    1.4     0.5      0         1.9     0.5    0       2.3    0.5  ]; 

for i1=1:length(structin)
    tg0=structin(i1).time(structin(i1).time>=0);
    if smooth == 1
        dg0=structin(i1).smootheddata(:,structin(i1).time>=0);
    else
        dg0=structin(i1).data(:,structin(i1).time>=0);
    end
        
    eV=structin(i1).lam%ev=1240./structin(i1).lam;
    
    for i2=1:length(tg0)
        model=fit(eV,dg0(:,i2),fname,options);
        [m(i1,i2),I(i1,i2)] = max(feval(model,eV));
        %plot every 10th fit for monitoring purposes
        if ~mod((i2-1),10)
            figure(isgood)
            plot(eV,[dg0(:,i2) feval(model,eV)])
            
        end
        a1(i1,i2)=model.a1;
        b1(i1,i2)=model.b1;
        c1(i1,i2)=model.c1;
         a2(i1,i2)=model.a2;
         b2(i1,i2)=model.b2;
         c2(i1,i2)=model.c2;
%          a3(i1,i2)=model.a3;
%          b3(i1,i2)=model.b3;
%          c3(i1,i2)=model.c3;
%          a4(i1,i2)=model.a4;
%          b4(i1,i2)=model.b4;
%          c4(i1,i2)=model.c4;
        
    end
    h = fittype('smoothingspline');
    fopts2=fitoptions('smoothingspline','SmoothingParam',.9,'Normalize','on');
    fopts.Weights=a1(tg0>0&tg0<tmax)./max(a1(tg0>0&tg0<tmax));
    b1fit=fit([1:length(tg0(tg0>-3&tg0<tmax))]',b1(i1,tg0>-3&tg0<tmax)',h,fopts2);
    b2fit=fit([1:length(tg0(tg0>-3&tg0<tmax))]',b2(i1,tg0>-3&tg0<tmax)',h,fopts2);
%     b3fit=fit([1:length(tg0(tg0>-3&tg0<tmax))]',b3(i1,tg0>-3&tg0<tmax)',h,fopts2);
%     b4fit=fit([1:length(tg0(tg0>-3&tg0<tmax))]',b4(i1,tg0>-3&tg0<tmax)',h,fopts2);
    m_posfit=fit([1:length(tg0(tg0>-3&tg0<tmax))]',eV(I(i1,tg0>-3&tg0<tmax)),h,fopts2);
    max_pos = m_posfit(1:length(tg0));
    
    
    figure(shiftfig)
    contourf(1:length(tg0),eV,dg0)
    pcolor(tg0,eV,dg0);
    shading interp;
    set(gca,'xscale','log')
    xlabel('time / ps')
    ylabel('Photon Energy / eV')
    hold on
    plot(tg0,eV(I))                             % I is the position of the max of the data (and m its value, see line 71))
    hold on
    
    %figure      
    plot(tg0, [b1(i1,:);b1fit(1:length(tg0))'])
    %set(gca,'xscale','log')
    %xlabel('time / ps')
    %ylabel('Photon Energy / eV')
    hold on
    plot(tg0, [b2(i1,:);b2fit(1:length(tg0))'])
    hold on
%     plot(tg0, [b3(i1,:);b3fit(1:length(tg0))'])
%     hold on
%     plot(tg0, [b4(i1,:);b4fit(1:length(tg0))'])
%     hold on
    %plot(tg0, eV(I(i1,:)))
    %plot(1:length(tg0(tg0<500e-9)),b2fit(1:length(tg0(tg0<500e-9))))
    out=[tg0;a1; b1; c1; a2; b2; c2; eV(I)'; m ];
    figure
    plot(tg0, [a1;m]);
    set(gca,'xscale','log')
    xlabel('time / ps')
    ylabel('Photon Energy / eV')
    
    
end


    