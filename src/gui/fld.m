function varargout = fld(varargin)
% FLD MATLAB code for fld.fig
%      FLD, by itself, creates a new FLD or raises the existing
%      singleton*.
%
%      H = FLD returns the handle to a new FLD or the handle to
%      the existing singleton*.
%
%      FLD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FLD.M with the given input arguments.
%
%      FLD('Property','Value',...) creates a new FLD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fld_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fld_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fld

% Last Modified by GUIDE v2.5 28-Jun-2016 13:04:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @fld_OpeningFcn, ...
    'gui_OutputFcn',  @fld_OutputFcn, ...
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


% --- Executes just before fld is made visible.
function fld_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fld (see VARARGIN)

% Choose default command line output for fld
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fld wait for user response (see UIRESUME)
% uiwait(handles.figure1);
start_time = tic;
handles.start_time = start_time;

% timer to update GUI time
timer_update_time_used = timer('StartDelay', 1, 'Period', 1, ...
    'ExecutionMode', 'fixedDelay');
handles.timer_update_time_used = timer_update_time_used;

guidata(hObject, handles);

timer_update_time_used.TimerFcn = {@update_timer, handles};
start(timer_update_time_used);

% --- Outputs from this function are returned to the command line.
function varargout = fld_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function menu_file_Callback(hObject, eventdata, handles)
% hObject    handle to menu_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function menu_start_Callback(hObject, eventdata, handles)
% hObject    handle to menu_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_start_solver_Callback(hObject, eventdata, handles)
% hObject    handle to menu_start_solver (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fld_solver


% --------------------------------------------------------------------
function menu_start_post_process_Callback(hObject, eventdata, handles)
% hObject    handle to menu_start_post_process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function update_timer(obj, event, handles)
% disp(toc);
% TODO: should properly format time
set(handles.text_time_used, 'String', round(toc(handles.start_time)));

% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('clean up main gui');
stop(handles.timer_update_time_used);
delete(handles.timer_update_time_used);
