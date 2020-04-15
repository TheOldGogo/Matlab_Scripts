function varargout = drawchirp(varargin)
% DRAWCHIRP M-file for drawchirp.fig
%      DRAWCHIRP, by itself, creates a new DRAWCHIRP or raises the existing
%      singleton*.
%
%      H = DRAWCHIRP returns the handle to a new DRAWCHIRP or the handle to
%      the existing singleton*.
%
%      DRAWCHIRP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DRAWCHIRP.M with the given input arguments.
%
%      DRAWCHIRP('Property','Value',...) creates a new DRAWCHIRP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before drawchirp_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to drawchirp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help drawchirp

% Last Modified by GUIDE v2.5 25-Apr-2016 16:53:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @chirpcorrectionlx_OpeningFcn, ...
                   'gui_OutputFcn',  @chirpcorrectionlx_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before drawchirp is made visible.
function chirpcorrectionlx_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to drawchirp (see VARARGIN)


handles.data = [0];
handles.time = 1;
handles.lambda= 1;
handles.number_dp =0;
handles.chirp_lambda=[];
handles.chirp_time=[];
handles.chirp_timefit=[];
handles.time_shft=[];
handles.data_shft=[];
handles.filename='';
handles.spectra=[];
handles.spectra_time=[];
handles.kinetics=[];
handles.kinetics_lambda=[];
%handles.sdir='0';
%Sebastians versions of defining handles.sdir.

%v1
%handles.sdir='Y:\FastLab\Sebastian\Blends for Richard\charge generation 22feb07\'; %put working directory here ending with \

