function varargout = als2004(varargin)
% ALS2004 M-file for als2004.fig
%
% ALS2004
%
%
% Last Modified by GUIDE v2.5 30-Mar-2004 22:37:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @als2004_OpeningFcn, ...
    'gui_OutputFcn',  @als2004_OutputFcn, ...
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

% --- Executes just before als2004 is made visible.
function als2004_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to als2004 (see VARARGIN)

% Choose default command line output for als2004
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes als2004 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = als2004_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
clc;
disp ('   ')
disp ('   ')
disp ('   ******************************************************************')
disp ('   *                           MATLAB program MCR-ALS:                                                *')
disp ('   *                           Multivariate Curve Resolution (MCR)                                      *')
disp ('   *                           Alternating Least Squares (ALS)                                           *')
disp ('   ******************************************************************')
disp ('   ')
disp ('   ')

function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double

nexp=str2num(get(hObject,'String'));
assignin('base','nexp',nexp);
evalin('base','als_opt.nexp=nexp;');
evalin('base','clear nexp');

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

lsvar=evalin('base','whos');
[aa,bb]=size(lsvar);
j=2;
lsv(1)={'select a variable'};
for i=1:aa,
    csize=length(lsvar(i).class);
    if csize==6,
        if lsvar(i).class=='double',
            lsb=[lsvar(i).name];
            lsv(j)={lsb};
            j=j+1;
        end;
    end;
end;

set(hObject,'string',lsv)

% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3

popmenu3=get(handles.popupmenu3,'String');
pm3=get(handles.popupmenu3,'Value');

if pm3==1
    
