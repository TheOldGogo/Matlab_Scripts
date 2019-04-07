function varargout = als2004multi(varargin)
% ALS2004MULTI M-file for als2004multi.fig
%
% ALS2004MULTI permet la introduccio de restriccions en la resolucio.
%

% Last Modified by GUIDE v2.5 26-Jul-2004 16:10:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @als2004multi_OpeningFcn, ...
    'gui_OutputFcn',  @als2004multi_OutputFcn, ...
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


% --- Executes just before als2004multi is made visible.
function als2004multi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to als2004multi (see VARARGIN)

% Choose default command line output for als2004multi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

if evalin('base','als_opt.multi.datamod')==1
    set(handles.check_ccons,'enable','on');
    set(handles.check_scons,'enable','off');
elseif evalin('base','als_opt.multi.datamod')==2
    set(handles.check_ccons,'enable','off');
    set(handles.check_scons,'enable','on');
elseif evalin('base','als_opt.multi.datamod')==3
    set(handles.check_ccons,'enable','on');
    set(handles.check_scons,'enable','on');
end

evalin('base','als_opt.multi.ccons=0;');
evalin('base','als_opt.multi.scons=0;');
evalin('base','als_opt.multi.curr_cmat=1;');
evalin('base','als_opt.multi.curr_smat=1;');


% UIWAIT makes als2004multi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = als2004multi_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% *************************************************************************
% Multiple matrices
% *************************************************************************

% --- Executes during object creation, after setting all properties.
function popup_nmat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_nmat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

nexp=evalin('base','als_opt.nexp');
j=1;
for i=1:nexp,
    lsb=[i];
    lsv(j)={lsb};
    j=j+1;
end;
set(hObject,'string',lsv)