%v2
% prompt = {'Directory of data'};
% dlg_title = 'Enter ending with \';
% num_lines = 1;
% def = {'Y:\FastLab\Sebastian\Blends for Richard\charge generation 22feb07\'};
% sdir = inputdlg(prompt,dlg_title,num_lines,def);
% sdir=sdir{1};
% handles.sdir=sdir;

% Ians version of definin handles.sdir
% handles.sdir=strcat(uigetdir,'\')

handles.sdir='C:\Dokumente\Messungen\TA';

% Choose default command line output for drawchirp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using drawchirp.
if strcmp(get(hObject,'Visible'),'off')
    plot(rand(5));
end

% UIWAIT makes drawchirp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = chirpcorrectionlx_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in plot.
function [temp, temp_limits]=plot_Callback(hObject, eventdata, handles)
% hObject    handle to plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
%cla;
hold off
t_l=str2double(get(handles.fromtime,'String'));
t_h=str2double(get(handles.totime,'String'));
l_l=str2double(get(handles.fromlambda,'String'));
l_h=str2double(get(handles.tolambda,'String'));

temp=0;
temp_limits=0; %Initialise return values in case not assigned later (only used for multiple time slices)
corrected=get(handles.corrected,'value');
if corrected==0
    time_ps=handles.time;
    lambda_nm=handles.lambda;
    data=handles.data;
else
    time_ps=handles.time_shft;
    lambda_nm=handles.lambda;
    data=handles.data_shft;
end


x=0;

popup_sel_index = get(handles.popupmenu3, 'Value');
switch popup_sel_index
    case 1
        contourf(time_ps(time_ps>t_l&time_ps<t_h), lambda_nm(lambda_nm>l_l&lambda_nm<l_h), data(lambda_nm>l_l&lambda_nm<l_h,time_ps>t_l&time_ps<t_h));
    case 2
        figure(1)
        mesh(time_ps(time_ps>t_l&time_ps<t_h), lambda_nm(lambda_nm>l_l&lambda_nm<l_h), data(lambda_nm>l_l&lambda_nm<l_h,time_ps>t_l&time_ps<t_h));
        colorbar
        axis tight
    case 3
        plot(lambda_nm(lambda_nm>l_l&lambda_nm<l_h),data(lambda_nm>l_l&lambda_nm<l_h,(time_ps>t_l&time_ps<t_h))');
    case 4
        if get(handles.holdon,'Value')==1
            hold on
            temp=handles.spectra;
            new_spec=mean(data(lambda_nm>l_l&lambda_nm<l_h,(time_ps>t_l&time_ps<t_h)),2);
            if get(handles.normspec,'Value')==1
                new_spec=new_spec/max(new_spec(1:end/4));
            end
            temp=[lambda_nm(lambda_nm>l_l&lambda_nm<l_h) temp(:,2:end) new_spec];
            handles.spectra=temp;
            handles.spectra_time=[handles.spectra_time [t_l;t_h]];
        else 
            hold off
            spec=mean(data(lambda_nm>l_l&lambda_nm<l_h,(time_ps>t_l&time_ps<t_h)),2);
            if get(handles.normspec,'Value')==1
                spec=spec/max(spec(1:end/4));
            end
            temp=[lambda_nm(lambda_nm>l_l&lambda_nm<l_h) spec];
            handles.spectra_time=[t_l;t_h];    
        end
         plot(temp(:,1),temp(:,2:end)); 
         temp_limits=handles.spectra_time; %to pass back to time slices if plotting multiple slices in one call
     case 5
        plot(time_ps(time_ps>t_l&time_ps<t_h),data(lambda_nm>l_l&lambda_nm<l_h,(time_ps>t_l&time_ps<t_h)));
     case 6
         kin=mean(data(lambda_nm>l_l&lambda_nm<l_h,(time_ps>t_l&time_ps<t_h)))';
         if get(handles.normkin,'Value')==1
             max(abs(kin))*sign(mean(kin))
             kin=kin/max(abs(kin))*sign(mean(kin));
         end
             
        if get(handles.holdon,'Value')==1
            hold on
            temp=handles.kinetics;
            temp=[time_ps(time_ps>t_l&time_ps<t_h)' temp(:,2:end) kin];
            handles.kinetics=temp;
            handles.kinetics_lambda=[handles.kinetics_lambda [l_l;l_h]];    
        else 
            hold off
            temp=[time_ps(time_ps>t_l&time_ps<t_h)' kin];
            handles.kinetics=temp;
            handles.kinetics_lambda=[l_l;l_h];    
        end
        if t_l>0
            semilogx(temp(:,1),temp(:,2:end));
        else
            plot(temp(:,1),temp(:,2:end));
        end
        temp_limits=handles.kinetics_lambda;
         
end
guidata(hObject, handles)
size(handles.spectra)
function plotchirp_Callback(hObject, eventdata, handles)
% hObject    handle to plotchirp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

chirp_time=handles.chirp_time;
chirp_lambda=handles.chirp_lambda;
chirp_timefit=handles.chirp_timefit;
lambda_nm=handles.lambda;
%plot chirp if it is loaded
if ~isempty(chirp_timefit)&~isempty(chirp_time)&~isempty(chirp_lambda)
    hold on
    plot(chirp_time,chirp_lambda,'k.','markersize',30);
    plot(chirp_timefit,lambda_nm,'k-','Linewidth',2);
end

function loaddata_Callback(h0bject, eventdata, handles)
% hObject    handle to plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Sebastians version of getting filename

% prompt = {'filename?'};
% dlg_title = 'Choose datafile';
% num_lines = 1;
% def = {'60uW0Vspec1.Dtc'};
% answer = inputdlg(prompt,dlg_title,num_lines,def);
%filename = answer{1,1};

    [filename, pathname, filterindex] = uigetfile( ...
       {'*.txt', 'txt files (*.txt)';'*.Dtc','DTC files (*.Dtc)';'*.ddt','full file (*.ddt)';'*.cor','chirp corrected (*.cor)'}, ...
        'Pick a file', ...
        handles.sdir, ...
        'MultiSelect', 'off');

%get the file a name..
handles.sdir=pathname;

data = load ([pathname '\' filename]);

set(handles.text10,'String',filename);

%get wavelength and time from the matrix
lambda_nm = data(:,1);

%deal with time that has zero appended to beginning of row or not, depends
%on version of front panel

if data(1,1)==0
    time_ps=data(1,2:end);
else
    time_ps = data (1,:);
end

%delete these from data
data(:,1)=[];
data(1,:)=[];

%re-size lambda and time
[m,n]=size(data);
time_ps = time_ps(1:n);
lambda_nm = lambda_nm(2:m+1);

handles.data=data;
handles.time=time_ps;
handles.lambda=lambda_nm;
handles.filename=filename;
set(handles.corrected,'value',0);
set(handles.fromlambda,'String',num2str(ceil(min(lambda_nm))));
set(handles.tolambda,'String',num2str(floor(max(lambda_nm))));
set(handles.fromtime,'String','-4');
set(handles.totime,'String','4');

%plot_Callback(hObject, eventdata, handles);

guidata(h0bject, handles);


% --- Executes on button press in drawchirp.
function drawchirp_Callback(hObject, eventdata, handles)
% hObject    handle to drawchirp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

prompt = {'How many datapoints'};
dlg_title = 'suggested: 5 - max 10';
num_lines = 1;
def = {'8'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
number_dp=str2num(answer{1,1});
%restrict the maximum number of data points that can be drawn
if number_dp>20
    number_dp=20;
end
%draw chrip points with mouse
[chirp_time,chirp_lambda]=ginput(number_dp);
hold on
plot(chirp_time,chirp_lambda,'k.','markersize',30)

%save chrip data
handles.number_dp=number_dp;
handles.chirp_time=chirp_time;
handles.chirp_lambda=chirp_lambda;
guidata(hObject, handles);

% --- Executes on button press in savechirp.
function savechirp_Callback(hObject, eventdata, handles)
% hObject    handle to savechirp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

chirp_time=handles.chirp_time;
chirp_lambda=handles.chirp_lambda;
chirp_timefit=handles.chirp_timefit;
lambda_nm=handles.lambda;

if ~isempty(chirp_time)&~isempty(chirp_lambda)&~isempty(chirp_timefit)
    savechirp=[lambda_nm chirp_timefit];
    sdir=handles.sdir;
    save([sdir 'chirp.txt'],'savechirp','-ascii','-tabs');
    %savechirpfit=[lambda_nm chirp_timefit];
    %save chirp.txf savechirp -ascii -tabs;
end

% --- Executes on button press in fitchirp.
function fitchirp_Callback(hObject, eventdata, handles)
% hObject    handle to fitchirp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

chirp_time=handles.chirp_time;
chirp_lambda=handles.chirp_lambda;
lambda_nm=handles.lambda;

mymodel = fittype('a+b*x^(-2)');
%fit user defined points
[fit1,gof1,out1] = fit(chirp_lambda,chirp_time,'poly3');
time_chirp=feval(fit1,lambda_nm);

hold on
plot(time_chirp,lambda_nm,'k-','Linewidth',2)

%save tau_chirp to ahndles
handles.chirp_timefit=time_chirp;
guidata(hObject, handles);

% --- Executes on button press in loadchirp.
function loadchirp_Callback(hObject, eventdata, handles)
% hObject    handle to loadchirp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

prompt = {'chirp filename?'};
dlg_title = 'Choose chirpfile';
num_lines = 1;
def = {'chirp.txt'};
answer = inputdlg(prompt,dlg_title,num_lines,def);

sdir=handles.sdir;
file=answer{1,1};
xy=load([sdir file]);

chirp_time=xy(:,2);
chirp_lambda=xy(:,1);

handles.chirp_lambda=chirp_lambda;
handles.chirp_time=chirp_time;
guidata(hObject, handles)

hold on
plot(chirp_time,chirp_lambda,'k.','markersize',30)

% --- Executes on button press in correctchirp.
function correctchirp_Callback(hObject, eventdata, handles)
% hObject    handle to correctchirp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

time_pss=handles.time;
lambda_nm=handles.lambda;
datas=handles.data;
chirp_timefit=handles.chirp_timefit;

if get(handles.overridechirp,'Value')==0
    %1. interpolate data to smallest step size in chirp region

    tau_ch_from=min(chirp_timefit);
    tau_ch_to=max(chirp_timefit);
    tau_reg=abs(tau_ch_to-tau_ch_from)*10; %10 times the chrip region in abs(time) 
    
    %cut data to chirp region ----> after correction is done put missing
    %sections back on
    time_ps=time_pss(time_pss<tau_reg);
    data=datas(:,time_pss<tau_reg);
    
    time_ch=time_ps(time_ps>tau_ch_from&time_ps<tau_ch_to);
    smallstep = min(time_ch(2:end)-time_ch(1:end-1)); %edited max changed to min
    if isempty(smallstep)
        smallstep=0.1;
    end
    time_ps
    time_shft = [min(time_ps):smallstep:max(time_ps)]; %makes the time stepsize in the whole chirp correction region into the smallest stepsize present
    
    data_ipol = (interp1(time_ps,data',time_shft))'; %interpolates the data to this new small time stepsize
    lambda_num=length(lambda_nm);
    time_num=length(time_shft);

    dt=round(chirp_timefit./smallstep); %indices of shifts

    chirp_max = max(dt); %next few lines are from Jennys program
    dt = dt + abs(min(dt)); %put zero to point 1.
    dt = dt - 2*dt;  %turn it upside down
    chirp_min = min(dt);
    dt = dt - chirp_min;   %put it to zero again..
    
    points_max = max(dt)+time_num;    % values to be used
    data_shft = zeros(lambda_num, points_max);   % create a matrix of the correct size

    for n=1:lambda_num
        data_shft(n,1+dt(n):dt(n)+time_num)=data_ipol(n,:);
    end  

    %make new time axis
    taddon=max(time_shft)+smallstep*[1:max(dt)]
    time_shft=[time_shft taddon]
%     t_min=min(time_shft);
%     t_max=max(time_shft+);
%     t_min=t_min-max(chirp_timefit);
%     t_max=t_max-min(chirp_timefit);
%     time_shft=[t_min:smallstep:t_max];
    

    %%reduce size of matrix smaller from -10:+10 small step size
    %[I,cutoff1]=min((time_shft-10).^2);
    %data_shft(:,round(cutoff1:1.10:end))=[];
    %time_shft(round(cutoff1:1.10:end))=[];
    
    %put everything outside the chrip region*10 back into the array
    time_shft=[time_shft(1:end-max(dt)) time_pss(time_pss>tau_reg)];
    data_shft=[data_shft(:,1:end-max(dt)) datas(:,time_pss>tau_reg)];
    
    size(time_shft)
    size(data_shft)

    data_shft=interp1(time_shft,data_shft',time_pss)';
    
    %save data to handles
    handles.data_shft=data_shft;
    handles.time_shft=time_pss;
    set(handles.corrected,'value',1);
    set(handles.fromtime,'String','-10');
    set(handles.totime,'String','10');

else
    
    handles.data_shft=data;
    handles.time_shft=time_ps;
    set(handles.corrected,'value',1);

end
guidata(hObject, handles);

%plot data
t_l=str2double(get(handles.fromtime,'String'));
t_h=str2double(get(handles.totime,'String'));
l_l=str2double(get(handles.fromlambda,'String'));
l_h=str2double(get(handles.tolambda,'String'));


plot_Callback(hObject, eventdata, handles);


% --- Executes on button press in savedata.
function savedata_Callback(hObject, eventdata, handles)
% hObject    handle to savedata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
corrected=get(handles.corrected,'value');

lambda_nm=handles.lambda;
filename=handles.filename;
filename2=[filename(1:end-3) 'cor'];

if corrected==0
    data=handles.data;
    time=handles.time;
else
    data=handles.data_shft;
    time=handles.time_shft;
end
savedata=[lambda_nm data];
savedata=[[0 time];savedata];
sdir=handles.sdir;
save([sdir filename2],'savedata','-ascii','-tabs')

% --- Executes on button press in addplot.
function addplot_Callback(hObject, eventdata, handles)
% hObject    handle to addplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

saveholdon(hObject, eventdata, handles)
plot_Callback(hObject, eventdata, handles);


function saveholdon(hObject, eventdata, handles)
set(handles.holdon,'Value',1);
guidata(hObject, handles);

% --- Executes on button press in savespec.
function savespec_Callback(hObject, eventdata, handles)
% hObject    handle to savespec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=handles.spectra;
temp_time=handles.spectra_time;
temp_time=[[0;0] temp_time];
temp=[temp_time;temp]
if get(handles.normspec,'Value')==1
    filename=[handles.filename(1:end-4) 'norm.spe'];
else
    filename=[handles.filename(1:end-4) '.spe'];
end
sdir=handles.sdir;
save([sdir filename],'temp','-ascii','-tabs');

% --- Executes on button press in savekin.
function savekin_Callback(hObject, eventdata, handles)
% hObject    handle to savekin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp=handles.kinetics;
temp_time=handles.kinetics_lambda;
temp_time=[[0;0] temp_time];
temp=[temp_time;temp]
if get(handles.normspec,'Value')==1
    filename=[handles.filename(1:end-4) 'norm.kin'];
else
    filename=[handles.filename(1:end-4) '.kin'];
end

sdir=handles.sdir
save([sdir filename],'temp','-ascii','-tabs');

 %--- Executes on button press in subback.
function subback_Callback(hObject, eventdata, handles)
% hObject    handle to subback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
corrected=get(handles.corrected,'value');
if corrected == 0
    data=handles.data;
else
    data=handles.data_shft;
end

time_ps=handles.time;
lambda_nm=handles.lambda;
temp=str2num(get(handles.tauback,'String'));
sub=mean(data(:,time_ps<temp)')';
figure(2)
plot(lambda_nm,sub);
title('background subtraction')
sub=repmat(sub,[1 length(time_ps)]);
data=data-sub;

if corrected == 0
    handles.data=data;
else
    handles.data_shft=data;
end
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function fromtime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fromtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function fromtime_Callback(hObject, eventdata, handles)
% hObject    handle to fromtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fromtime as text
%        str2double(get(hObject,'String')) returns contents of fromtime as a double

% --- Executes during object creation, after setting all properties.
function totime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to totime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function totime_Callback(hObject, eventdata, handles)
% hObject    handle to totime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of totime as text
%        str2double(get(hObject,'String')) returns contents of totime as a double

% --- Executes during object creation, after setting all properties.
function tolambda_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tolambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function tolambda_Callback(hObject, eventdata, handles)
% hObject    handle to tolambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tolambda as text
%        str2double(get(hObject,'String')) returns contents of tolambda as a double

% --- Executes during object creation, after setting all properties.
function fromlambda_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fromlambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function fromlambda_Callback(hObject, eventdata, handles)
% hObject    handle to fromlambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fromlambda as text
%        str2double(get(hObject,'String')) returns contents of fromlambda as a double

% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.


function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on button press in corrected.
function corrected_Callback(hObject, eventdata, handles)
% hObject    handle to corrected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of corrected


% --- Executes on button press in holdon.
function holdon_Callback(hObject, eventdata, handles)
% hObject    handle to holdon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of holdon


%


% --- Executes on button press in overridechirp.
function overridechirp_Callback(hObject, eventdata, handles)
% hObject    handle to overridechirp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of overridechirp


% --- Executes during object creation, after setting all properties.
function tauback_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tauback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function tauback_Callback(hObject, eventdata, handles)
% hObject    handle to tauback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tauback as text
%        str2double(get(hObject,'String')) returns contents of tauback as a double


% --- Executes on button press in normkin.
function normkin_Callback(hObject, eventdata, handles)
% hObject    handle to normkin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of normkin




% --- Executes on button press in Smooth.  Removes NANs and INFs from the
% loaded data. Replaces them with zero.  Smooths data points by looking at 
% adjacent data points
function Smooth_Callback(hObject, eventdata, handles)
% hObject    handle to Smooth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

corrected=get(handles.corrected,'value');
if corrected == 0
    data=handles.data;
else
    data=handles.data_shft;
end
data(isnan(data))=0;
data(isinf(data))=0;

dimensions=size(data);
for i=1:dimensions(1)
    neighbours_i=[];
    if i>1 
        neighbours_i=i-1;
    end
    if i < dimensions(1)
        neighbours_i=[neighbours_i i+1];
    end
    for j=1:dimensions(2)
        neighbours_j=[];
        if j>1 
        neighbours_j=[neighbours_j j-1];
        end
        if j < dimensions(2)
        neighbours_j=[neighbours_j j+1];
        end
   %     neighbours=[data(i,neighbours_j) (data(neighbours_i,j))'];
        neighbours=data(neighbours_i,neighbours_j);
        if numel(neighbours)==4
            neighbours=reshape(neighbours,1,4);
        end
        neighbour_avg=mean(neighbours);
        neighbour_std=std(neighbours);
        if abs(data(i,j)-neighbour_avg)>std(neighbours)
            data(i,j)=mean(neighbours);
        end
    end
end
if corrected == 0
    handles.data=data;
else
    handles.data_shft=data;
end

plot_Callback(hObject, eventdata, handles);

guidata(hObject,handles);

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over tauback.
function tauback_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to tauback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function tauflip_Callback(hObject, eventdata, handles)
% hObject    handle to tauflip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tauflip as text
%        str2double(get(hObject,'String')) returns contents of tauflip as a double


% --- Executes during object creation, after setting all properties.
function tauflip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tauflip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in Zerotime.
function Zerotime_Callback(hObject, eventdata, handles)
% hObject    handle to Zerotime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
corrected=get(handles.corrected,'value');
if corrected == 0
    time=handles.time;
else
    time=handles.time_shft;
end
temp=str2num(get(handles.tauback,'String'));

time=time-temp;

if corrected == 0
    handles.time=time;
else
    handles.time_shft=time;
end
plot_Callback(hObject, eventdata, handles);
guidata(hObject,handles);


% --- Executes on button press in Timeslices.
function Timeslices_Callback(hObject, eventdata, handles)
% hObject    handle to Timeslices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.holdon,'Value',0);
set(handles.popupmenu3,'Value',4);

if get(handles.LongDelayBox,'Value')==1
    delayfactor=1e-9;
else
    delayfactor=1;
end

x1=str2num(get(handles.fromtime2,'String'))*delayfactor;
y1=str2num(get(handles.totime2,'String'))*delayfactor;
x2=str2num(get(handles.lastslice,'String'));

t_l=[x1, logspace(0,log10(x2),8)*delayfactor] %x1 used to be -100, x2=3000
t_h=[y1, t_l(2:end)*1.5] %y1 used to be -5

for i=1:length(t_h)
    set(handles.fromtime,'String',num2str(t_l(i)));
    get(handles.fromtime,'String');
    set(handles.totime,'String',num2str(t_h(i)));
    get(handles.totime,'String');
    guidata(hObject, handles);
    [handles.spectra,handles.spectra_time]=plot_Callback(handles.plot, eventdata, handles);
    guidata(hObject, handles);
    set(handles.holdon,'Value',1);
  
end


% --- Executes on button press in Kinetics.
function Kinetics_Callback(hObject, eventdata, handles)
% hObject    handle to Kinetics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.holdon,'Value',0);
set(handles.popupmenu3,'Value',6);
prompt = {'l_l1','l_h1','l_l2','l_h2','l_l3','l_h3'};
dlg_title = 'Wavelength intervals for kinetics';
num_lines = 1;
if handles.def{1}==' '
    handles.def={'510','550','590','600','650','660'};
end

%def = {'510','550','590','600','650','660'}; %default values for all fields, must be strings


answer = inputdlg(prompt,dlg_title,num_lines,handles.def);
l_l(1)=str2num(answer{1,1});
l_h(1)=str2num(answer{2,1});
l_l(2)=str2num(answer{3,1});
l_h(2)=str2num(answer{4,1});
l_l(3)=str2num(answer{5,1});
l_h(3)=str2num(answer{6,1});

handles.def={answer{1,1},answer{2,1},answer{3,1},answer{4,1},answer{5,1},answer{6,1}}

for i=1:3
    set(handles.fromlambda,'String',num2str(l_l(i)));
    set(handles.tolambda,'String',num2str(l_h(i)));
    guidata(hObject, handles);
    [handles.kinetics,handles.kinetics_lambda]=plot_Callback(handles.plot, eventdata, handles);
    guidata(hObject, handles);
    set(handles.holdon,'Value',1);
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over plot.


% --- Executes during object creation, after setting all properties.
function Smooth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Smooth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function Correctsignflip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Correctsignflip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function subback_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.def={' '};
guidata(hObject, handles);



function fromtime2_Callback(hObject, eventdata, handles)
% hObject    handle to fromtime2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fromtime2 as text
%        str2double(get(hObject,'String')) returns contents of fromtime2 as a double


% --- Executes during object creation, after setting all properties.
function fromtime2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fromtime2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function totime2_Callback(hObject, eventdata, handles)
% hObject    handle to totime2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of totime2 as text
%        str2double(get(hObject,'String')) returns contents of totime2 as a double


% --- Executes during object creation, after setting all properties.
function totime2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to totime2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lastslice_Callback(hObject, eventdata, handles)
% hObject    handle to lastslice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lastslice as text
%        str2double(get(hObject,'String')) returns contents of lastslice as a double


% --- Executes during object creation, after setting all properties.
function lastslice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lastslice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