else
    selec3=char([popmenu3(pm3)]);
    matdad=evalin('base',selec3);
    assignin('base','matdad',matdad);
    evalin('base','als_opt.matdad=matdad;');
    
    axes(handles.columns);
    [xi,yi]=size(matdad);
    maxim=max(max(matdad));
    minim=min(min(matdad));
    
    if maxim > 0
        maxim1=maxim+0.2*maxim;
    else
        maxim1=maxim-0.2*abs(maxim)
    end
    
    if minim >= 0
        minim1=minim+0.2*minim;
    else
        minim1=minim-0.2*abs(minim);
    end
    
    plot(matdad);axis([1 xi minim1 maxim1]);title('Columns of raw data matrix');
    zoom on;
    
    axes(handles.rows);
    plot(matdad');axis([1 yi minim1 maxim1]);title('Rows (spectra) of raw data matrix');
    zoom on;
    
    set(handles.popupmenu4,'enable','on')
    
end

% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

lsvar=evalin('base','whos');
[aa,bb]=size(lsvar);
j=2;
lsv(1)={'select a variable'};
for i=1:aa,
    csize=length(lsvar(i).class);
    if csize==6,
        if lsvar(i).class=='double',
            lsb=[lsvar(i).name];
            lsv(j)={lsb};
            j=j+1;
        end;
    end;
end;

set(hObject,'string',lsv)



% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4

popmenu4=get(handles.popupmenu4,'String');
pm4=get(handles.popupmenu4,'Value');

if pm4==1
else
    selec4=char([popmenu4(pm4)]);
    iniesta=evalin('base',selec4);
    assignin('base','iniesta',iniesta);
    evalin('base','als_opt.iniesta=iniesta;');
    matdad=evalin('base','als_opt.matdad');

    % check dimensions of initial estimates
    
    [nrow,ncol]=size(matdad);
    [nrow2,ncol2]=size(iniesta);
    
    if nrow2==nrow,	nsign=ncol2; ils=1;end
    if ncol2==nrow, nsign=nrow2; iniesta=iniesta'; ils=1; end 
    
    if ncol2==ncol, nsign=nrow2; ils=2;end
    if nrow2==ncol, nsign=ncol2; iniesta=iniesta'; ils=2; end
    
    if ils==1,
        conc=iniesta;
        assignin('base','conc',conc);
        [nrow,nsign]=size(conc);
        abss=conc\matdad;
        assignin('base','abss',abss);
        axes(handles.conc);
        
        [xi,yi]=size(conc);
        maxim=max(max(conc));minim=min(min(conc));
        
        if maxim > 0
            maxim1=maxim+0.2*maxim;
        else
            maxim1=maxim-0.2*abs(maxim)
        end

        if minim > 0
            minim1=minim+0.2*minim;
        else
            minim1=minim-0.2*abs(minim);
        end

        plot(conc);axis([1 xi minim1 maxim1]);title('Initial estimates of the concentration profiles');zoom on
        axes(handles.spec);
        [xi,yi]=size(abss);
        maxim=max(max(abss));minim=min(min(abss));
        
        if maxim > 0
            maxim1=maxim+0.2*maxim;
        else
            maxim1=maxim-0.2*abs(maxim)
        end

        if minim > 0
            minim1=minim+0.2*minim;
            else
            minim1=minim-0.2*abs(minim);
        end

        plot(abss');axis([1 yi minim1 maxim1]);title('Unconstrained spectra calculated by LS (iter 1)');zoom on
                
        % pca reproduction
        
        disp('   *********** Results obtained after application of PCA to the data matrix ***********');
        disp(' ');
        [u,s,v,d,sd]=pcarep(matdad,nsign);
        disp(' ');
        disp('   ************************************************************************************');
        disp(' ');
        disp(' ');
                
        axes(handles.scores);
        scmat=u*s;
        [xi,yi]=size(scmat);
        maxim=max(max(scmat));minim=min(min(scmat));
        
        if maxim > 0
            maxim1=maxim+0.2*maxim;
        else
            maxim1=maxim-0.2*abs(maxim)
        end

        if minim > 0
            minim1=minim+0.2*minim;
        else
            minim1=minim-0.2*abs(minim);
        end
        
        plot(scmat);axis([1 xi minim1 maxim1]);title('Scores matrix');zoom on
        axes(handles.loadings);
        [xi,yi]=size(v);
        maxim=max(max(v));minim=min(min(v));
        
        if maxim > 0
            maxim1=maxim+0.2*maxim;
        else
            maxim1=maxim-0.2*abs(maxim)
        end

        if minim > 0
            minim1=minim+0.2*minim;
        else
            minim1=minim-0.2*abs(minim);
        end
        
        plot(v);axis([1 xi minim1 maxim1]);
        title('Loadings matrix');zoom on

    end
    
    if ils==2,
        abss=iniesta;
        assignin('base','abss',abss);
        [nsign,ncol]=size(abss);
        conc=matdad/abss;
        assignin('base','conc',conc);
        axes(handles.conc);
        [xi,yi]=size(conc);
        maxim=max(max(conc));minim=min(min(conc));
        
        if maxim > 0
            maxim1=maxim+0.2*maxim;
        else
            maxim1=maxim-0.2*abs(maxim)
        end

        if minim > 0
            minim1=minim+0.2*minim;
        else
            minim1=minim-0.2*abs(minim);
        end

        plot(conc);axis([1 xi minim1 maxim1]);title('Unconstrained concentration profiles calculated by LS (iter 1)');zoom on
        axes(handles.spec);
        [xi,yi]=size(abss);
        maxim=max(max(abss));minim=min(min(abss));
        
        if maxim > 0
            maxim1=maxim+0.2*maxim;
        else
            maxim1=maxim-0.2*abs(maxim)
        end

        if minim > 0
            minim1=minim+0.2*minim;
        else
            minim1=minim-0.2*abs(minim);
        end

        plot(abss');axis([1 yi minim1 maxim1]);title('Initial estimates of the spectra');zoom on
                
        % pca reproduction
        
        disp('   *********** Results obtained after application of PCA to the data matrix ***********');
        disp(' ');
        [u,s,v,d,sd]=pcarep(matdad,nsign);
        disp(' ');
        disp('   ************************************************************************************');
        disp(' ');
        disp(' ');
                
        axes(handles.scores);
        scmat=u*s;
        [xi,yi]=size(scmat);
        maxim=max(max(scmat));minim=min(min(scmat));
        
        if maxim > 0
            maxim1=maxim+0.2*maxim;
        else
            maxim1=maxim-0.2*abs(maxim)
        end

        if minim > 0
            minim1=minim+0.2*minim;
        else
            minim1=minim-0.2*abs(minim);
        end

        plot(scmat);axis([1 xi minim1 maxim1]);title('Scores matrix');zoom on
        axes(handles.loadings);
        [xi,yi]=size(v);
        maxim=max(max(v));minim=min(min(v));
        
        if maxim > 0
            maxim1=maxim+0.2*maxim;
        else
            maxim1=maxim-0.2*abs(maxim)
        end

        if minim > 0
            minim1=minim+0.2*minim;
        else
            minim1=minim-0.2*abs(minim);
        end
    
        plot(v);axis([1 xi minim1 maxim1]);
        title('Loadings matrix');zoom on
              
    end

 set(handles.pushbutton1,'enable','on')   
    
end

% *************************************************************************

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

nexp=str2double(get(handles.edit3,'String'));
assignin('base','nexp',nexp);
evalin('base','als_opt.nexp=nexp;');
evalin('base','clear conc abss nexp matdad iniesta');

% *************************************************************************
% initializations for constraints

evalin('base','als_opt.noneg.noneg=0;');
evalin('base','als_opt.unimod.unimodal=0;');
evalin('base','als_opt.closure.closure=0;');
evalin('base','als_opt.cselc.cselcon=0;');
evalin('base','als_opt.sselc.sselcon=0;');
evalin('base','als_opt.trilin.tril=0;');
evalin('base','als_opt.multi.datamod=0;');
evalin('base','als_opt.opt.gr=''n'';');

% *************************************************************************

close;

if evalin('base','als_opt.nexp') > 1
    clas3way;
else
    als2004m;
end