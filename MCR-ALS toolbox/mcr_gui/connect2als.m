function varargout = connect2als(varargin)
% CONNECT2ALS M-file for connect2als.fig
%      CONNECT2ALS, by itself, creates a new CONNECT2ALS or raises the existing
%      singleton*.
%
%      H = CONNECT2ALS returns the handle to a new CONNECT2ALS or the handle to
%      the existing singleton*.
%
%      CONNECT2ALS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONNECT2ALS.M with the given input arguments.
%
%      CONNECT2ALS('Property','Value',...) creates a new CONNECT2ALS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before connect2als_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to connect2als_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help connect2als

% Last Modified by GUIDE v2.5 12-Feb-2009 15:44:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @connect2als_OpeningFcn, ...
                   'gui_OutputFcn',  @connect2als_OutputFcn, ...
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


% --- Executes just before connect2als is made visible.
function connect2als_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to connect2als (see VARARGIN)

% Choose default command line output for connect2als
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes connect2als wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = connect2als_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close;
als2004;

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close;