% --- Executes on button press in check_ccons.
function check_ccons_Callback(hObject, eventdata, handles)
% hObject    handle to check_ccons (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_ccons

ccons=get(hObject,'Value');

scons=get(handles.check_scons,'Value');

if evalin('base','als_opt.multi.datamod')==1

    if ccons==0
        set(handles.text_nmat,'enable','on');
        set(handles.text_clau,'enable','on');
        set(handles.text_csub,'enable','on');
        set(handles.text_ssub,'enable','on');
        set(handles.text_X,'enable','on');
        set(handles.text_Y,'enable','on');
        set(handles.popup_nmat,'enable','on','value',1);
    else
        set(handles.text_nmat,'enable','off');
        set(handles.text_clau,'enable','off');
        set(handles.text_csub,'enable','off');
        set(handles.text_ssub,'enable','off');
        set(handles.text_X,'enable','off');
        set(handles.text_Y,'enable','off');
        set(handles.popup_nmat,'enable','off','value',1);
    end

elseif evalin('base','als_opt.multi.datamod')==3

    if ccons==0 & scons==0
        set(handles.text_nmat,'enable','on');
        set(handles.text_clau,'enable','on');
        set(handles.text_csub,'enable','on');
        set(handles.text_ssub,'enable','on');
        set(handles.text_X,'enable','on');
        set(handles.text_Y,'enable','on');
        set(handles.popup_nmat,'enable','on','value',1);
    elseif (ccons==0 & scons==1) | (ccons==1 & scons==0)
        set(handles.text_nmat,'enable','on');
        set(handles.text_clau,'enable','on');
        set(handles.text_csub,'enable','on');
        set(handles.text_ssub,'enable','on');
        set(handles.text_X,'enable','on');
        set(handles.text_Y,'enable','on');
        set(handles.popup_nmat,'enable','on','value',1);
    elseif ccons==1 & scons==1
        set(handles.text_nmat,'enable','off');
        set(handles.text_clau,'enable','off');
        set(handles.text_csub,'enable','off');
        set(handles.text_ssub,'enable','off');
        set(handles.text_X,'enable','off');
        set(handles.text_Y,'enable','off');
        set(handles.popup_nmat,'enable','off','value',1);
    end


end


assignin('base','scons',scons);
evalin('base','als_opt.multi.scons=scons;');
evalin('base','clear scons');

assignin('base','ccons',ccons);
evalin('base','als_opt.multi.ccons=ccons;');
evalin('base','clear ccons');


% --- Executes on button press in check_scons.
function check_scons_Callback(hObject, eventdata, handles)
% hObject    handle to check_scons (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_scons

scons=get(hObject,'Value');

ccons=get(handles.check_ccons,'Value');


if evalin('base','als_opt.multi.datamod')==2

    if scons==0
        set(handles.text_nmat,'enable','on');
        set(handles.text_clau,'enable','on');
        set(handles.text_csub,'enable','on');
        set(handles.text_ssub,'enable','on');
        set(handles.text_X,'enable','on');
        set(handles.text_Y,'enable','on');
        set(handles.popup_nmat,'enable','on','value',1);
    else
        set(handles.text_nmat,'enable','off');
        set(handles.text_clau,'enable','off');
        set(handles.text_csub,'enable','off');
        set(handles.text_ssub,'enable','off');
        set(handles.text_X,'enable','off');
        set(handles.text_Y,'enable','off');
        set(handles.popup_nmat,'enable','off','value',1);
    end

elseif evalin('base','als_opt.multi.datamod')==3

    if ccons==0 & scons==0
        set(handles.text_nmat,'enable','on');
        set(handles.text_clau,'enable','on');
        set(handles.text_csub,'enable','on');
        set(handles.text_ssub,'enable','on');
        set(handles.text_X,'enable','on');
        set(handles.text_Y,'enable','on');
        set(handles.popup_nmat,'enable','on','value',1);
    elseif (ccons==0 & scons==1) | (ccons==1 & scons==0)
        set(handles.text_nmat,'enable','on');
        set(handles.text_clau,'enable','on');
        set(handles.text_csub,'enable','on');
        set(handles.text_ssub,'enable','on');
        set(handles.text_X,'enable','on');
        set(handles.text_Y,'enable','on');
        set(handles.popup_nmat,'enable','on','value',1);
    elseif ccons==1 & scons==1
        set(handles.text_nmat,'enable','off');
        set(handles.text_clau,'enable','off');
        set(handles.text_csub,'enable','off');
        set(handles.text_ssub,'enable','off');
        set(handles.text_X,'enable','off');
        set(handles.text_Y,'enable','off');
        set(handles.popup_nmat,'enable','off','value',1);
    end

end


assignin('base','scons',scons);
evalin('base','als_opt.multi.scons=scons;');
evalin('base','clear scons');

assignin('base','ccons',ccons);
evalin('base','als_opt.multi.ccons=ccons;');
evalin('base','clear ccons');


% --- Executes on selection change in popup_nmat.
function popup_nmat_Callback(hObject, eventdata, handles)
% hObject    handle to popup_nmat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popup_nmat contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_nmat

nmat = get(hObject,'value');

former_cmat=evalin('base','als_opt.multi.curr_cmat');
former_smat=evalin('base','als_opt.multi.curr_smat'); %estava curr_cmat

if nmat==1
    set(handles.text_X,'string',1)
    set(handles.text_Y,'string',1)
end

if evalin('base','als_opt.multi.datamod')==1
    set(handles.text_X,'string',nmat)
    set(handles.text_Y,'string',1)
    curr_cmat=nmat;
    assignin('base','curr_cmat',curr_cmat);
    evalin('base','als_opt.multi.curr_cmat=curr_cmat;');
    evalin('base','clear curr_cmat');
    curr_smat=1;
    assignin('base','curr_smat',curr_smat);
    evalin('base','als_opt.multi.curr_smat=curr_smat;');
    evalin('base','clear curr_smat');
elseif evalin('base','als_opt.multi.datamod')==2
    set(handles.text_X,'string',1)
    set(handles.text_Y,'string',nmat)
    curr_cmat=1;
    assignin('base','curr_cmat',curr_cmat);
    evalin('base','als_opt.multi.curr_cmat=curr_cmat;');
    evalin('base','clear curr_cmat');
    curr_smat=nmat;
    assignin('base','curr_smat',curr_smat);
    evalin('base','als_opt.multi.curr_smat=curr_smat;');
    evalin('base','clear curr_smat');
elseif evalin('base','als_opt.multi.datamod')==3

    %     ***********************
    limc=[];
    b=1;
    j=evalin('base','als_opt.nexp')/evalin('base','als_opt.multi.matc');
    for i=1:j:evalin('base','als_opt.nexp')
        limc(b)=i;
        b=b+1;
    end
    for i=1:evalin('base','als_opt.multi.matc');
        if (limc(i)-nmat)<=0 & (limc(i)-nmat)>=(-evalin('base','als_opt.multi.matr')+1)
            curr_cmat=i;
        end
    end
    %     *****************************
    limc=[];
    b=1;
    j=evalin('base','als_opt.nexp')/evalin('base','als_opt.multi.matc');
    limc=[1:j];

    for k=1:evalin('base','als_opt.multi.matc');
        for i=1:evalin('base','als_opt.multi.matr');
            if (limc(i)-nmat)==0 | (limc(i)-nmat)==(-k*evalin('base','als_opt.multi.matr'))
                curr_smat=i;
            end
        end
    end
    %     *****************************

    set(handles.text_X,'string',curr_cmat)
    set(handles.text_Y,'string',curr_smat)

end

% start -> values that can be modified

if get(handles.popup_ncnn,'value') ~=1 & (former_cmat~=curr_cmat);
    set(handles.popup_ncnn,'value',1);
    set(handles.edit_spcnn,'string',' ');
end

if get(handles.popup_nsnn,'value') ~=1& (former_smat~=curr_smat);
    set(handles.popup_nsnn,'value',1);
    set(handles.edit_spsnn,'string',' ');
end

if get(handles.popup_ncuni,'value') ~=1 & (former_cmat~=curr_cmat);
    set(handles.popup_ncuni,'value',1);
    set(handles.edit_spunic,'string',' ');
end

if get(handles.popup_nsuni,'value') ~=1& (former_smat~=curr_smat);
    set(handles.popup_nsuni,'value',1);
    set(handles.edit_spunis,'string',' ');
end

if get(handles.radio_cclos,'value')==1
    if get(handles.popup_nclos,'value') ~=1 & (former_cmat~=curr_cmat);
        set(handles.popup_nclos,'value',1);
        set(handles.edit_1clos,'string',' ');
        set(handles.edit_2clos,'string',' ');
        set(handles.edit_vclos1,'string',' ');
        set(handles.edit_vclos2,'string',' ');
        set(handles.popup_1closcond,'value',1);
        set(handles.popup_2closcond,'value',1);
        set(handles.edit_1spclos,'string',' ');
        set(handles.edit_2spclos,'string',' ');
        set(handles.check_vclos,'value',0);
    end
end

if get(handles.radio_sclos,'value')==1
    if get(handles.popup_nclos,'value') ~=1 & (former_smat~=curr_smat);
        set(handles.popup_nclos,'value',1);
        set(handles.edit_1clos,'string',' ');
        set(handles.edit_2clos,'string',' ');
        set(handles.edit_vclos1,'string',' ');
        set(handles.edit_vclos2,'string',' ');
        set(handles.popup_1closcond,'value',1);
        set(handles.popup_2closcond,'value',1);
        set(handles.edit_1spclos,'string',' ');
        set(handles.edit_2spclos,'string',' ');
        set(handles.check_vclos,'value',0);
    end
end

% end -> values that can be modified

assignin('base','curr_cmat',curr_cmat);
evalin('base','als_opt.multi.curr_cmat=curr_cmat;');
evalin('base','clear curr_cmat');

assignin('base','curr_smat',curr_smat);
evalin('base','als_opt.multi.curr_smat=curr_smat;');
evalin('base','clear curr_smat');



% *************************************************************************
% isp
% *************************************************************************

% --- Executes during object creation, after setting all properties.
function edit_isp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_isp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_isp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_isp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_isp as text
%        str2double(get(hObject,'String')) returns contents of edit_isp as a double

isp_char=get(hObject,'String');

if isempty(isp_char)==1
    matc=evalin('base','als_opt.multi.matc');
    nsp=evalin('base','min(size(als_opt.iniesta))');
    isp=ones(matc,nsp);
else
    isp=evalin('base',isp_char);
end

assignin('base','isp',isp);

evalin('base','als_opt.multi.isp=isp;');
evalin('base','clear isp');



% *************************************************************************
% noneg
% *************************************************************************

% --- Executes on button press in check_noneg.
function check_noneg_Callback(hObject, eventdata, handles)
% hObject    handle to check_noneg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_noneg

noneg=get(hObject,'Value');

if noneg==1;
    set(handles.radio_cnn,'enable','on');
    set(handles.radio_snn,'enable','on');
    set(handles.radio_csnn,'enable','on');
else
    set(handles.radio_cnn,'enable','off','value',0);
    set(handles.radio_snn,'enable','off','value',0);
    set(handles.radio_csnn,'enable','off','value',0);
    set(handles.text_impc,'enable','off');
    set(handles.popup_impc,'enable','off','value',1);
    set(handles.text_ncnn,'enable','off');
    set(handles.popup_ncnn,'enable','off','value',1);
    set(handles.text_spcnn,'enable','off');
    set(handles.edit_spcnn,'enable','off','string',' ');
    set(handles.text_imps,'enable','off');
    set(handles.popup_imps,'enable','off','value',1);
    set(handles.text_nsnn,'enable','off');
    set(handles.popup_nsnn,'enable','off','value',1);
    set(handles.text_spsnn,'enable','off');
    set(handles.edit_spsnn,'enable','off','string',' ');

    evalin('base','als_opt=rmfield(als_opt,''noneg'');');

end;
assignin('base','noneg',noneg);
evalin('base','als_opt.noneg.noneg=noneg;');
evalin('base','clear noneg');

% --- Executes on button press in radio_cnn.
function radio_cnn_Callback(hObject, eventdata, handles)
% hObject    handle to radio_cnn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_cnn

ineg=1;
set(handles.radio_cnn,'enable','on');
set(handles.radio_snn,'enable','off');
set(handles.radio_csnn,'enable','off');
set(handles.text_impc,'enable','on');
set(handles.popup_impc,'enable','on');
set(handles.text_ncnn,'enable','on');
set(handles.popup_ncnn,'enable','on');
set(handles.text_spcnn,'enable','off');
set(handles.edit_spcnn,'enable','off');

evalin('base','als_opt.noneg.cneg=[];');

assignin('base','ineg',ineg);
evalin('base','als_opt.noneg.ineg=ineg;');
evalin('base','clear ineg');

% --- Executes on button press in radio_snn.
function radio_snn_Callback(hObject, eventdata, handles)
% hObject    handle to radio_snn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_snn

ineg=3;
set(handles.radio_cnn,'enable','off');
set(handles.radio_snn,'enable','on');
set(handles.radio_csnn,'enable','off');
set(handles.text_imps,'enable','on');
set(handles.popup_imps,'enable','on');
set(handles.text_nsnn,'enable','on');
set(handles.popup_nsnn,'enable','on');
set(handles.text_spsnn,'enable','off');
set(handles.edit_spsnn,'enable','off');


evalin('base','als_opt.noneg.spneg=[];');

assignin('base','ineg',ineg);
evalin('base','als_opt.noneg.ineg=ineg;');
evalin('base','clear ineg');

% --- Executes on button press in radio_csnn.
function radio_csnn_Callback(hObject, eventdata, handles)
% hObject    handle to radio_csnn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_csnn

ineg=2;
set(handles.radio_cnn,'enable','off');
set(handles.radio_snn,'enable','off');
set(handles.radio_csnn,'enable','on');
set(handles.text_impc,'enable','on');
set(handles.popup_impc,'enable','on');
set(handles.text_ncnn,'enable','on');
set(handles.popup_ncnn,'enable','on');
set(handles.text_spcnn,'enable','off');
set(handles.edit_spcnn,'enable','off');
set(handles.text_imps,'enable','on');
set(handles.popup_imps,'enable','on');
set(handles.text_nsnn,'enable','on');
set(handles.popup_nsnn,'enable','on');
set(handles.text_spsnn,'enable','off');
set(handles.edit_spsnn,'enable','off');

evalin('base','als_opt.noneg.cneg=[];');
evalin('base','als_opt.noneg.spneg=[];');

assignin('base','ineg',ineg);
evalin('base','als_opt.noneg.ineg=ineg;');
evalin('base','clear ineg');

% --- Executes during object creation, after setting all properties.
function popup_impc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_impc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

llista(1)={'select...'};
llista(2)={'forced to zero'};
llista(3)={'nnls'};
llista(4)={'fnnls'};
set(hObject,'string',llista)

% --- Executes on selection change in popup_impc.
function popup_impc_Callback(hObject, eventdata, handles)
% hObject    handle to popup_impc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popup_impc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_impc

ialg=get(hObject,'Value')-2;
assignin('base','ialg',ialg);
evalin('base','als_opt.noneg.ialg=ialg;');

if ialg==0
    dim=evalin('base','min(size(als_opt.iniesta))');
    j=2;
    llistannc(1)={'select...'};
    for i=0:1:dim;
        llistnnc=[i];
        llistannc(j)={llistnnc};
        j=j+1;
    end;
    set(handles.popup_ncnn,'value',1)
    set(handles.popup_ncnn,'string',llistannc)
    set(handles.edit_spcnn,'enable','off','string','');
    set(handles.text_spcnn,'enable','off');
else
    dim=evalin('base','min(size(als_opt.iniesta))');
    llistannc(1)={'select...'};
    llistannc(2)={0};
    llistnnc=[dim];
    llistannc(3)={llistnnc};
    set(handles.popup_ncnn,'value',1)
    set(handles.popup_ncnn,'string',llistannc)
    set(handles.edit_spcnn,'enable','off','string','');
    set(handles.text_spcnn,'enable','off');
end

evalin('base','clear ialg');

% --- Executes during object creation, after setting all properties.
function popup_imps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_imps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

llista(1)={'select...'};
llista(2)={'forced to zero'};
llista(3)={'nnls'};
llista(4)={'fnnls'};
set(hObject,'string',llista)

% --- Executes on selection change in popup_imps.
function popup_imps_Callback(hObject, eventdata, handles)
% hObject    handle to popup_imps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popup_imps contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_imps

ialgs=get(hObject,'Value')-2;
assignin('base','ialgs',ialgs);
evalin('base','als_opt.noneg.ialgs=ialgs;');

if ialgs==0;
    dim=evalin('base','min(size(als_opt.iniesta))');
    j=2;
    llistanns(1)={'select...'};
    for i=0:1:dim,
        llistnns=[i];
        llistanns(j)={llistnns};
        j=j+1;
    end;
    set(handles.popup_nsnn,'value',1)
    set(handles.popup_nsnn,'string',llistanns)
    set(handles.edit_spsnn,'enable','off','string','');
    set(handles.text_spsnn,'enable','off');
else
    dim=evalin('base','min(size(als_opt.iniesta))');
    llistanns(1)={'select...'};
    llistanns(2)={0};
    llistnns=[dim];
    llistanns(3)={llistnns};
    set(handles.popup_nsnn,'value',1)
    set(handles.popup_nsnn,'string',llistanns)
    set(handles.edit_spsnn,'enable','off','string','');
    set(handles.text_spsnn,'enable','off');
end

evalin('base','clear ialgs');

% --- Executes during object creation, after setting all properties.
function popup_ncnn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_ncnn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


dim=evalin('base','min(size(als_opt.iniesta))');
j=2;
llistannc(1)={'select...'};
for i=0:1:dim;
    llistnnc=[i];
    llistannc(j)={llistnnc};
    j=j+1;
end;

set(hObject,'string',llistannc)

% --- Executes on selection change in popup_ncnn.
function popup_ncnn_Callback(hObject, eventdata, handles)
% hObject    handle to popup_ncnn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popup_ncnn contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_ncnn

ncneg=get(hObject,'Value')-2;

assignin('base','ncneg',ncneg);
evalin('base','als_opt.noneg.ncneg=ncneg;');
dim=evalin('base','min(size(als_opt.iniesta))');
matc=evalin('base','als_opt.multi.matc');
ialg=evalin('base','als_opt.noneg.ialg');
curr_cmat=evalin('base','als_opt.multi.curr_cmat');
curr_smat=evalin('base','als_opt.multi.curr_smat');
cneg=evalin('base','als_opt.noneg.cneg');

if evalin('base','als_opt.multi.ccons')==1
    if ialg == 0
        if ncneg == dim;
            cneg = ones(matc,dim);
            set(handles.text_spcnn,'enable','off');
            set(handles.edit_spcnn,'enable','off','string','');
        elseif  ncneg == -1
            cneg=zeros(matc,dim);
            set(handles.text_spcnn,'enable','off');
            set(handles.edit_spcnn,'enable','off','string','');
        elseif  ncneg == 0
            cneg = zeros(matc,dim);
            set(handles.text_spcnn,'enable','off');
            set(handles.edit_spcnn,'enable','off','string','');
        else
            cneg=[];
            set(handles.text_spcnn,'enable','on');
            set(handles.edit_spcnn,'enable','on');
        end
    else
        if ncneg==0;
            cneg = zeros(matc,dim);
        elseif ncneg==1;
            cneg = ones(matc,dim);
        end
    end
elseif evalin('base','als_opt.multi.ccons')==0
    if ialg == 0
        if ncneg == dim;
            evalin('base','als_opt.noneg.cneg = ones(matc,dim)');
            set(handles.text_spcnn,'enable','off');
            set(handles.edit_spcnn,'enable','off','string','');
        elseif  ncneg == -1
            evalin('base','als_opt.noneg.cneg =zeros(matc,dim)');
            set(handles.text_spcnn,'enable','off');
            set(handles.edit_spcnn,'enable','off','string','');
        elseif  ncneg == 0
            evalin('base','als_opt.noneg.cneg  = zeros(matc,dim)');
            set(handles.text_spcnn,'enable','off');
            set(handles.edit_spcnn,'enable','off','string','');
        else
            evalin('base','als_opt.noneg.cneg =[]');
            set(handles.text_spcnn,'enable','on');
            set(handles.edit_spcnn,'enable','on');
        end
    else
        if ncneg==0;
            form_cneg = zeros(1,dim);
            cneg(curr_cmat,:)=form_cneg;
        elseif ncneg==1;
            form_cneg= ones(1,dim);
            cneg(curr_cmat,:)=form_cneg;
        end
    end
end

assignin('base','cneg',cneg);
evalin('base','als_opt.noneg.cneg=cneg;');
evalin('base','clear cneg ncneg dim matc curr_mat curr_smat');

% --- Executes during object creation, after setting all properties.
function popup_nsnn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_nsnn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

dim=evalin('base','min(size(als_opt.iniesta))');
j=2;
llistanns(1)={'select...'};
for i=0:1:dim,
    llistnns=[i];
    llistanns(j)={llistnns};
    j=j+1;
end;
set(hObject,'string',llistanns)



% --- Executes on selection change in popup_nsnn.
function popup_nsnn_Callback(hObject, eventdata, handles)
% hObject    handle to popup_nsnn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popup_nsnn contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_nsnn

nspneg=get(hObject,'Value')-2;

assignin('base','nspneg',nspneg);
evalin('base','als_opt.noneg.nspneg=nspneg;');

dim=evalin('base','min(size(als_opt.iniesta))');
matr=evalin('base','als_opt.multi.matr');
ialgs=evalin('base','als_opt.noneg.ialgs');
curr_cmat=evalin('base','als_opt.multi.curr_cmat');
curr_smat=evalin('base','als_opt.multi.curr_smat');
spneg=evalin('base','als_opt.noneg.spneg');

if evalin('base','als_opt.multi.scons')==1
    if ialgs == 0
        if nspneg == dim
            spneg = ones(dim,matr);
            set(handles.text_spsnn,'enable','off');
            set(handles.edit_spsnn,'enable','off','string','');
        elseif  nspneg == 0
            spneg = zeros(dim,matr);
            set(handles.text_spsnn,'enable','off');
            set(handles.edit_spsnn,'enable','off','string','');
        elseif  nspneg == -1
            spneg=[];
            set(handles.text_spsnn,'enable','off');
            set(handles.edit_spsnn,'enable','off','string','');
        else
            spneg=[];
            set(handles.text_spsnn,'enable','on');
            set(handles.edit_spsnn,'enable','on');
        end
    else
        if nspneg==0
            spneg = zeros(dim,matr);
        elseif nspneg==1
            spneg = ones(dim,matr);
        end
    end
elseif evalin('base','als_opt.multi.scons')==0
    if ialgs == 0
        if nspneg == dim;
            evalin('base','als_opt.noneg.spneg = ones(dim,matr)');
            set(handles.text_spcnn,'enable','off');
            set(handles.edit_spcnn,'enable','off','string','');
        elseif  nspneg == -1
            evalin('base','als_opt.noneg.spneg =zeros(dim,matr)');
            set(handles.text_spcnn,'enable','off');
            set(handles.edit_spcnn,'enable','off','string','');
        elseif  nspneg == 0
            evalin('base','als_opt.noneg.spneg  = zeros(dim,matr)');
            set(handles.text_spcnn,'enable','off');
            set(handles.edit_spcnn,'enable','off','string','');
        else
            evalin('base','als_opt.noneg.spneg =[]');
            set(handles.text_spcnn,'enable','on');
            set(handles.edit_spcnn,'enable','on');
        end
    else
        if nspneg==0;
            form_spneg = zeros(dim,1);
            spneg(:,curr_smat)=form_spneg;
        elseif nspneg==1;
            form_spneg= ones(dim,1);
            spneg(:,curr_smat)=form_spneg;
        end

    end


end

assignin('base','spneg',spneg);
evalin('base','als_opt.noneg.spneg=spneg;');
evalin('base','clear spneg matr nspneg');

% --- Executes during object creation, after setting all properties.
function edit_spcnn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_spcnn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function edit_spcnn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_spcnn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_spcnn as text
%        str2double(get(hObject,'String')) returns contents of edit_spcnn as a double

cnegr=str2num(get(hObject,'String'));
cneg = ones(evalin('base','als_opt.nexp'),1)*cnegr;
assignin('base','cneg',cneg);
evalin('base','als_opt.noneg.cneg=cneg;');
evalin('base','clear cneg');

% --- Executes during object creation, after setting all properties.
function edit_spsnn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_spsnn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function edit_spsnn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_spsnn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_spsnn as text
%        str2double(get(hObject,'String')) returns contents of edit_spsnn as a double


spnegr= str2num(get(hObject,'String'));
spneg = spnegr'*ones(1,evalin('base','als_opt.nexp'));

assignin('base','spneg',spneg);
evalin('base','als_opt.noneg.spneg=spneg;');
evalin('base','clear spneg');


% *************************************************************************
% unimodal
% *************************************************************************


% --- Executes on button press in check_uni.
function check_uni_Callback(hObject, eventdata, handles)
% hObject    handle to check_uni (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_uni


unimodal=get(hObject,'Value');

if unimodal==1;
    set(handles.radio_Cuni,'enable','on');
    set(handles.radio_Suni,'enable','on');
    set(handles.radio_CSuni,'enable','on');
else
    set(handles.radio_Cuni,'enable','off','value',0);
    set(handles.radio_Suni,'enable','off','value',0);
    set(handles.radio_CSuni,'enable','off','value',0);

    set(handles.text_iuni,'enable','off');
    set(handles.popup_iuni,'enable','off','value',1);
    set(handles.text_tolunic,'enable','off');
    set(handles.edit_tolunic,'enable','off','string',' ');
    set(handles.text_tolunis,'enable','off');
    set(handles.edit_tolunis,'enable','off','string',' ');

    set(handles.text_ncuni,'enable','off');
    set(handles.popup_ncuni,'enable','off','value',1);
    set(handles.text_nsuni,'enable','off');
    set(handles.popup_nsuni,'enable','off','value',1);

    set(handles.text_spunic,'enable','off');
    set(handles.edit_spunic,'enable','off','string',' ');

    set(handles.text_spunis,'enable','off');
    set(handles.edit_spunis,'enable','off','string',' ');

    evalin('base','als_opt=rmfield(als_opt,''unimod'');');

end;

assignin('base','unimodal',unimodal);
evalin('base','als_opt.unimod.unimodal=unimodal;');
evalin('base','clear unimodal');


% --- Executes on button press in radio_Cuni.
function radio_Cuni_Callback(hObject, eventdata, handles)
% hObject    handle to radio_Cuni (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_Cuni

imod=1;
set(handles.radio_Cuni,'enable','on');
set(handles.radio_Suni,'enable','off');
set(handles.radio_CSuni,'enable','off');
set(handles.text_iuni,'enable','on');
set(handles.popup_iuni,'enable','on');
set(handles.text_tolunic,'enable','on');
set(handles.edit_tolunic,'enable','on');
set(handles.text_ncuni,'enable','on');
set(handles.popup_ncuni,'enable','on');

evalin('base','als_opt.unimod.spmod=[];');

assignin('base','imod',imod);
evalin('base','als_opt.unimod.imod=imod;');
evalin('base','clear imod');

% --- Executes on button press in radio_Suni.
function radio_Suni_Callback(hObject, eventdata, handles)
% hObject    handle to radio_Suni (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_Suni

imod=2;
set(handles.radio_Cuni,'enable','off');
set(handles.radio_Suni,'enable','on');
set(handles.radio_CSuni,'enable','off');
set(handles.text_iuni,'enable','on');
set(handles.popup_iuni,'enable','on');
set(handles.text_tolunis,'enable','on');
set(handles.edit_tolunis,'enable','on');
set(handles.text_nsuni,'enable','on');
set(handles.popup_nsuni,'enable','on');

evalin('base','als_opt.unimod.spsmod=[];');

assignin('base','imod',imod);
evalin('base','als_opt.unimod.imod=imod;');
evalin('base','clear imod');


% --- Executes on button press in radio_CSuni.
function radio_CSuni_Callback(hObject, eventdata, handles)
% hObject    handle to radio_CSuni (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_CSuni

imod=3;
set(handles.radio_Cuni,'enable','off');
set(handles.radio_Suni,'enable','off');
set(handles.radio_CSuni,'enable','on');

set(handles.text_iuni,'enable','on');
set(handles.popup_iuni,'enable','on');

set(handles.text_ncuni,'enable','on');
set(handles.popup_ncuni,'enable','on');
set(handles.text_nsuni,'enable','on');
set(handles.popup_nsuni,'enable','on');
set(handles.text_tolunic,'enable','on');
set(handles.edit_tolunic,'enable','on');

set(handles.text_spunic,'enable','off');
set(handles.edit_spunic,'enable','off');
set(handles.text_spunis,'enable','off');
set(handles.edit_spunis,'enable','off');
set(handles.text_tolunis,'enable','on');
set(handles.edit_tolunis,'enable','on');

evalin('base','als_opt.unimod.spmod=[];');
evalin('base','als_opt.unimod.spsmod=[];');

assignin('base','imod',imod);
evalin('base','als_opt.unimod.imod=imod;');
evalin('base','clear imod');


% --- Executes during object creation, after setting all properties.
function popup_iuni_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_iuni (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

llista(1)={'select...'};
llista(2)={'vertical'};
llista(3)={'horizontal'};
llista(4)={'average'};
set(hObject,'string',llista)

% --- Executes on selection change in popup_iuni.
function popup_iuni_Callback(hObject, eventdata, handles)
% hObject    handle to popup_iuni (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popup_iuni contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_iuni

cmod=get(hObject,'Value')-2;
assignin('base','cmod',cmod);
evalin('base','als_opt.unimod.cmod=cmod;');
evalin('base','clear cmod');

% --- Executes during object creation, after setting all properties.
function popup_ncuni_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_ncuni (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

dim=evalin('base','min(size(als_opt.iniesta))');
j=2;
llistannc(1)={'select...'};
for i=0:1:dim;
    llistnnc=[i];
    llistannc(j)={llistnnc};
    j=j+1;
end;

set(hObject,'string',llistannc)

% --- Executes on selection change in popup_ncuni.
function popup_ncuni_Callback(hObject, eventdata, handles)
% hObject    handle to popup_ncuni (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popup_ncuni contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_ncuni
% --- Executes during object creation, after setting all properties.


nmod=get(hObject,'Value')-2;

assignin('base','nmod',nmod);
evalin('base','als_opt.unimod.nmod=nmod;');
dim=evalin('base','min(size(als_opt.iniesta))');
matc=evalin('base','als_opt.multi.matc');
curr_cmat=evalin('base','als_opt.multi.curr_cmat');
curr_smat=evalin('base','als_opt.multi.curr_smat');
spmod=evalin('base','als_opt.unimod.spmod');

if evalin('base','als_opt.multi.ccons')==1

    if nmod == dim
        spmod=ones(matc,dim);
        set(handles.text_spunic,'enable','off');
        set(handles.edit_spunic,'enable','off','string','');
    elseif  nmod == 0
        spmod=zeros(matc,dim);
        set(handles.text_spunic,'enable','off');
        set(handles.edit_spunic,'enable','off','string','');
    elseif  nmod == -1
        spmod=[];
        set(handles.text_spunic,'enable','off');
        set(handles.edit_spunic,'enable','off','string','');
    else
        spmod=[];
        set(handles.text_spunic,'enable','on');
        set(handles.edit_spunic,'enable','on');
    end

elseif evalin('base','als_opt.multi.ccons')==0

    if nmod == dim
        form_spmod=ones(1,dim);
        spmod(curr_cmat,:)=form_spmod;
        set(handles.text_spunic,'enable','off');
        set(handles.edit_spunic,'enable','off','string','');
    elseif  nmod == 0
        form_spmod=zeros(1,dim);
        spmod(curr_cmat,:)=form_spmod;
        set(handles.text_spunic,'enable','off');
        set(handles.edit_spunic,'enable','off','string','');
    elseif  nmod == -1
        evalin('base','als_opt.unimod.spmod=[]');
        set(handles.text_spunic,'enable','off');
        set(handles.edit_spunic,'enable','off','string','');
    else
        evalin('base','als_opt.unimod.spmod=[]');
        set(handles.text_spunic,'enable','on');
        set(handles.edit_spunic,'enable','on');
    end


end

assignin('base','spmod',spmod);
evalin('base','als_opt.unimod.spmod=spmod;');
evalin('base','clear spmod nmod');


function edit_spunic_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_spunic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_spunic_Callback(hObject, eventdata, handles)
% hObject    handle to edit_spunic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_spunic as text
%        str2double(get(hObject,'String')) returns contents of edit_spunic as a double

form_spmod= str2num(get(hObject,'String'));
matc=evalin('base','als_opt.multi.matc');
curr_cmat=evalin('base','als_opt.multi.curr_cmat');
spmod=evalin('base','als_opt.unimod.spmod');

if evalin('base','als_opt.multi.ccons')==1
    for i=1:matc;
        spmod(i,:)=form_spmod;
    end
elseif evalin('base','als_opt.multi.ccons')==0
    spmod(curr_cmat,:)=form_spmod;
end

assignin('base','spmod',spmod);
evalin('base','als_opt.unimod.spmod=spmod;');
evalin('base','clear spmod');


% --- Executes during object creation, after setting all properties.
function edit_tolunic_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tolunic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function edit_tolunic_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tolunic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tolunic as text
%        str2double(get(hObject,'String')) returns contents of edit_tolunic as a double

rmod= str2num(get(hObject,'String'));

if rmod==1,
    rmod=1.0001;
end

assignin('base','rmod',rmod);
evalin('base','als_opt.unimod.rmod=rmod;');
evalin('base','clear rmod');


% --- Executes during object creation, after setting all properties.
function popup_nsuni_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_nsuni (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

dim=evalin('base','min(size(als_opt.iniesta))');
j=2;
llistanns(1)={'select...'};
for i=0:1:dim;
    llistnns=[i];
    llistanns(j)={llistnns};
    j=j+1;
end;

set(hObject,'string',llistanns)


% --- Executes on selection change in popup_nsuni.
function popup_nsuni_Callback(hObject, eventdata, handles)
% hObject    handle to popup_nsuni (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popup_nsuni contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_nsuni


nsmod=get(hObject,'Value')-2;

assignin('base','nsmod',nsmod);
evalin('base','als_opt.unimod.nsmod=nsmod;');
dim=evalin('base','min(size(als_opt.iniesta))');
matr=evalin('base','als_opt.multi.matr');
curr_cmat=evalin('base','als_opt.multi.curr_cmat');
curr_smat=evalin('base','als_opt.multi.curr_smat');
spsmod=evalin('base','als_opt.unimod.spsmod');

if evalin('base','als_opt.multi.scons')==1

    if nsmod == dim
        spsmod=ones(matr,dim);
        set(handles.text_spunis,'enable','off');
        set(handles.edit_spunis,'enable','off','string','');
    elseif  nsmod == 0
        spsmod=ones(matr,dim);
        set(handles.text_spunis,'enable','off');
        set(handles.edit_spunis,'enable','off','string','');
    elseif  nsmod == -1
        spsmod=[];
        set(handles.text_spunis,'enable','off');
        set(handles.edit_spunis,'enable','off','string','');
    else
        spsmod=[];
        set(handles.text_spunis,'enable','on');
        set(handles.edit_spunis,'enable','on');
    end

elseif evalin('base','als_opt.multi.scons')==0

    if nsmod == dim
        form_spsmod=ones(1,dim);
        spsmod(curr_smat,:)=form_spsmod;
        set(handles.text_spunis,'enable','off');
        set(handles.edit_spunis,'enable','off','string','');
    elseif  nsmod == 0
        form_spsmod=zeros(1,dim);
        spsmod(curr_smat,:)=form_spsmod;
        set(handles.text_spunis,'enable','off');
        set(handles.edit_spunis,'enable','off','string','');
    elseif  nsmod == -1
        evalin('base','als_opt.unimod.spsmod=[]');
        set(handles.text_spunis,'enable','off');
        set(handles.edit_spunis,'enable','off','string','');
    else
        evalin('base','als_opt.unimod.spsmod=[];');
        set(handles.text_spunis,'enable','on');
        set(handles.edit_spunis,'enable','on');
    end


end

assignin('base','spsmod',spsmod);
evalin('base','als_opt.unimod.spsmod=spsmod;');
evalin('base','clear spsmod nsmod');


% --- Executes during object creation, after setting all properties.
function edit_spunis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_spunis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function edit_spunis_Callback(hObject, eventdata, handles)
% hObject    handle to edit_spunis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_spunis as text
%        str2double(get(hObject,'String')) returns contents of edit_spunis as a double


form_spsmod= str2num(get(hObject,'String'));
matr=evalin('base','als_opt.multi.matr');
curr_smat=evalin('base','als_opt.multi.curr_smat');
spsmod=evalin('base','als_opt.unimod.spsmod');

if evalin('base','als_opt.multi.scons')==1
    for i=1:matr;
        spsmod(:,i)=form_spsmod;
    end
elseif evalin('base','als_opt.multi.scons')==0
    spsmod(:,curr_smat)=form_spsmod;
end

assignin('base','spsmod',spsmod);
evalin('base','als_opt.unimod.spsmod=spsmod;');
evalin('base','clear spsmod');

% --- Executes during object creation, after setting all properties.
function edit_tolunis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tolunis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function edit_tolunis_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tolunis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tolunis as text
%        str2double(get(hObject,'String')) returns contents of edit_tolunis as a double

smod= str2num(get(hObject,'String'));

if smod==1,
    smod=1.0001;
end

assignin('base','smod',smod);
evalin('base','als_opt.unimod.smod=smod;');
evalin('base','clear smod');


% *************************************************************************
% closure
% *************************************************************************


% --- Executes on button press in check_clos.
function check_clos_Callback(hObject, eventdata, handles)
% hObject    handle to check_clos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_clos

closure=get(hObject,'Value');

if closure==1;
    set(handles.radio_cclos,'enable','on');
    set(handles.radio_sclos,'enable','on');
else
    set(handles.check_vclos,'enable','off','value',0);
    set(handles.text_vclos1,'enable','off');
    set(handles.edit_vclos1,'enable','off','string',' ');
    set(handles.text_vclos2,'enable','off');
    set(handles.edit_vclos2,'enable','off','string',' ');

    set(handles.radio_cclos,'enable','off','value',0);
    set(handles.radio_sclos,'enable','off','value',0);

    set(handles.text_nclos,'enable','off');
    set(handles.popup_nclos,'enable','off','value',1);

    set(handles.text_1clos,'enable','off');
    set(handles.edit_1clos,'enable','off','string',' ');
    set(handles.text_2clos,'enable','off');
    set(handles.edit_2clos,'enable','off','string',' ');

    set(handles.text_1closcond,'enable','off');
    set(handles.popup_1closcond,'enable','off','value',1);
    set(handles.text_2closcond,'enable','off');
    set(handles.popup_2closcond,'enable','off','value',1);

    set(handles.check_1clos,'enable','off','value',0);
    set(handles.check_2clos,'enable','off','value',0);
    set(handles.text_1spclos,'enable','off');
    set(handles.edit_1spclos,'enable','off','string',' ');
    set(handles.text_2spclos,'enable','off');
    set(handles.edit_2spclos,'enable','off','string',' ');

    evalin('base','als_opt=rmfield(als_opt,''closure'');');
end;

assignin('base','closure',closure);
evalin('base','als_opt.closure.closure=closure;');
evalin('base','clear closure');

vc=0;
assignin('base','vc',vc);
evalin('base','als_opt.closure.vc=vc;');
evalin('base','clear vc');


% --- Executes on button press in radio_cclos.
function radio_cclos_Callback(hObject, eventdata, handles)
% hObject    handle to radio_cclos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_cclos

dc=1;

set(handles.radio_sclos,'enable','off','value',0);

set(handles.text_nclos,'enable','on');
set(handles.popup_nclos,'enable','on','value',1);

set(handles.text_1clos,'enable','off');
set(handles.edit_1clos,'enable','off','string',' ');
set(handles.text_2clos,'enable','off');
set(handles.edit_2clos,'enable','off','string',' ');

set(handles.text_1closcond,'enable','off');
set(handles.popup_1closcond,'enable','off','value',1);
set(handles.text_2closcond,'enable','off');
set(handles.popup_2closcond,'enable','off','value',1);

set(handles.check_1clos,'enable','off','value',0);
set(handles.check_2clos,'enable','off','value',0);
set(handles.text_1spclos,'enable','off');
set(handles.edit_1spclos,'enable','off','string',' ');
set(handles.text_2spclos,'enable','off');
set(handles.edit_2spclos,'enable','off','string',' ');

set(handles.check_vclos,'enable','off');
set(handles.text_vclos1,'enable','off');
set(handles.edit_vclos1,'enable','off','string',' ');
set(handles.text_vclos2,'enable','off');
set(handles.edit_vclos2,'enable','off','string',' ');

dim=evalin('base','min(size(als_opt.iniesta))');
assignin('base','dim',dim);
matc=evalin('base','als_opt.multi.matc');
assignin('base','matc',matc);
matr=evalin('base','als_opt.multi.matr');
assignin('base','matr',matr);
evalin('base','als_opt.closure.tclos1(1:matc)=zeros(1,matc);');
evalin('base','als_opt.closure.tclos2(1:matc)=zeros(1,matc);');
evalin('base','als_opt.closure.sclos1(1:matc,1:dim)=zeros(matc,dim);');
evalin('base','als_opt.closure.sclos2(1:matc,1:dim)=zeros(matc,dim);');
evalin('base','als_opt.closure.iclos(1:matc)=zeros(1,matc);');
evalin('base','als_opt.closure.iclos1(1:matc)=zeros(1,matc);');
evalin('base','als_opt.closure.iclos2(1:matc)=zeros(1,matc);');
evalin('base','als_opt.closure.vclos1(1:matc)=zeros(1,matc);');
evalin('base','als_opt.closure.vclos2(1:matc)=zeros(1,matc);');

assignin('base','dc',dc);
evalin('base','als_opt.closure.dc=dc;');
evalin('base','clear dc dim matr matc');


% --- Executes on button press in radio_sclos.
function radio_sclos_Callback(hObject, eventdata, handles)
% hObject    handle to radio_sclos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_sclos

dc=2;

set(handles.radio_cclos,'enable','off','value',0);

set(handles.text_nclos,'enable','on');
set(handles.popup_nclos,'enable','on','value',1);

set(handles.text_1clos,'enable','off');
set(handles.edit_1clos,'enable','off','string',' ');
set(handles.text_2clos,'enable','off');
set(handles.edit_2clos,'enable','off','string',' ');

set(handles.text_1closcond,'enable','off');
set(handles.popup_1closcond,'enable','off','value',1);
set(handles.text_2closcond,'enable','off');
set(handles.popup_2closcond,'enable','off','value',1);

set(handles.check_1clos,'enable','off','value',0);
set(handles.check_2clos,'enable','off','value',0);
set(handles.text_1spclos,'enable','off');
set(handles.edit_1spclos,'enable','off','string',' ');
set(handles.text_2spclos,'enable','off');
set(handles.edit_2spclos,'enable','off','string',' ');

set(handles.check_vclos,'enable','off');
set(handles.text_vclos1,'enable','off');
set(handles.edit_vclos1,'enable','off','string',' ');
set(handles.text_vclos2,'enable','off');
set(handles.edit_vclos2,'enable','off','string',' ');

dim=evalin('base','min(size(als_opt.iniesta))');
assignin('base','dim',dim);
matc=evalin('base','als_opt.multi.matc');
assignin('base','matc',matc);
matr=evalin('base','als_opt.multi.matr');
assignin('base','matr',matr);
evalin('base','als_opt.closure.tclos1(1:matr)=zeros(1,matr);');
evalin('base','als_opt.closure.tclos2(1:matr)=zeros(1,matr);');
evalin('base','als_opt.closure.sclos1(1:matr,1:dim)=zeros(matr,dim);');
evalin('base','als_opt.closure.sclos2(1:matr,1:dim)=zeros(matr,dim);');
evalin('base','als_opt.closure.iclos(1:matr)=zeros(1,matr);');
evalin('base','als_opt.closure.iclos1(1:matr)=zeros(1,matr);');
evalin('base','als_opt.closure.iclos2(1:matr)=zeros(1,matr);');
evalin('base','als_opt.closure.vclos1(1:matr)=zeros(1,matr);');
evalin('base','als_opt.closure.vclos2(1:matr)=zeros(1,matr);');

assignin('base','dc',dc);
evalin('base','als_opt.closure.dc=dc;');
evalin('base','clear dc dim matr matc');


% --- Executes during object creation, after setting all properties.
function popup_nclos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_nclos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

llista(1)={'select...'};
llista(2)={'0'};
llista(3)={'1'};
llista(4)={'2'};
set(hObject,'string',llista)

% --- Executes on selection change in popup_nclos.
function popup_nclos_Callback(hObject, eventdata, handles)
% hObject    handle to popup_nclos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popup_nclos contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_nclos

form_iclos=get(hObject,'Value')-2;

if form_iclos == 1;
    set(handles.text_1clos,'enable','on');
    set(handles.edit_1clos,'enable','on');
    set(handles.text_1closcond,'enable','on');
    set(handles.popup_1closcond,'enable','on','value',1);
    set(handles.text_1spclos,'enable','on');
    set(handles.edit_1spclos,'enable','on');
    set(handles.text_2clos,'enable','off');
    set(handles.edit_2clos,'enable','off','string',' ');
    set(handles.text_2closcond,'enable','off');
    set(handles.popup_2closcond,'enable','off','value',1);
    set(handles.text_2spclos,'enable','off');
    set(handles.edit_2spclos,'enable','off','string',' ');
   
    set(handles.check_1clos,'enable','on','value',0);
    set(handles.check_2clos,'enable','off','value',0);
    set(handles.check_vclos,'enable','on','value',0);
    set(handles.text_vclos1,'enable','off');
    set(handles.edit_vclos1,'enable','off','string',' ');
    set(handles.text_vclos2,'enable','off');
    set(handles.edit_vclos2,'enable','off','string',' ');
elseif  form_iclos==2
    warndlg('Warning: there should not be common species to the two closures','WARNING!!');
    set(handles.text_1clos,'enable','on');
    set(handles.edit_1clos,'enable','on');
    set(handles.text_1closcond,'enable','on');
    set(handles.popup_1closcond,'enable','on','value',1);
    set(handles.text_1spclos,'enable','on');
    set(handles.edit_1spclos,'enable','on');
    set(handles.text_2clos,'enable','on');
    set(handles.edit_2clos,'enable','on');
    set(handles.text_2closcond,'enable','on');
    set(handles.popup_2closcond,'enable','on','value',1);
    set(handles.text_2spclos,'enable','on');
    set(handles.edit_2spclos,'enable','on');
    set(handles.check_1clos,'enable','on','value',0);
    set(handles.check_2clos,'enable','on','value',0);
    
    set(handles.check_vclos,'enable','on','value',0);
    set(handles.text_vclos1,'enable','off');
    set(handles.edit_vclos1,'enable','off','string',' ');
    set(handles.text_vclos2,'enable','off');
    set(handles.edit_vclos2,'enable','off','string',' ');
elseif  form_iclos==0
    set(handles.text_1clos,'enable','off');
    set(handles.edit_1clos,'enable','off','string',' ');
    set(handles.text_1closcond,'enable','off');
    set(handles.popup_1closcond,'enable','off','value',1);
    set(handles.text_1spclos,'enable','off');
    set(handles.edit_1spclos,'enable','off','string',' ');
    set(handles.text_2clos,'enable','off');
    set(handles.edit_2clos,'enable','off','string',' ');
    set(handles.text_2closcond,'enable','off');
    set(handles.popup_2closcond,'enable','off','value',1);
    set(handles.text_2spclos,'enable','off');
    set(handles.edit_2spclos,'enable','off','string',' ');
    set(handles.check_1clos,'enable','off','value',0);
    set(handles.check_2clos,'enable','off','value',0);
    
    set(handles.check_vclos,'enable','off','value',0);
    set(handles.text_vclos1,'enable','off');
    set(handles.edit_vclos1,'enable','off','string',' ');
    set(handles.text_vclos2,'enable','off');
    set(handles.edit_vclos2,'enable','off','string',' ');
else
    set(handles.text_1clos,'enable','off');
    set(handles.edit_1clos,'enable','off','string',' ');
    set(handles.text_1closcond,'enable','off');
    set(handles.popup_1closcond,'enable','off','value',1);
    set(handles.text_1spclos,'enable','off');
    set(handles.edit_1spclos,'enable','off','string',' ');
    set(handles.text_2clos,'enable','off');
    set(handles.edit_2clos,'enable','off','string',' ');
    set(handles.text_2closcond,'enable','off');
    set(handles.popup_2closcond,'enable','off','value',1);
    set(handles.text_2spclos,'enable','off');
    set(handles.edit_2spclos,'enable','off','string',' ');
    set(handles.check_1clos,'enable','off','value',0);
    set(handles.check_2clos,'enable','off','value',0);
    set(handles.check_vclos,'enable','off','value',0);
    set(handles.text_vclos1,'enable','off');
    set(handles.edit_vclos1,'enable','off','string',' ');
    set(handles.text_vclos2,'enable','off');
    set(handles.edit_vclos2,'enable','off','string',' ');
end

matr=evalin('base','als_opt.multi.matr');
matc=evalin('base','als_opt.multi.matc');
curr_cmat=evalin('base','als_opt.multi.curr_cmat');
curr_smat=evalin('base','als_opt.multi.curr_smat');
iclos=evalin('base','als_opt.closure.iclos');

if evalin('base','als_opt.multi.ccons')==1 | evalin('base','als_opt.multi.scons')==1

    if evalin('base','als_opt.closure.dc')==1
        iclos(1,[1:matc])=form_iclos;
    elseif evalin('base','als_opt.closure.dc')==2
        iclos(1,[1:matr])=form_iclos;
    end

else

    if evalin('base','als_opt.closure.dc')==1
        iclos(1,curr_cmat)=form_iclos;
    elseif evalin('base','als_opt.closure.dc')==2
        iclos(1,curr_smat)=form_iclos;
    end

end

assignin('base','iclos',iclos);
evalin('base','als_opt.closure.iclos=iclos;');
evalin('base','clear iclos matc matr curr_smat curr_cmat');


% --- Executes during object creation, after setting all properties.
function edit_1clos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_1clos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_1clos_Callback(hObject, eventdata, handles)
% hObject    handle to edit_1clos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_1clos as text
%        str2double(get(hObject,'String')) returns contents of edit_1clos as a double

form_tclos1= str2num(get(hObject,'String'));

matc=evalin('base','als_opt.multi.matc');
matr=evalin('base','als_opt.multi.matr');
curr_smat=evalin('base','als_opt.multi.curr_smat');
curr_cmat=evalin('base','als_opt.multi.curr_cmat');
tclos1=evalin('base','als_opt.closure.tclos1');

if evalin('base','als_opt.multi.ccons')==1 | evalin('base','als_opt.multi.scons')==1

    if evalin('base','als_opt.closure.dc')==1
        tclos1(1,[1:matc])=form_tclos1;
    elseif evalin('base','als_opt.closure.dc')==2
        tclos1(1,[1:matr])=form_tclos1;
    end

else

    if evalin('base','als_opt.closure.dc')==1
        tclos1(1,curr_cmat)=form_tclos1;
    elseif evalin('base','als_opt.closure.dc')==2
        tclos1(1,curr_smat)=form_tclos1;
    end
end

assignin('base','tclos1',tclos1);
evalin('base','als_opt.closure.tclos1=tclos1;');
evalin('base','clear tclos1 matc matr curr_smat curr_cmat');




% --- Executes during object creation, after setting all properties.
function edit_2clos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_2clos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function edit_2clos_Callback(hObject, eventdata, handles)
% hObject    handle to edit_2clos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_2clos as text
%        str2double(get(hObject,'String')) returns contents of edit_2clos as a double

form_tclos2= str2num(get(hObject,'String'));

matc=evalin('base','als_opt.multi.matc');
matr=evalin('base','als_opt.multi.matr');
curr_smat=evalin('base','als_opt.multi.curr_smat');
curr_cmat=evalin('base','als_opt.multi.curr_cmat');
tclos2=evalin('base','als_opt.closure.tclos2');

if evalin('base','als_opt.multi.ccons')==1 | evalin('base','als_opt.multi.scons')==1

    if evalin('base','als_opt.closure.dc')==1
        tclos2(1,[1:matc])=form_tclos2;
    elseif evalin('base','als_opt.closure.dc')==2
        tclos2(1,[1:matr])=form_tclos2;
    end

else

    if evalin('base','als_opt.closure.dc')==1
        tclos2(1,curr_cmat)=form_tclos2;
    elseif evalin('base','als_opt.closure.dc')==2
        tclos2(1,curr_smat)=form_tclos2;
    end

end

assignin('base','tclos2',tclos2);
evalin('base','als_opt.closure.tclos2=tclos2;');
evalin('base','clear tclos2 matc matr curr_smat curr_cmat');


% --- Executes during object creation, after setting all properties.
function popup_1closcond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_1closcond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

llista(1)={'select...'};
llista(2)={'equal than'};
llista(3)={'lower or equal than'};
set(hObject,'string',llista)

% --- Executes on selection change in popup_1closcond.
function popup_1closcond_Callback(hObject, eventdata, handles)
% hObject    handle to popup_1closcond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popup_1closcond contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_1closcond

form_iclos1=get(hObject,'Value')-1;

matc=evalin('base','als_opt.multi.matc');
matr=evalin('base','als_opt.multi.matr');
curr_smat=evalin('base','als_opt.multi.curr_smat');
curr_cmat=evalin('base','als_opt.multi.curr_cmat');
iclos1=evalin('base','als_opt.closure.iclos1');

if evalin('base','als_opt.multi.ccons')==1 | evalin('base','als_opt.multi.scons')==1

    if evalin('base','als_opt.closure.dc')==1
        iclos1(1,[1:matc])=form_iclos1;
    elseif evalin('base','als_opt.closure.dc')==2
        iclos1(1,[1:matr])=form_iclos1;
    end

else

    if evalin('base','als_opt.closure.dc')==1
        iclos1(1,curr_cmat)=form_iclos1;
    elseif evalin('base','als_opt.closure.dc')==2
        iclos1(1,curr_smat)=form_iclos1;
    end

end

assignin('base','iclos1',iclos1);
evalin('base','als_opt.closure.iclos1=iclos1;');
evalin('base','clear iclos1 matc matr curr_smat curr_cmat');



% --- Executes during object creation, after setting all properties.
function popup_2closcond_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_2closcond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

llista(1)={'select...'};
llista(2)={'equal than'};
llista(3)={'lower or equal than'};
set(hObject,'string',llista)

% --- Executes on selection change in popup_2closcond.
function popup_2closcond_Callback(hObject, eventdata, handles)
% hObject    handle to popup_2closcond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popup_2closcond contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_2closcond

form_iclos2=get(hObject,'Value')-1;

matc=evalin('base','als_opt.multi.matc');
matr=evalin('base','als_opt.multi.matr');
curr_smat=evalin('base','als_opt.multi.curr_smat');
curr_cmat=evalin('base','als_opt.multi.curr_cmat');
iclos2=evalin('base','als_opt.closure.iclos1');

if evalin('base','als_opt.multi.ccons')==1 | evalin('base','als_opt.multi.scons')==1

    if evalin('base','als_opt.closure.dc')==1
        iclos2(1,[1:matc])=form_iclos2;
    elseif evalin('base','als_opt.closure.dc')==2
        iclos2(1,[1:matr])=form_iclos2;
    end


else

    if evalin('base','als_opt.closure.dc')==1
        iclos2(1,curr_cmat)=form_iclos2;
    elseif evalin('base','als_opt.closure.dc')==2
        iclos2(1,curr_smat)=form_iclos2;
    end

end

assignin('base','iclos2',iclos2);
evalin('base','als_opt.closure.iclos2=iclos2;');
evalin('base','clear iclos2 matc matr curr_smat curr_cmat');

% --- Executes during object creation, after setting all properties.
function edit_1spclos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_1spclos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_1spclos_Callback(hObject, eventdata, handles)
% hObject    handle to edit_1spclos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_1spclos as text
%        str2double(get(hObject,'String')) returns contents of edit_1spclos as a double

form_sclos1= str2num(get(hObject,'String'));

matc=evalin('base','als_opt.multi.matc');
matr=evalin('base','als_opt.multi.matr');
curr_smat=evalin('base','als_opt.multi.curr_smat');
curr_cmat=evalin('base','als_opt.multi.curr_cmat');
sclos1=evalin('base','als_opt.closure.sclos1');

if evalin('base','als_opt.multi.ccons')==1 | evalin('base','als_opt.multi.scons')==1
    if evalin('base','als_opt.closure.dc')==1
        for i=1:matc;
            sclos1(i,:)=form_sclos1;
        end
    elseif evalin('base','als_opt.closure.dc')==2
        for i=1:matr;
            sclos1(i,:)=form_sclos1;
        end
    end
else
    if evalin('base','als_opt.closure.dc')==1
        sclos1(curr_cmat,:)=form_sclos1;
    elseif evalin('base','als_opt.closure.dc')==2
        sclos1(curr_smat,:)=form_sclos1;
    end
end

assignin('base','sclos1',sclos1);
evalin('base','als_opt.closure.sclos1=sclos1;');
evalin('base','clear sclos1 matc matr curr_smat curr_cmat');

% --- Executes on button press in check_1clos.
function check_1clos_Callback(hObject, eventdata, handles)
% hObject    handle to check_1clos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_1clos

check1clos=get(hObject,'Value');

if check1clos==0
    set(handles.text_1spclos,'enable','on');
    set(handles.edit_1spclos,'enable','on','string',' ');
    nsign=evalin('base','min(size(als_opt.iniesta))');
    ceros=zeros(1,nsign);
    
    matc=evalin('base','als_opt.multi.matc');
    matr=evalin('base','als_opt.multi.matr');
    curr_smat=evalin('base','als_opt.multi.curr_smat');
    curr_cmat=evalin('base','als_opt.multi.curr_cmat');
    sclos1=evalin('base','als_opt.closure.sclos1');

    if evalin('base','als_opt.multi.ccons')==1 | evalin('base','als_opt.multi.scons')==1
        if evalin('base','als_opt.closure.dc')==1
            for i=1:matc;
                sclos1(i,:)=ceros;
            end
        elseif evalin('base','als_opt.closure.dc')==2
            for i=1:matr;
                sclos1(i,:)=ceros;
            end
        end
    else
        if evalin('base','als_opt.closure.dc')==1
            sclos1(curr_cmat,:)=ceros;
        elseif evalin('base','als_opt.closure.dc')==2
            sclos1(curr_smat,:)=ceros;
        end
    end

    assignin('base','sclos1',sclos1);
    evalin('base','als_opt.closure.sclos1=sclos1;');
    evalin('base','clear sclos1 matc matr curr_smat curr_cmat');
    
    
elseif check1clos==1
        nsign=evalin('base','min(size(als_opt.iniesta))');
    unos=ones(1,nsign);
    set(handles.text_1spclos,'enable','on');
    set(handles.edit_1spclos,'enable','inactive','string',num2str(unos));


    matc=evalin('base','als_opt.multi.matc');
    matr=evalin('base','als_opt.multi.matr');
    curr_smat=evalin('base','als_opt.multi.curr_smat');
    curr_cmat=evalin('base','als_opt.multi.curr_cmat');
    sclos1=evalin('base','als_opt.closure.sclos1');

    if evalin('base','als_opt.multi.ccons')==1 | evalin('base','als_opt.multi.scons')==1
        if evalin('base','als_opt.closure.dc')==1
            for i=1:matc;
                sclos1(i,:)=unos;
            end
        elseif evalin('base','als_opt.closure.dc')==2
            for i=1:matr;
                sclos1(i,:)=unos;
            end
        end
    else
        if evalin('base','als_opt.closure.dc')==1
            sclos1(curr_cmat,:)=unos;
        elseif evalin('base','als_opt.closure.dc')==2
            sclos1(curr_smat,:)=unos;
        end
    end

    assignin('base','sclos1',sclos1);
    evalin('base','als_opt.closure.sclos1=sclos1;');
    evalin('base','clear sclos1 matc matr curr_smat curr_cmat');

end



% --- Executes during object creation, after setting all properties.
function edit_2spclos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_2spclos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_2spclos_Callback(hObject, eventdata, handles)
% hObject    handle to edit_2spclos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_2spclos as text
%        str2double(get(hObject,'String')) returns contents of edit_2spclos as a double

form_sclos2= str2num(get(hObject,'String'));

matc=evalin('base','als_opt.multi.matc');
matr=evalin('base','als_opt.multi.matr');
curr_smat=evalin('base','als_opt.multi.curr_smat');
curr_cmat=evalin('base','als_opt.multi.curr_cmat');
sclos2=evalin('base','als_opt.closure.sclos2');

if evalin('base','als_opt.multi.ccons')==1 | evalin('base','als_opt.multi.scons')==1

    if evalin('base','als_opt.closure.dc')==1
        for i=1:matc;
            sclos2(i,:)=form_sclos2;
        end
    elseif evalin('base','als_opt.closure.dc')==2
        for i=1:matr;
            sclos2(i,:)=form_sclos2;
        end
    end

else
    if evalin('base','als_opt.closure.dc')==1
        sclos2(curr_cmat,:)=form_sclos2;
    elseif evalin('base','als_opt.closure.dc')==2
        sclos2(curr_smat,:)=form_sclos2;
    end
end

assignin('base','sclos2',sclos2);
evalin('base','als_opt.closure.sclos2=sclos2;');
evalin('base','clear sclos2 matc matr curr_smat curr_cmat');




% --- Executes on button press in check_2clos.
function check_2clos_Callback(hObject, eventdata, handles)
% hObject    handle to check_2clos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_2clos



check2clos=get(hObject,'Value');

if check2clos==0
    nsign=evalin('base','min(size(als_opt.iniesta))');
    ceros=zeros(1,nsign);
    set(handles.text_2spclos,'enable','on');
    set(handles.edit_2spclos,'enable','on','string',' ');

    
    matc=evalin('base','als_opt.multi.matc');
    matr=evalin('base','als_opt.multi.matr');
    curr_smat=evalin('base','als_opt.multi.curr_smat');
    curr_cmat=evalin('base','als_opt.multi.curr_cmat');
    sclos2=evalin('base','als_opt.closure.sclos2');

    if evalin('base','als_opt.multi.ccons')==1 | evalin('base','als_opt.multi.scons')==1
        if evalin('base','als_opt.closure.dc')==1
            for i=1:matc;
                sclos2(i,:)=ceros;
            end
        elseif evalin('base','als_opt.closure.dc')==2
            for i=1:matr;
                sclos2(i,:)=ceros;
            end
        end
    else
        if evalin('base','als_opt.closure.dc')==1
            sclos2(curr_cmat,:)=ceros;
        elseif evalin('base','als_opt.closure.dc')==2
            sclos2(curr_smat,:)=ceros;
        end
    end

    assignin('base','sclos2',sclos2);
    evalin('base','als_opt.closure.sclos1=sclos2;');
    evalin('base','clear sclos2 matc matr curr_smat curr_cmat');
    
    
elseif check2clos==1
    nsign=evalin('base','min(size(als_opt.iniesta))');
    unos=ones(1,nsign);    
    set(handles.text_2spclos,'enable','on');
    set(handles.edit_2spclos,'enable','inactive','string',num2str(unos));


    matc=evalin('base','als_opt.multi.matc');
    matr=evalin('base','als_opt.multi.matr');
    curr_smat=evalin('base','als_opt.multi.curr_smat');
    curr_cmat=evalin('base','als_opt.multi.curr_cmat');
    sclos2=evalin('base','als_opt.closure.sclos2');

    if evalin('base','als_opt.multi.ccons')==1 | evalin('base','als_opt.multi.scons')==1
        if evalin('base','als_opt.closure.dc')==1
            for i=1:matc;
                sclos2(i,:)=unos;
            end
        elseif evalin('base','als_opt.closure.dc')==2
            for i=1:matr;
                sclos2(i,:)=unos;
            end
        end
    else
        if evalin('base','als_opt.closure.dc')==1
            sclos2(curr_cmat,:)=unos;
        elseif evalin('base','als_opt.closure.dc')==2
            sclos2(curr_smat,:)=unos;
        end
    end

    assignin('base','sclos2',sclos2);
    evalin('base','als_opt.closure.sclos2=sclos2;');
    evalin('base','clear sclos2 matc matr curr_smat curr_cmat');

end




% vclos -->


% --- Executes on button press in check_vclos.
function check_vclos_Callback(hObject, eventdata, handles)
% hObject    handle to check_vclos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_vclos

vclos=get(hObject,'Value');

if vclos==1;
    iclos=evalin('base','als_opt.closure.iclos');

    if evalin('base','als_opt.closure.dc')==1;
        activa=evalin('base','als_opt.multi.curr_cmat');
    elseif evalin('base','als_opt.closure.dc')==2;
        activa=evalin('base','als_opt.multi.curr_smat');
    end

    if iclos(activa)==1
        set(handles.text_vclos1,'enable','on');
        set(handles.edit_vclos1,'enable','on','string',' ');
        set(handles.text_vclos2,'enable','off');
        set(handles.edit_vclos2,'enable','off','string',' ');
        set(handles.text_1clos,'enable','off');
        set(handles.edit_1clos,'enable','off','string',' ');
        set(handles.text_2clos,'enable','off');
        set(handles.edit_2clos,'enable','off','string',' ');
        set(handles.text_1closcond,'enable','off');
        set(handles.popup_1closcond,'enable','off','value',1);
        set(handles.text_2closcond,'enable','off');
        set(handles.popup_2closcond,'enable','off','value',1);
        set(handles.text_1spclos,'enable','on');
        set(handles.edit_1spclos,'enable','on','value',1);
        set(handles.text_2spclos,'enable','off');
        set(handles.edit_2spclos,'enable','off','value',1);

        iclos1=1; % ha de ser igual
        assignin('base','iclos1',iclos1);
        evalin('base','als_opt.closure.iclos1=iclos1;');
        evalin('base','clear iclos1');

        vc=1; % ha de ser igual
        assignin('base','vc',vc);
        evalin('base','als_opt.closure.vc=vc;');
        evalin('base','clear vc');

    elseif iclos(activa)==2
        set(handles.text_vclos1,'enable','on');
        set(handles.edit_vclos1,'enable','on','string',' ');
        set(handles.text_vclos2,'enable','on');
        set(handles.edit_vclos2,'enable','on','string',' ');
        set(handles.text_1clos,'enable','off');
        set(handles.edit_1clos,'enable','off','string',' ');
        set(handles.text_2clos,'enable','off');
        set(handles.edit_2clos,'enable','off','string',' ');
        set(handles.text_1closcond,'enable','off');
        set(handles.popup_1closcond,'enable','off','value',1);
        set(handles.text_2closcond,'enable','off');
        set(handles.popup_2closcond,'enable','off','value',1);
        set(handles.text_1spclos,'enable','on');
        set(handles.edit_1spclos,'enable','on','value',1);
        set(handles.text_2spclos,'enable','on');
        set(handles.edit_2spclos,'enable','on','value',1);

        iclos1=1; % ha de ser igual
        assignin('base','iclos1',iclos1);
        evalin('base','als_opt.closure.iclos1=iclos1;');
        evalin('base','clear iclos1');

        iclos2=1; % ha de ser igual
        assignin('base','iclos2',iclos2);
        evalin('base','als_opt.closure.iclos2=iclos2;');
        evalin('base','clear iclos2');

        vc=1; % ha de ser igual
        assignin('base','vc',vc);
        evalin('base','als_opt.closure.vc=vc;');
        evalin('base','clear vc');

    end

else
    set(handles.text_vclos1,'enable','off');
    set(handles.edit_vclos1,'enable','off','string',' ');
    set(handles.text_vclos2,'enable','off');
    set(handles.edit_vclos2,'enable','off','string',' ');
    set(handles.text_nclos,'enable','on');
    set(handles.popup_nclos,'enable','on','value',1);
    set(handles.text_1clos,'enable','off');
    set(handles.edit_1clos,'enable','off','string',' ');
    set(handles.text_2clos,'enable','off');
    set(handles.edit_2clos,'enable','off','string',' ');
    set(handles.text_1closcond,'enable','off');
    set(handles.popup_1closcond,'enable','off','value',1);
    set(handles.text_2closcond,'enable','off');
    set(handles.popup_2closcond,'enable','off','value',1);
    set(handles.text_1spclos,'enable','off');
    set(handles.edit_1spclos,'enable','off','string',' ');
    set(handles.text_2spclos,'enable','off');
    set(handles.edit_2spclos,'enable','off','string',' ');

    vc=0; % ha de ser igual
    assignin('base','vc',vc);
    evalin('base','als_opt.closure.vc=vc;');
    evalin('base','clear vc');
end;


% --- Executes during object creation, after setting all properties.
function edit_vclos1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vclos1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_vclos1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vclos1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vclos1 as text
%        str2double(get(hObject,'String')) returns contents of edit_vclos1 as a double


vclos1=get(hObject,'String');
form_vclos1=evalin('base',vclos1);

matc=evalin('base','als_opt.multi.matc');
matr=evalin('base','als_opt.multi.matr');
curr_smat=evalin('base','als_opt.multi.curr_smat');
curr_cmat=evalin('base','als_opt.multi.curr_cmat');
vclos1=evalin('base','als_opt.closure.vclos1');

if evalin('base','als_opt.multi.ccons')==1 | evalin('base','als_opt.multi.scons')==1

    if evalin('base','als_opt.closure.dc')==1
        vclos1([1:matc],1)=form_vclos1;
    elseif evalin('base','als_opt.closure.dc')==2
        vclos1([1:matr],1)=form_vclos1;
    end

else

    if evalin('base','als_opt.closure.dc')==1
        vclos1(curr_cmat,1)=form_vclos1;
    elseif evalin('base','als_opt.closure.dc')==2
        vclos1(curr_smat,1)=form_vclos1;
    end

end

assignin('base','vclos1',vclos1);
evalin('base','als_opt.closure.vclos1=vclos1;');
evalin('base','clear vclos1 matc matr curr_smat curr_cmat');


% --- Executes during object creation, after setting all properties.
function edit_vclos2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vclos2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_vclos2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vclos2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vclos2 as text
%        str2double(get(hObject,'String')) returns contents of edit_vclos2 as a double

vclos2=get(hObject,'String');
form_vclos2=evalin('base',vclos2);

matc=evalin('base','als_opt.multi.matc');
matr=evalin('base','als_opt.multi.matr');
curr_smat=evalin('base','als_opt.multi.curr_smat');
curr_cmat=evalin('base','als_opt.multi.curr_cmat');
vclos2=evalin('base','als_opt.closure.vclos2');

if evalin('base','als_opt.multi.ccons')==1 | evalin('base','als_opt.multi.scons')==1

    if evalin('base','als_opt.closure.dc')==1
        vclos2([1:matc],1)=form_vclos2;
    elseif evalin('base','als_opt.closure.dc')==2
        vclos2([1:matr],1)=form_vclos2;
    end

else

    if evalin('base','als_opt.closure.dc')==1
        vclos2(curr_cmat,1)=form_vclos2;
    elseif evalin('base','als_opt.closure.dc')==2
        vclos2(curr_smat,1)=form_vclos2;
    end

end

assignin('base','vclos2',vclos2);
evalin('base','als_opt.closure.vclos2=vclos2;');
evalin('base','clear vclos2 matc matr curr_smat curr_cmat');



% *************************************************************************
% csel i ssel
% *************************************************************************


% --- Executes on button press in check_csel.
function check_csel_Callback(hObject, eventdata, handles)
% hObject    handle to check_csel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_csel

cselcon=get(hObject,'Value');

if cselcon==1;
    set(handles.text_selcsel,'enable','on');
    set(handles.edit_selcsel,'enable','on','string',' ');
    set(handles.text_cconsel,'enable','on');
    set(handles.popup_csel,'enable','on','value',1);
else
    set(handles.text_selcsel,'enable','off');
    set(handles.edit_selcsel,'enable','off','string',' ');
    set(handles.text_cconsel,'enable','off');
    set(handles.popup_csel,'enable','off','value',1);

    evalin('base','als_opt=rmfield(als_opt,''cselc'');');

end;
assignin('base','cselcon',cselcon);
evalin('base','als_opt.cselc.cselcon=cselcon;');
evalin('base','clear cselcon');

% --- Executes during object creation, after setting all properties.
function popup_csel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_csel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

llista(1)={'select...'};
llista(2)={'equal than'};
llista(3)={'lower or equal than'};
set(hObject,'string',llista)


% --- Executes on selection change in popup_csel.
function popup_csel_Callback(hObject, eventdata, handles)
% hObject    handle to popup_csel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popup_csel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_csel

type_csel=get(hObject,'Value')-2;
assignin('base','type_csel',type_csel);
evalin('base','als_opt.cselc.type_csel=type_csel;');
evalin('base','clear type_csel');


% --- Executes during object creation, after setting all properties.
function edit_selcsel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_selcsel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_selcsel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_selcsel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_selcsel as text
%        str2double(get(hObject,'String')) returns contents of edit_selcsel as a double

selcsel_char=get(hObject,'String');

selcsel=evalin('base',selcsel_char);
iisel=find(isfinite(selcsel));

assignin('base','selcsel',selcsel);
assignin('base','iisel',iisel);

evalin('base','als_opt.cselc.iisel=iisel;');
evalin('base','als_opt.cselc.csel=selcsel;');
evalin('base','clear selcsel iisel');


% --- Executes on button press in check_ssel.
function check_ssel_Callback(hObject, eventdata, handles)
% hObject    handle to check_ssel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_ssel

sselcon=get(hObject,'Value');

if sselcon==1;
    set(handles.text_selssel,'enable','on');
    set(handles.edit_selssel,'enable','on','string',' ');
    set(handles.text_sconsel,'enable','on');
    set(handles.popup_ssel,'enable','on','value',1);
else
    set(handles.text_selssel,'enable','off');
    set(handles.edit_selssel,'enable','off','string',' ');
    set(handles.text_sconsel,'enable','off');
    set(handles.popup_ssel,'enable','off','value',1);

    evalin('base','als_opt=rmfield(als_opt,''sselc'');');

end;
assignin('base','sselcon',sselcon);
evalin('base','als_opt.sselc.sselcon=sselcon;');
evalin('base','clear sselcon');


% --- Executes during object creation, after setting all properties.
function popup_ssel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_ssel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

llista(1)={'select...'};
llista(2)={'equal than'};
llista(3)={'lower or equal than'};
set(hObject,'string',llista)

% --- Executes on selection change in popup_ssel.
function popup_ssel_Callback(hObject, eventdata, handles)
% hObject    handle to popup_ssel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popup_ssel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_ssel

type_ssel=get(hObject,'Value')-2;
assignin('base','type_ssel',type_ssel);
evalin('base','als_opt.sselc.type_ssel=type_ssel;');
evalin('base','clear type_ssel iisel');

% --- Executes during object creation, after setting all properties.
function edit_selssel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_selssel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_selssel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_selssel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_selssel as text
%        str2double(get(hObject,'String')) returns contents of edit_selssel as a double


selssel_char=get(hObject,'String');

selssel=evalin('base',selssel_char);
jjsel=find(isfinite(selssel));

assignin('base','selssel',selssel);
assignin('base','jjsel',jjsel);

evalin('base','als_opt.sselc.ssel=selssel;');
evalin('base','als_opt.sselc.jjsel=jjsel;');
evalin('base','clear selssel jjsel');


% *************************************************************************
% trilinear
% *************************************************************************


% --- Executes on button press in check_trilin.
function check_trilin_Callback(hObject, eventdata, handles)
% hObject    handle to check_trilin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_trilin

tril=get(hObject,'Value');

if tril==1;
    set(handles.text_3way,'enable','on');
    set(handles.popup_3way,'enable','on','value',1);
else
    set(handles.text_app,'enable','off');
    set(handles.radio_Ctrilin,'enable','off','value',0);
    set(handles.radio_Strilin,'enable','off','value',0);
    set(handles.radio_CStrilin,'enable','off','value',0);

    set(handles.text_3way,'enable','off');
    set(handles.popup_3way,'enable','off','value',1);

    set(handles.text_Ctrilin,'enable','off');
    set(handles.edit_Ctrilin,'enable','off','string',' ');
    set(handles.text_Strilin,'enable','off');
    set(handles.edit_Strilin,'enable','off','string',' ');

    evalin('base','als_opt=rmfield(als_opt,''trilin'');');
end;

assignin('base','tril',tril);
evalin('base','als_opt.trilin.tril=tril;');
evalin('base','clear tril');


% --- Executes during object creation, after setting all properties.
function popup_3way_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_3way (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

llista(1)={'select...'};
llista(2)={'No trilinear'};
llista(3)={'trilinear, equal shape & sinchronization (all species)'};
llista(4)={'trilinear without sinchronization (all species)'};
llista(5)={'trilinear and synchronization for only some species'};
set(hObject,'string',llista)

% --- Executes on selection change in popup_3way.
function popup_3way_Callback(hObject, eventdata, handles)
% hObject    handle to popup_3way (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popup_3way contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_3way


ishape=get(hObject,'Value')-2;

dim=evalin('base','min(size(als_opt.iniesta))');
trildir=99;
spetric=zeros(1,dim);
spetris=zeros(1,dim);

if ishape==0
    set(handles.text_app,'enable','off');
    set(handles.radio_Ctrilin,'enable','off','value',0);
    set(handles.radio_Strilin,'enable','off','value',0);
    set(handles.radio_CStrilin,'enable','off','value',0);

    set(handles.text_Ctrilin,'enable','off');
    set(handles.edit_Ctrilin,'enable','off','string',' ');
    set(handles.text_Strilin,'enable','off');
    set(handles.edit_Strilin,'enable','off','string',' ');



elseif ishape==1 | ishape==2 | ishape==3
    if evalin('base','als_opt.multi.datamod')==3
        set(handles.text_app,'enable','on');
        set(handles.radio_Ctrilin,'enable','on','value',0);
        set(handles.radio_Strilin,'enable','on','value',0);
        set(handles.radio_CStrilin,'enable','on','value',0);

        set(handles.text_Ctrilin,'enable','off');
        set(handles.edit_Ctrilin,'enable','off','string',' ');
        set(handles.text_Strilin,'enable','off');
        set(handles.edit_Strilin,'enable','off','string',' ');
    elseif evalin('base','als_opt.multi.datamod')==2
        trildir=2;
        set(handles.text_app,'enable','on');
        set(handles.radio_Ctrilin,'enable','off','value',0);
        set(handles.radio_Strilin,'enable','on','value',1);
        set(handles.radio_CStrilin,'enable','off','value',0);

        set(handles.text_Ctrilin,'enable','off');
        set(handles.edit_Ctrilin,'enable','off','string',' ');
        set(handles.text_Strilin,'enable','on');
        set(handles.edit_Strilin,'enable','on');

    elseif evalin('base','als_opt.multi.datamod')==1
        trildir=1;
        set(handles.text_app,'enable','on');
        set(handles.radio_Ctrilin,'enable','on','value',1);
        set(handles.radio_Strilin,'enable','off','value',0);
        set(handles.radio_CStrilin,'enable','off','value',0);

        set(handles.text_Ctrilin,'enable','on');
        set(handles.edit_Ctrilin,'enable','on','string',' ');
        set(handles.text_Strilin,'enable','off');
        set(handles.edit_Strilin,'enable','off','string',' ');


    end


    if trildir==1 | trildir==3
        if ishape==1|ishape==2
            spetric=ones(1,dim);
            set(handles.text_Ctrilin,'enable','on');
            set(handles.edit_Ctrilin,'enable','on','string',num2str(spetric));


        end
    end

    if trildir==2 | trildir==3
        if ishape==1|ishape==2
            spetris=ones(1,dim);
            set(handles.text_Strilin,'enable','on');
            set(handles.edit_Strilin,'enable','on','string',num2str(spetris));


        end
    end

elseif ishape==-1

    set(handles.text_app,'enable','off');
    set(handles.radio_Ctrilin,'enable','off','value',0);
    set(handles.radio_Strilin,'enable','off','value',0);
    set(handles.radio_CStrilin,'enable','off','value',0);

    set(handles.text_Ctrilin,'enable','off');
    set(handles.edit_Ctrilin,'enable','off','string',' ');
    set(handles.text_Strilin,'enable','off');
    set(handles.edit_Strilin,'enable','off','string',' ');
end

assignin('base','ishape',ishape);
evalin('base','als_opt.trilin.ishape=ishape;');
evalin('base','clear ishape');

        assignin('base','trildir',trildir);
        evalin('base','als_opt.trilin.trildir=trildir;');
        evalin('base','clear trildir');

            assignin('base','spetris',spetris);
            evalin('base','als_opt.trilin.spetris=spetris;');
            evalin('base','clear spetris');

                        assignin('base','spetric',spetric);
            evalin('base','als_opt.trilin.spetric=spetric;');
            evalin('base','clear spetric');
            

% --- Executes on button press in radio_Ctrilin.
function radio_Ctrilin_Callback(hObject, eventdata, handles)
% hObject    handle to radio_Ctrilin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_Ctrilin

trildir=1;
set(handles.radio_Ctrilin,'enable','on');
set(handles.radio_Strilin,'enable','off','value',0);
set(handles.radio_CStrilin,'enable','off','value',0);

set(handles.text_Ctrilin,'enable','on');
set(handles.edit_Ctrilin,'enable','on');
set(handles.text_Strilin,'enable','off');
set(handles.edit_Strilin,'enable','off','string',' ');

assignin('base','trildir',trildir);
evalin('base','als_opt.trilin.trildir=trildir;');
evalin('base','clear trildir');

% --- Executes on button press in radio_Strilin.
function radio_Strilin_Callback(hObject, eventdata, handles)
% hObject    handle to radio_Strilin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_Strilin

trildir=2;
set(handles.radio_Strilin,'enable','on');
set(handles.radio_Ctrilin,'enable','off','value',0);
set(handles.radio_CStrilin,'enable','off','value',0);

set(handles.text_Strilin,'enable','on');
set(handles.edit_Strilin,'enable','on');
set(handles.text_Ctrilin,'enable','off');
set(handles.edit_Ctrilin,'enable','off','string',' ');

assignin('base','trildir',trildir);
evalin('base','als_opt.trilin.trildir=trildir;');
evalin('base','clear trildir');

% --- Executes on button press in radio_CStrilin.
function radio_CStrilin_Callback(hObject, eventdata, handles)
% hObject    handle to radio_CStrilin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_CStrilin

trildir=3;
set(handles.radio_Ctrilin,'enable','off','value',0);
set(handles.radio_Strilin,'enable','off','value',0);
set(handles.radio_CStrilin,'enable','on');

set(handles.text_Ctrilin,'enable','on');
set(handles.edit_Ctrilin,'enable','on');
set(handles.text_Strilin,'enable','on');
set(handles.edit_Strilin,'enable','on');

assignin('base','trildir',trildir);
evalin('base','als_opt.trilin.trildir=trildir;');
evalin('base','clear trildir');


% --- Executes during object creation, after setting all properties.
function edit_Ctrilin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Ctrilin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function edit_Ctrilin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Ctrilin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Ctrilin as text
%        str2double(get(hObject,'String')) returns contents of edit_Ctrilin as a double


spetric= str2num(get(hObject,'String'));

assignin('base','spetric',spetric);
evalin('base','als_opt.trilin.spetric=spetric;');
evalin('base','clear spetric');

% --- Executes during object creation, after setting all properties.
function edit_Strilin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Strilin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit_Strilin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Strilin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Strilin as text
%        str2double(get(hObject,'String')) returns contents of edit_Strilin as a double


spetris= str2num(get(hObject,'String'));

assignin('base','spetris',spetris);
evalin('base','als_opt.trilin.spetris=spetris;');
evalin('base','clear spetris');

% *************************************************************************
% optimization parameters 
% *************************************************************************

% --- Executes during object creation, after setting all properties.
function edit_iter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

nit=str2num(get(hObject,'String'));

assignin('base','nit',nit);
evalin('base','als_opt.opt.nit=nit;');
evalin('base','clear nit');


function edit_iter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_iter as text
%        str2double(get(hObject,'String')) returns contents of edit_iter as a double

nit=str2num(get(hObject,'String'));

assignin('base','nit',nit);
evalin('base','als_opt.opt.nit=nit;');
evalin('base','clear nit');

% --- Executes during object creation, after setting all properties.
function edit_conv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_conv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

tolsigma=str2num(get(hObject,'String'));

assignin('base','tolsigma',tolsigma);
evalin('base','als_opt.opt.tolsigma=tolsigma;');
evalin('base','clear tolsigma');


function edit_conv_Callback(hObject, eventdata, handles)
% hObject    handle to edit_conv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_conv as text
%        str2double(get(hObject,'String')) returns contents of edit_conv as a double


tolsigma=str2num(get(hObject,'String'));

assignin('base','tolsigma',tolsigma);
evalin('base','als_opt.opt.tolsigma=tolsigma;');
evalin('base','clear tolsigma');

% --- Executes on button press in check_graf.
function check_graf_Callback(hObject, eventdata, handles)
% hObject    handle to check_graf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_graf

val=get(hObject,'Value');

if val==1
    gr='y';
else
    gr='n';
end

assignin('base','gr',gr);
evalin('base','als_opt.opt.gr=gr;');
evalin('base','clear gr');


% *************************************************************************
% output 
% *************************************************************************

% --- Executes during object creation, after setting all properties.
function out_conc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to out_conc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

out=get(hObject,'String');

assignin('base','out_conc',out);
evalin('base','als_opt.out.out_conc=out_conc;');
evalin('base','clear out_conc');

function out_conc_Callback(hObject, eventdata, handles)
% hObject    handle to out_conc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of out_conc as text
%        str2double(get(hObject,'String')) returns contents of out_conc as a double

out=get(hObject,'String');

assignin('base','out_conc',out);
evalin('base','als_opt.out.out_conc=out_conc;');
evalin('base','clear out_conc');

% --- Executes during object creation, after setting all properties.
function out_spec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to out_spec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

out=get(hObject,'String');

assignin('base','out_spec',out);
evalin('base','als_opt.out.out_spec=out_spec;');
evalin('base','clear out_spec');

function out_spec_Callback(hObject, eventdata, handles)
% hObject    handle to out_spec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of out_spec as text
%        str2double(get(hObject,'String')) returns contents of out_spec as a double

out=get(hObject,'String');

assignin('base','out_spec',out);
evalin('base','als_opt.out.out_spec=out_spec;');
evalin('base','clear out_spec');

% --- Executes during object creation, after setting all properties.
function out_res_CreateFcn(hObject, eventdata, handles)
% hObject    handle to out_res (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

out=get(hObject,'String');

assignin('base','out_res',out);
evalin('base','als_opt.out.out_res=out_res;');
evalin('base','clear out_res');

function out_res_Callback(hObject, eventdata, handles)
% hObject    handle to out_res (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of out_res as text
%        str2double(get(hObject,'String')) returns contents of out_res as a double

out=get(hObject,'String');

assignin('base','out_res',out);
evalin('base','als_opt.out.out_res=out_res;');
evalin('base','clear out_res');

% --- Executes during object creation, after setting all properties.
function out_std_CreateFcn(hObject, eventdata, handles)
% hObject    handle to out_std (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

out=get(hObject,'String');

assignin('base','out_std',out);
evalin('base','als_opt.out.out_std=out_std;');
evalin('base','clear out_std');

function out_std_Callback(hObject, eventdata, handles)
% hObject    handle to out_std (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of out_std as text
%        str2double(get(hObject,'String')) returns contents of out_std as a double

out=get(hObject,'String');

assignin('base','out_std',out);
evalin('base','als_opt.out.out_std=out_std;');
evalin('base','clear out_std');

% --- Executes during object creation, after setting all properties.
function out_area_CreateFcn(hObject, eventdata, handles)
% hObject    handle to out_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

out=get(hObject,'String');

assignin('base','out_area',out);
evalin('base','als_opt.out.out_area=out_area;');
evalin('base','clear out_area');

function out_area_Callback(hObject, eventdata, handles)
% hObject    handle to out_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of out_area as text
%        str2double(get(hObject,'String')) returns contents of out_area as a double

out=get(hObject,'String');

assignin('base','out_area',out);
evalin('base','als_opt.out.out_area=out_area;');
evalin('base','clear out_area');

% --- Executes during object creation, after setting all properties.
function out_rat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to out_rat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

out=get(hObject,'String');

assignin('base','out_rat',out);
evalin('base','als_opt.out.out_rat=out_rat;');
evalin('base','clear out_rat');


function out_rat_Callback(hObject, eventdata, handles)
% hObject    handle to out_rat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of out_rat as text
%        str2double(get(hObject,'String')) returns contents of out_rat as a double

out=get(hObject,'String');

assignin('base','out_rat',out);
evalin('base','als_opt.out.out_rat=out_rat;');
evalin('base','clear out_rat');


% *************************************************************************
% buttons
% *************************************************************************


% --- Executes on button press in but_done.
function but_done_Callback(hObject, eventdata, handles)
% hObject    handle to but_done (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('done');
close;

% --- Executes on button press in but_can.
function but_can_Callback(hObject, eventdata, handles)
% hObject    handle to but_can (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('cancel');
evalin('base','clear als_opt;');
close;

% --- Executes on button press in but_opt.
function but_opt_Callback(hObject, eventdata, handles)
% hObject    handle to but_opt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('optimization');

evalin('base','als_opt.closure.closure;');

if evalin('base','als_opt.closure.closure')==0;
    closure_no;
end


%**************************************************************************
%**************************************************************************
%**************************************************************************


% A) DATA PREPARATION AND INPUT

% INITIALIZATIONS

nsign=evalin('base','min(size(als_opt.iniesta))');
matdad=evalin('base','als_opt.matdad');
iniesta=evalin('base','als_opt.iniesta');
nexp=evalin('base','als_opt.nexp');
matc=evalin('base','als_opt.multi.matc');
matr=evalin('base','als_opt.multi.matr');
isp=evalin('base','als_opt.multi.isp');
nrinic=evalin('base','als_opt.multi.nrinic');
nrfin=evalin('base','als_opt.multi.nrfin');
nrsol=evalin('base','als_opt.multi.nrsol');
ncinic=evalin('base','als_opt.multi.ncinic');
ncfin=evalin('base','als_opt.multi.ncfin');



[nrow,ncol]=size(matdad);
[nrow2,ncol2]=size(iniesta);

if nrow2==nrow,	nsign=ncol2; ils=1;end
if ncol2==nrow, nsign=nrow2; iniesta=iniesta'; ils=1; end
if ncol2==ncol, nsign=nrow2; ils=2;end
if nrow2==ncol, nsign=ncol2; iniesta=iniesta'; ils=2; end
if ils==1,
    conc=iniesta;
    [nrow,nsign]=size(conc);
    abss=conc\matdad;
end
if ils==2,
    abss=iniesta;
    [nsign,ncol]=size(abss);
    conc=matdad/abss;
end

if nexp==1,
    ncinic(nexp)=1;
    ncfin(nexp)=ncol;
    nrinic(nexp)=1;
    nrfin(nexp)=nrow;
end

niter=0;% iterations counter
idev=0;% divergence counter
idevmax=10;% maximum number of diverging iterations
answer='n'; % default answer
ineg=0;% used for non-negativity constraints
imod=0;% used for unimodality constraints
iclos0=0;% used for closure constraints
iassim=0;% used for shape constraints
datamod=99;% in three-way type of matrix augmentation (1=row,2=column)
vclos1n=0;% used for closure constraints
vclos2n=0;% used for closure constraints
inorm=0;% no normalizatio (when closurfe is applied)
type_csel=[]; %no equality/lower than constraints in concentrations
type_ssel=[]; %no equality/lower than constraints in spectra

%***************************
% DEFINITION OF THE DATA SET
%***************************

totalconc(1:nsign,1:nexp)=ones(nsign,nexp);

% WHEN ONLY ONE EXPERIMENT IS PRESENT EVERYTHING IS CLEAR

if nexp==1
    nrsol(1)=nrow;
    nrinic(1)=1;
    nrfin(1)=nrsol(1);
    nesp(1)=nsign;
    matr = 1;
    matc = 1;
    isp(1,1:nsign)=ones(1,nsign);
end
ishape=0;


% ***************************
% B) SELECTION OF CONSTRAINTS
% ***************************


% ***********************************************************
% C) REPRODUCTION OF THE ORIGINAL DATA MATRIX BY PCA
% ***********************************************************

% dn is the experimental matrix and d is the PCA reproduced matrix
d=evalin('base','als_opt.matdad');
dn=d;
[u,s,v,d,sd]=pcarep(dn,nsign);

sstn=sum(sum(dn.*dn));
sst=sum(sum(d.*d));
sigma2=sqrt(sstn);

% ************************************************************
% D) STARTING ALTERNATING CONSTRAINED LEAST SQUARES OPTIMIZATION
% ************************************************************

while niter < evalin('base','als_opt.opt.nit');

    niter=niter+1;

    % ***************************************
    % E) ESTIMATE CONCENTRATIONS (ALS solutions)
    % ***************************************

    conc=d/abss;

    % ******************************************
    % CONSTRAIN APPROPRIATELY THE CONCENTRATIONS
    % ******************************************

    % ****************
    % non-negativity
    % ****************

    if evalin('base','als_opt.noneg.noneg')==1

        ineg=evalin('base','als_opt.noneg.ineg');
        if ineg ==1 |ineg==2,
     
        ialg=evalin('base','als_opt.noneg.ialg');
        ncneg=evalin('base','als_opt.noneg.ncneg');
        cneg=evalin('base','als_opt.noneg.cneg');

        for i =1:matc
            kinic=nrinic(i);
            kfin=nrfin(i);
            conc2=conc(kinic:kfin,:);

            if ialg==0
                for k=1:nsign,
                    if cneg(i,k) ==1
                        for j=1:kfin+1-kinic,
                            if conc2(j,k)<0.0,
                                conc2(j,k)=0.0;
                            end
                        end
                    end
                end
            end

            if ialg==1
                for j=kinic:kfin
                    if cneg(i,:) == ones(1,size(isp,2))
                        x=lsqnonneg(abss',d(j,:)');
                        conc2(j-kinic+1,:)=x';
                    end
                end
            end

            if ialg==2
                for j=kinic:kfin
                    if cneg(i,:) == ones(1,size(isp,2))
                        x=fnnls(abss*abss',abss*d(j,:)');
                        conc2(j-kinic+1,:)=x';
                    end
                end
            end

            conc(kinic:kfin,:) = conc2;
        end
    end

    end
    % ************
    % trilinearity
    % ************

    if evalin('base','als_opt.trilin.tril')==1

        ishape=evalin('base','als_opt.trilin.ishape');

        if evalin('base','als_opt.trilin.ishape')>=1

            trildir=evalin('base','als_opt.trilin.trildir');

            spetric=evalin('base','als_opt.trilin.spetric');
            spetris=evalin('base','als_opt.trilin.spetris');


            if trildir==1|trildir==3
                for j=1:nsign,
                    if spetric(j)==1,
                        [conc(:,j),t]=trilin(conc(:,j),matc,ishape);
                        totalconc(j,1:matc)=t;
                        if totalconc(j,1)>0,
                            rt(j,1:matc)=totalconc(j,1:matc)./totalconc(j,1);
                        else
                            rt(j,1:matc)=totalconc(j,1:matc);
                        end
                    end
                end
            end
        end
    end
    % **************************
    % zero concentration species
    % **************************

    if matc>1
        for i=1:matc,
            for j=1:nsign,
                if isp(i,j)==0,
                    conc(nrinic(i):nrfin(i),j)=zeros(nrsol(i),1);
                end
            end
        end
    end



    % ***********
    % unimodality
    % ***********

    if evalin('base','als_opt.unimod.unimodal')==1

        for i = 1:matc

            kinic=nrinic(i);
            kfin=nrfin(i);
            conc2=conc(kinic:kfin,:);

            imod=evalin('base','als_opt.unimod.imod');

            if imod==1|imod==3,

                spmod=evalin('base','als_opt.unimod.spmod');
                cmod=evalin('base','als_opt.unimod.cmod');
                rmod=evalin('base','als_opt.unimod.rmod');

                for ii=1:nsign,
                    if spmod(i,ii)==1,
                        conc2(:,ii)=unimod(conc2(:,ii),rmod,cmod);
                    end
                end

            end

            conc(kinic:kfin,:)=conc2;
        end

    end


    % ********
    % closure
    % ********

    if evalin('base','als_opt.closure.closure')==1;

        dc=evalin('base','als_opt.closure.dc');
        vc=evalin('base','als_opt.closure.vc');
        iclos=evalin('base','als_opt.closure.iclos');
        tclos1(1:matc)=zeros(1,matc);
        tclos2(1:matc)=zeros(1,matc);
        sclos1(1:matc,1:nsign)=zeros(matc,nsign);
        sclos2(1:matc,1:nsign)=zeros(matc,nsign);
        iclos1(1:matc)=zeros(1,matc);
        iclos2(1:matc)=zeros(1,matc);
        vclos1=0;
        vclos2=0;

        if iclos(i)==1

            iclos1=evalin('base','als_opt.closure.iclos1');
            sclos1=evalin('base','als_opt.closure.sclos1');

            if vc==0
                tclos1=evalin('base','als_opt.closure.tclos1');
            else
                vclos1=evalin('base','als_opt.closure.vclos1');
            end

        elseif iclos(i)==2

            iclos1=evalin('base','als_opt.closure.iclos1');
            iclos2=evalin('base','als_opt.closure.iclos2');
            sclos1=evalin('base','als_opt.closure.sclos1');
            sclos2=aevalin('base','als_opt.closure.sclos2');

            if vc==0
                tclos1=evalin('base','als_opt.closure.tclos1');
                tclos2=evalin('base','als_opt.closure.tclos2');
            else
                vclos1=evalin('base','als_opt.closure.vclos1');
                vclos2=evalin('base','als_opt.closure.vclos2');
            end

        end

        if dc == 1
            for i = 1:matc

                kinic=nrinic(i);
                kfin=nrfin(i);
                conc2=conc(kinic:kfin,:);

                if iclos(i)==1 | iclos(i)==2,
                    if tclos1(i) == 0
                        vclos1n=vclos1(kinic:kfin,1);
                    end

                    if iclos(i) ==2 & tclos2(i)==0
                        vclos2n=vclos2(kinic:kfin,1);
                    end

                    [conc2]=closure(conc2,iclos(i),sclos1(i,:),iclos1(i),tclos1(i),tclos2(i),sclos2(i,:),iclos2(i),vclos1n,vclos2n);
                end
                conc(kinic:kfin,:)=conc2;
            end
        end
    end

    % ****************************
    % EQUALITY CONSTRAINTS IN CONC
    % ****************************

    if evalin('base','als_opt.cselc.cselcon')==1

        csel=evalin('base','als_opt.cselc.csel');
        type_csel=evalin('base','als_opt.cselc.type_csel');
        iisel=evalin('base','als_opt.cselc.iisel');


        if type_csel==0,
            conc(iisel)=csel(iisel);
        end
        if type_csel==1
            for ii=1:size(iisel),
                if conc(iisel(ii))>csel(iisel(ii)),
                    conc(iisel(ii))=csel(iisel(ii));
                end
            end
        end
    end

    


    % ******************************
    % DISPLAY CONCENTRATION PROFILES
    % ******************************

    if evalin('base','als_opt.opt.gr')=='y',
        %         figure(1);subplot(2,1,1);plot(conc);title('Concentration profiles');
    end

    % ************************************************
    % QUANTITATIVE INFORMATION FOR THREE-WAY DATA SETS
    % ************************************************

    % recalculation of total and ratio concentrations if ishape=0 or niter=1

    if evalin('base','als_opt.trilin.tril')==0
        ishape=0;
    else
        ishape=evalin('base','als_opt.trilin.ishape')
    end

    if ishape==0 | niter==1,
        for j=1:nsign,
            for inexp=1:matc,
                totalconc(j,inexp)=sum(conc(nrinic(inexp):nrfin(inexp),j));
            end
            if totalconc(j,1)>0,
                rt(j,1:matc)=totalconc(j,1:matc)./totalconc(j,1);
            else
                rt(j,1:matc)=totalconc(j,1:matc);
            end
        end
    end


    % areas under concentration profiles
    area=totalconc;

    % ********************************
    % ESTIMATE SPECTRA (ALS solution)
    % ********************************

    abss=conc\d;


    % ********************
    % non-negative spectra
    % ********************

    if ineg ==2 |ineg==3,

        ineg=evalin('base','als_opt.noneg.ineg');
        ialgs=evalin('base','als_opt.noneg.ialgs');
        nspneg=evalin('base','als_opt.noneg.nspneg');
        spneg=evalin('base','als_opt.noneg.spneg');
        ncinic=evalin('base','als_opt.multi.ncinic');
        ncfin=evalin('base','als_opt.multi.ncfin');

        for i = 1:matr
            kinic = ncinic(i);
            kfin = ncfin(i);
            abss2 = abss(:,kinic:kfin);

            if ialgs==0,
                for k=1:nsign,
                    if spneg(k,i)==1
                        for j=1:kfin+1-kinic,
                            if abss2(k,j)<0.0,
                                abss2(k,j)=0.0;
                            end
                        end
                    end
                end
            end

            if ialgs==1,
                for j=kinic:kfin,
                    if spneg(:,i)== ones(size(isp,2),1)
                        abss2(:,j-kinic+1)=lsqnonneg(conc,d(:,j));
                    end
                end
            end

            if ialgs==2,
                for j=kinic:kfin,
                    if spneg(:,i)== ones(size(isp,2),1)
                        abss2(:,j-kinic+1)=fnnls(conc'*conc,conc'*d(:,j));
                    end
                end
            end
            abss(:,kinic:kfin)=abss2;
        end
    end

    % ************
    % trilinearity
    % ************

    if evalin('base','als_opt.trilin.tril')==1

        ishape=evalin('base','als_opt.trilin.ishape');

        if ishape>=1,

            trildir=evalin('base','als_opt.trilin.trildir');
            spetric=evalin('base','als_opt.trilin.spetric');
            spetris=evalin('base','als_opt.trilin.spetris');

            if trildir==2|trildir==3
                for j=1:nsign,
                    if spetris(j)==1,
                        [absst,t]=trilin(abss(j,:)',matr,ishape);
                        abss(j,:)=absst';
                    end
                end
            end
        end

    end

    % ************************************
    % constrain the unimodality of spectra
    % ************************************

    if evalin('base','als_opt.unimod.unimodal')==1

        imod=evalin('base','als_opt.unimod.imod');

        for i = 1:matr
            kinic = ncinic(i);
            kfin = ncfin(i);
            abss2 = abss(:,kinic:kfin);

            if imod==2|imod==3,
                spsmod=evalin('base','als_opt.unimod.spsmod');
                cmod=evalin('base','als_opt.unimod.cmod');
                smod=evalin('base','als_opt.unimod.smod');
                for j=1:nsign,
                    if spsmod(i,j)==1
                        dummy=unimod(abss2(j,:)',smod,cmod);
                        abss2(j,:)=dummy';
                    end
                end
            end
            abss(:,kinic:kfin)=abss2;
        end

    end


    % ********************************
    % EQUALITY CONSTRAINTS FOR SPECTRA
    % ********************************

    if evalin('base','als_opt.sselc.sselcon')==1

        ssel=evalin('base','als_opt.sselc.ssel');
        type_ssel=evalin('base','als_opt.sselc.type_ssel');
        jjsel=evalin('base','als_opt.sselc.jjsel');

        if type_ssel==0,
            abss(jjsel)=ssel(jjsel);
        end
        if type_ssel==1
            for jj=1:size(jjsel),
                if abss(jjsel(jj))>ssel(jjsel(jj)),
                    abss(jjsel(jj))=ssel(jjsel(jj));
                end
            end
        end
    end

    % *******************************************************
    % closure in spectra (in case of inverted analysis D'=SC)
    % *******************************************************

    if evalin('base','als_opt.closure.closure')==1;

        dc=evalin('base','als_opt.closure.dc');
        vc=evalin('base','als_opt.closure.vc');
        iclos=evalin('base','als_opt.closure.iclos');
        tclos1(1:matc)=zeros(1,matc);
        tclos2(1:matc)=zeros(1,matc);
        sclos1(1:matc,1:nsign)=zeros(matc,nsign);
        sclos2(1:matc,1:nsign)=zeros(matc,nsign);
        iclos1(1:matc)=zeros(1,matc);
        iclos2(1:matc)=zeros(1,matc);

        if dc==2,

            for i = 1:matr
                kinic = ncinic(i);
                kfin = ncfin(i);
                abss2 = abss(:,kinic:kfin);

                if iclos(i)==1 | iclos(i)==2,
                    if tclos1(i) == 0
                        vclos1n=vclos1(kinic:kfin,1);
                    end

                    if iclos(i) ==2 & tclos2(i)==0
                        vclos2n=vclos2(kinic:kfin,1);
                    end

                    abst = closure(abss2',iclos(i),sclos1(i,:),iclos1(i),tclos1(i),tclos2(i),sclos2(i,:),iclos2(i),vclos1n,vclos2n);
                    abss2=abst';
                end
                abss(:,kinic:kfin) = abss2;
            end
        end
    end

    % ************************
    % NORMALIZATION OF SPECTRA
    % ************************

    if evalin('base','als_opt.closure.closure')==0
        % equal heighth

        inorm=evalin('base','als_opt.closure.inorm');

        if inorm==1,
            maxabss=max(abss');
            for i=1:nsign,
                abss(i,:)=abss(i,:)./maxabss(i);
            end
        end

        % equal length

        if inorm==2, abss=normv2(abss); end

    end




    % *******************************
    % CALCULATE RESIDUALS
    % *******************************

    res=d-conc*abss;
    resn=dn-conc*abss;

    % ********************************
    % OPTIMIZATION RESULTS
    % *********************************

    disp(' ' );disp(' ');disp(['ITERATION ',num2str(niter)]);
    u=sum(sum(res.*res));
    un=sum(sum(resn.*resn));
    disp(['Sum of squares respect PCA reprod. = ', num2str(u)]);
    sigma=sqrt(u/(nrow*ncol));
    sigman=sqrt(un/(nrow*ncol));
    disp(['Old sigma = ', num2str(sigma2),' -----> New sigma = ', num2str(sigma)]);
    disp(['Sigma respect experimental data = ', num2str(sigman)]);
    disp(' ');
    change=((sigma2-sigma)/sigma);

    if change < 0.0,
        disp(' ')
        disp('FITING IS NOT IMPROVING !!!')
        idev=idev+1;
    else,
        disp('FITING IS IMPROVING !!!')
        idev=0;
    end

    change=change*100;
    disp(['Change in sigma (%) = ', num2str(change)]);
    sstd(1)=sqrt(u/sst)*100;
    sstd(2)=sqrt(un/sstn)*100;
    disp(['Fitting error (lack of fit, lof) in % (PCA) = ', num2str(sstd(1))]);
    disp(['Fitting error (lack of fit, lof) in % (exp) = ', num2str(sstd(2))]);
    r2=(sstn-un)/sstn;
    disp(['Percent of variance explained (r2) is ',num2str(100*r2)]);

    % ********************
    % DISPLAY PURE SPECTRA
    % ********************

    if  evalin('base','als_opt.opt.gr')=='y',
        als_end=0;

        assignin('base','cx_plot',conc);
        assignin('base','sx_plot',abss);
        assignin('base','niter_plot',niter);
        assignin('base','change_plot',change);
        assignin('base','sstd_plot',sstd);
        assignin('base','als_end',als_end);
        als_res;

        evalin('base','clear cx_plot sx_plot niter_plot change_plot sstd_plot als_end');
    end


    % *************************************************************
    % If change is positive, the optimization is working correctly
    % *************************************************************

    if change>0 | niter==1,

        sigma2=sigma;
        copt=conc;
        sopt=abss;
        sdopt=sstd;
        ropt=res;
        rtopt=rt';
        itopt=niter;
        areaopt=area;
        r2opt=r2;
    end

    % ******************************************************************
    % test for convergence within maximum number of iterations allowed
    % ******************************************************************

    if abs(change) < evalin('base','als_opt.opt.tolsigma'),

        %  finish the iterative optimization because convergence is achieved

        disp(' ');disp(' ');
        disp('CONVERGENCE IS ACHIEVED !!!!')
        disp(' ')
        disp(['Fitting error (lack of fit, lof) in % at the optimum = ', num2str(sdopt(1,1)),'(PCA) ', num2str(sdopt(1,2)), '(exp)']);
        disp(['Percent of variance explained (r2)at the optimum is ',num2str(100*r2opt)]);
        disp('Relative species conc. areas respect matrix (sample) 1at the optimum'),disp(rtopt')
        disp(['Plots are at optimum in the iteration ', num2str(itopt)]);



        if isempty(evalin('base','als_opt.out.out_conc'))==0
            assignin('base',evalin('base','als_opt.out.out_conc'),copt)
        end
        if isempty(evalin('base','als_opt.out.out_spec'))==0
            assignin('base',evalin('base','als_opt.out.out_spec'),sopt)
        end
        if isempty(evalin('base','als_opt.out.out_res'))==0
            assignin('base',evalin('base','als_opt.out.out_res'),ropt)
        end
        if isempty(evalin('base','als_opt.out.out_std'))==0
            assignin('base',evalin('base','als_opt.out.out_std'),sdopt)
        end
        if isempty(evalin('base','als_opt.out.out_area'))==0
            assignin('base',evalin('base','als_opt.out.out_area'),areaopt)
        end
        if isempty(evalin('base','als_opt.out.out_rat'))==0
            assignin('base',evalin('base','als_opt.out.out_rat'),rtopt)
        end

        als_end=1;
        assignin('base','als_end',als_end);
        assignin('base','copt_xxx',copt);
        assignin('base','sopt_xxx',sopt);
        assignin('base','sdopt_xxx',sdopt);
        assignin('base','r2opt_xxx',r2opt);
        assignin('base','rtopt_xxx',rtopt);
        assignin('base','itopt_xxx',itopt);
                assignin('base','change_xxx',sigman); % for std dev res vs exp
        als_res;
        evalin('base','clear als_end copt_xxx sopt_xxx sdopt_xxx r2opt_xxx rtopt_xxx itopt_xxx change_xxx');

        return         % 1st return (end of the optimization, convergence)
    end

    %  finish the iterative optimization if divergence occurs 20 times consecutively

    if idev > 20,
        disp(' ');disp(' ');
        disp('FIT NOT IMPROVING FOR 20 TMES CONSECUTIVELY (DIVERGENCE?), STOP!!!')
        disp(' ')
        disp(['Fitting error (lack of fit, lof) in % at the optimum = ', num2str(sdopt(1,1)),'(PCA) ', num2str(sdopt(1,2)), '(exp)']);
        disp(['Percent of variance explained (r2)at the optimum is ',num2str(100*r2opt)]);
        disp('Relative species conc. areas respect matrix (sample) 1 at the optimum'),disp(rtopt)
        disp(['Plots are at optimum in the iteration ', num2str(itopt)]);

        if isempty(evalin('base','als_opt.out.out_conc'))==0
            assignin('base',evalin('base','als_opt.out.out_conc'),copt)
        end
        if isempty(evalin('base','als_opt.out.out_spec'))==0
            assignin('base',evalin('base','als_opt.out.out_spec'),sopt)
        end
        if isempty(evalin('base','als_opt.out.out_res'))==0
            assignin('base',evalin('base','als_opt.out.out_res'),ropt)
        end
        if isempty(evalin('base','als_opt.out.out_std'))==0
            assignin('base',evalin('base','als_opt.out.out_std'),sdopt)
        end
        if isempty(evalin('base','als_opt.out.out_area'))==0
            assignin('base',evalin('base','als_opt.out.out_area'),areaopt)
        end
        if isempty(evalin('base','als_opt.out.out_rat'))==0
            assignin('base',evalin('base','als_opt.out.out_rat'),rtopt)
        end

        als_end=2;
        assignin('base','als_end',als_end);
        assignin('base','copt_xxx',copt);
        assignin('base','sopt_xxx',sopt);
        assignin('base','sdopt_xxx',sdopt);
        assignin('base','r2opt_xxx',r2opt);
        assignin('base','rtopt_xxx',rtopt);
        assignin('base','itopt_xxx',itopt);
                assignin('base','change_xxx',sigman); % for std dev res vs exp
        als_res;
        evalin('base','clear als_end copt_xxx sopt_xxx sdopt_xxx r2opt_xxx rtopt_xxx itopt_xxx change_xxx');

        return          % 2nd return (end of optimization, divergence)

    end

    % this end refers to number of iterations initially proposed exceeded

end

% finish the iterative optimization if maximum number of allowed iterations is exceeded

disp(' ');disp(' ');
disp('NUMBER OF ITERATIONS EXCEEDED THE ALLOWED!')
disp(' ')
disp(['Fitting error (lack of fit, lof) in % at the optimum = ', num2str(sdopt(1,1)),'(PCA) ', num2str(sdopt(1,2)), '(exp)']);
disp(['Percent of variance explained (r2)at the optimum is ',num2str(100*r2opt)]);
disp('Relative species conc. areas respect matrix (sample) 1 at the optimum'),disp(rtopt)
disp(['Plots are at optimum in the iteration ', num2str(itopt)]);

if isempty(evalin('base','als_opt.out.out_conc'))==0
    assignin('base',evalin('base','als_opt.out.out_conc'),copt)
end
if isempty(evalin('base','als_opt.out.out_spec'))==0
    assignin('base',evalin('base','als_opt.out.out_spec'),sopt)
end
if isempty(evalin('base','als_opt.out.out_res'))==0
    assignin('base',evalin('base','als_opt.out.out_res'),ropt)
end
if isempty(evalin('base','als_opt.out.out_std'))==0
    assignin('base',evalin('base','als_opt.out.out_std'),sdopt)
end
if isempty(evalin('base','als_opt.out.out_area'))==0
    assignin('base',evalin('base','als_opt.out.out_area'),areaopt)
end
if isempty(evalin('base','als_opt.out.out_rat'))==0
    assignin('base',evalin('base','als_opt.out.out_rat'),rtopt)
end

als_end=3;
assignin('base','als_end',als_end);
assignin('base','copt_xxx',copt);
assignin('base','sopt_xxx',sopt);
assignin('base','sdopt_xxx',sdopt);
assignin('base','r2opt_xxx',r2opt);
assignin('base','rtopt_xxx',rtopt);
assignin('base','itopt_xxx',itopt);
assignin('base','change_xxx',sigman); % for std dev res vs exp
als_res;
evalin('base','clear als_end copt_xxx sopt_xxx sdopt_xxx r2opt_xxx rtopt_xxx itopt_xxx change_xxx');

return          % 3rd return (end of optimization, number of iterations exceeded)













