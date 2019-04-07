function varargout = mcr_main(varargin)
% MCR_MAIN M-file for mcr_main.fig
%      MCR_MAIN, by itself, creates a new MCR_MAIN or raises the existing
%      singleton*.
%
%      H = MCR_MAIN returns the handle to a new MCR_MAIN or the handle to
%      the existing singleton*.
%
%      MCR_MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MCR_MAIN.M with the given input arguments.
%
%      MCR_MAIN('Property','Value',...) creates a new MCR_MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mcr_main_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mcr_main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mcr_main

% Last Modified by GUIDE v2.5 12-Feb-2009 13:14:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @mcr_main_OpeningFcn, ...
    'gui_OutputFcn',  @mcr_main_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before mcr_main is made visible.
function mcr_main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mcr_main (see VARARGIN)

% Choose default command line output for mcr_main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mcr_main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mcr_main_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% Conjunt de dades
% *************************************************************************

% Data selection with the "Choose" button
% *************************************************************************

% --- Executes on button press in push_dades.
function push_dades_Callback(hObject, eventdata, handles)
% hObject    handle to push_dades (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


set(handles.push_dades,'enable','off');
[arxiu cami]=uigetfile('.mat','Select the MATLAB or OCTAVE file');
lectura=load ([cami arxiu]);
a=fieldnames(lectura);
if length(a)==1
    data=getfield(lectura,a{1});
    set(handles.text_nom,'string',a{1});
    
    assignin('base','data',data);
    evalin('base','mcr_str.data=data;');
    evalin('base','clear data');
    
else
 assignin('base','lectura',lectura);
 evalin('base','mcr_str.aux.lectura=lectura;');
 assignin('base','a',a);
 evalin('base','mcr_str.aux.a=a;'); 
 
 evalin('base','mcr_str.aux.estat=1;');
 
 selecvar;
 
 while(evalin('base','mcr_str.aux.estat')==1)
    pause(0.3);
 end
 
 data=getfield(lectura,a{evalin('base','mcr_str.aux.Number')});
 
 evalin('base','clear a lectura ');
 set(handles.text_nom,'string',a{evalin('base','mcr_str.aux.Number')});
    
 assignin('base','data',data);
 evalin('base','mcr_str.data=data;');
evalin('base','clear data');
 
end
 
% activation of the Number of Components section
set(handles.push_dades,'enable','off');
set(handles.but_SVD,'enable','on');
set(handles.but_manComp,'enable','on');
evalin('base','mcr_str.aux.estat=0;');
 

% N components
% *************************************************************************

% --- Executes on button press in but_SVD.
function but_SVD_Callback(hObject, eventdata, handles)
% hObject    handle to but_SVD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of but_SVD

% set(handles.Llista_var,'enable','off');
% set(handles.actualitza_llista,'enable','off');
set(handles.push_dades,'enable','off');
set(handles.but_SVD,'enable','off');
set(handles.but_manComp,'enable','off');
set(handles.but_Pure,'enable','off');
set(handles.but_EFA,'enable','off');
set(handles.but_ManEst,'enable','off');
set(handles.but_ALS,'enable','off');
set(handles.but_quit,'enable','off');
evalin('base','mcr_str.aux.estat=1;');

svdgui;

while(evalin('base','mcr_str.aux.estat')==1)
    pause(0.3);
end

if (evalin('base','mcr_str.aux.estat')==2)
%     set(handles.Llista_var,'enable','off');
%     set(handles.actualitza_llista,'enable','on');
    set(handles.push_dades,'enable','off');
    set(handles.but_SVD,'enable','on');
    set(handles.but_manComp,'enable','on');
    set(handles.but_Pure,'enable','on');
    set(handles.but_EFA,'enable','on');
    set(handles.but_ManEst,'enable','on');
    set(handles.but_ALS,'enable','off');
    set(handles.but_quit,'enable','on');
    set(handles.text_nc,'string',num2str(evalin('base','mcr_str.CompNumb.nc')));
    set(handles.text_ncmet,'string',evalin('base','mcr_str.CompNumb.method'));
    
elseif (evalin('base','mcr_str.aux.estat')==3)
%     set(handles.Llista_var,'enable','on');
%     set(handles.actualitza_llista,'enable','on');
    set(handles.push_dades,'enable','off');
    set(handles.but_SVD,'enable','on');
    set(handles.but_manComp,'enable','on');
    set(handles.but_Pure,'enable','off');
    set(handles.but_EFA,'enable','off');
    set(handles.but_ManEst,'enable','off');
    set(handles.but_ALS,'enable','off');
    set(handles.but_quit,'enable','on');
end

evalin('base','mcr_str.aux.estat=0;');

% --- Executes on button press in but_manComp.
function but_manComp_Callback(hObject, eventdata, handles)
% hObject    handle to but_manComp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of but_manComp

% set(handles.Llista_var,'enable','off');
% set(handles.actualitza_llista,'enable','off');
set(handles.push_dades,'enable','off');
set(handles.but_SVD,'enable','off');
set(handles.but_manComp,'enable','off');
set(handles.but_Pure,'enable','off');
set(handles.but_EFA,'enable','off');
set(handles.but_ManEst,'enable','off');
set(handles.but_ALS,'enable','off');
set(handles.but_quit,'enable','off');

evalin('base','mcr_str.aux.estat=1;');
manComp;

while(evalin('base','mcr_str.aux.estat')==1)
    pause(0.3);
end

if (evalin('base','mcr_str.aux.estat')==2)
%     set(handles.Llista_var,'enable','off');
%     set(handles.actualitza_llista,'enable','on');
    set(handles.push_dades,'enable','off');
    set(handles.but_SVD,'enable','on');
    set(handles.but_manComp,'enable','on');
    set(handles.but_Pure,'enable','on');
    set(handles.but_EFA,'enable','on');
    set(handles.but_ManEst,'enable','on');
    set(handles.but_ALS,'enable','off');
    set(handles.but_quit,'enable','on');
    set(handles.text_nc,'string',num2str(evalin('base','mcr_str.CompNumb.nc')));
    set(handles.text_ncmet,'string',evalin('base','mcr_str.CompNumb.method'));
elseif (evalin('base','mcr_str.aux.estat')==3)
    set(handles.push_dades,'enable','off');
%     set(handles.Llista_var,'enable','on');
%     set(handles.actualitza_llista,'enable','on');
    set(handles.but_SVD,'enable','on');
    set(handles.but_manComp,'enable','on');
    set(handles.but_Pure,'enable','off');
    set(handles.but_EFA,'enable','off');
    set(handles.but_ManEst,'enable','off');
    set(handles.but_ALS,'enable','off');
    set(handles.but_quit,'enable','on');
end

evalin('base','mcr_str.aux.estat=0;');

% Initial estimations
% *************************************************************************

% --- Executes on button press in but_Pure.
function but_Pure_Callback(hObject, eventdata, handles)
% hObject    handle to but_Pure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of but_Pure

% set(handles.Llista_var,'enable','off');
% set(handles.actualitza_llista,'enable','off');
set(handles.push_dades,'enable','off');
set(handles.but_SVD,'enable','off');
set(handles.but_manComp,'enable','off');
set(handles.but_Pure,'enable','off');
set(handles.but_EFA,'enable','off');
set(handles.but_ManEst,'enable','off');
set(handles.but_ALS,'enable','off');
set(handles.but_quit,'enable','off');

evalin('base','mcr_str.aux.estat=1;');

puregui;

while(evalin('base','mcr_str.aux.estat')==1)
    pause(0.3);
end

if (evalin('base','mcr_str.aux.estat')==2)
%     set(handles.Llista_var,'enable','on');
%     set(handles.actualitza_llista,'enable','on');
set(handles.push_dades,'enable','off');
    set(handles.but_SVD,'enable','on');
    set(handles.but_manComp,'enable','on');
    set(handles.but_Pure,'enable','on');
    set(handles.but_EFA,'enable','on');
    set(handles.but_ManEst,'enable','on');
    set(handles.but_ALS,'enable','on');
    set(handles.but_quit,'enable','on');
    set(handles.text_iniesta,'string',evalin('base','mcr_str.InitEstim.method'));
elseif (evalin('base','mcr_str.aux.estat')==3)
%     set(handles.Llista_var,'enable','on');
%     set(handles.actualitza_llista,'enable','on');
set(handles.push_dades,'enable','off');
    set(handles.but_SVD,'enable','on');
    set(handles.but_manComp,'enable','on');
    set(handles.but_Pure,'enable','on');
    set(handles.but_EFA,'enable','on');
    set(handles.but_ManEst,'enable','on');
    set(handles.but_ALS,'enable','off');
    set(handles.but_quit,'enable','on');
end

evalin('base','mcr_str.aux.estat=0;');

% --- Executes on button press in but_EFA.
function but_EFA_Callback(hObject, eventdata, handles)
% hObject    handle to but_EFA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of but_EFA

% set(handles.Llista_var,'enable','off');
% set(handles.actualitza_llista,'enable','off');
set(handles.push_dades,'enable','off');
set(handles.but_SVD,'enable','off');
set(handles.but_manComp,'enable','off');
set(handles.but_Pure,'enable','off');
set(handles.but_EFA,'enable','off');
set(handles.but_ManEst,'enable','off');
set(handles.but_ALS,'enable','off');
set(handles.but_quit,'enable','off');

evalin('base','mcr_str.aux.estat=1;');
evalin('base','mcr_str.aux.counter=0;');
efagui;

while(evalin('base','mcr_str.aux.estat')==1)
    pause(0.3);
end

if (evalin('base','mcr_str.aux.estat')==2)
%     set(handles.Llista_var,'enable','on');
%     set(handles.actualitza_llista,'enable','on');
set(handles.push_dades,'enable','off');
    set(handles.but_SVD,'enable','on');
    set(handles.but_manComp,'enable','on');
    set(handles.but_Pure,'enable','on');
    set(handles.but_EFA,'enable','on');
    set(handles.but_ManEst,'enable','on');
    set(handles.but_ALS,'enable','on');
    set(handles.but_quit,'enable','on');
    set(handles.text_iniesta,'string',evalin('base','mcr_str.InitEstim.method'));
elseif (evalin('base','mcr_str.aux.estat')==3)
%     set(handles.Llista_var,'enable','on');
%     set(handles.actualitza_llista,'enable','on');
set(handles.push_dades,'enable','off');
    set(handles.but_SVD,'enable','on');
    set(handles.but_manComp,'enable','on');
    set(handles.but_Pure,'enable','on');
    set(handles.but_EFA,'enable','on');
    set(handles.but_ManEst,'enable','on');
    set(handles.but_ALS,'enable','off');
    set(handles.but_quit,'enable','on');
end

evalin('base','mcr_str.aux.estat=0;');


% --- Executes on button press in but_ManEst.
function but_ManEst_Callback(hObject, eventdata, handles)
% hObject    handle to but_ManEst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of but_ManEst

% set(handles.Llista_var,'enable','off');
% set(handles.actualitza_llista,'enable','off');
set(handles.push_dades,'enable','off');
set(handles.but_SVD,'enable','off');
set(handles.but_manComp,'enable','off');
set(handles.but_Pure,'enable','off');
set(handles.but_EFA,'enable','off');
set(handles.but_ManEst,'enable','off');
set(handles.but_ALS,'enable','off');
set(handles.but_quit,'enable','off');

evalin('base','mcr_str.aux.estat=1;');

manEst;

while(evalin('base','mcr_str.aux.estat')==1)
    pause(0.3);
end

if (evalin('base','mcr_str.aux.estat')==2)
%     set(handles.Llista_var,'enable','on');
%     set(handles.actualitza_llista,'enable','on');
set(handles.push_dades,'enable','off');
    set(handles.but_SVD,'enable','on');
    set(handles.but_manComp,'enable','on');
    set(handles.but_Pure,'enable','on');
    set(handles.but_EFA,'enable','on');
    set(handles.but_ManEst,'enable','on');
    set(handles.but_ALS,'enable','on');
    set(handles.but_quit,'enable','on');
    set(handles.text_iniesta,'string',evalin('base','mcr_str.InitEstim.method'));
elseif (evalin('base','mcr_str.aux.estat')==3)
%     set(handles.Llista_var,'enable','on');
%     set(handles.actualitza_llista,'enable','on');
set(handles.push_dades,'enable','off');
    set(handles.but_SVD,'enable','on');
    set(handles.but_manComp,'enable','on');
    set(handles.but_Pure,'enable','on');
    set(handles.but_EFA,'enable','on');
    set(handles.but_ManEst,'enable','on');
    set(handles.but_ALS,'enable','off');
    set(handles.but_quit,'enable','on');
end

evalin('base','mcr_str.aux.estat=0;');


% Passar a ALS
% *************************************************************************

% --- Executes on button press in but_ALS.
function but_ALS_Callback(hObject, eventdata, handles)
% hObject    handle to but_ALS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of but_ALS
close;

% evalin('base','initEstim=mcr_str.InitEstim.iniesta;');
als2009;

% SORTIDA
% *************************************************************************

% --- Executes on button press in but_quit.
function but_quit_Callback(hObject, eventdata, handles)
% hObject    handle to but_quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of but_quit

if ((evalin('base','exist(''mcr_str'')'))==1);evalin('base','clear(''mcr_str'')');end;
close;


% List of the variables of the WS
% *************************************************************************

% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

lsvar=evalin('base','whos');
[aa,bb]=size(lsvar);
j=2;
lsv(1)={'select a variable from the WS'};
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
    assignin('base','selec3',selec3);
    evalin('base','mcr_str.data=matdad;');
    evalin('base','mcr_str.aux.data_name=selec3;');
    
    set(handles.text_nom,'string',selec3);
    evalin('base','clear matdad selec3'); 
    
    % s'activa l'opcio de determinar nombre de components
    set(handles.push_dades,'enable','off');
    set(handles.but_SVD,'enable','on');
    set(handles.but_manComp,'enable','on');
    evalin('base','mcr_str.aux.estat=0;');
       
    
end



