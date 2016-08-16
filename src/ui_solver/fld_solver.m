function varargout = fld_solver(varargin)
% FLD_SOLVER MATLAB code for fld_solver.fig
%      FLD_SOLVER, by itself, creates a new FLD_SOLVER or raises the existing
%      singleton*.
%
%      H = FLD_SOLVER returns the handle to a new FLD_SOLVER or the handle to
%      the existing singleton*.
%
%      FLD_SOLVER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FLD_SOLVER.M with the given input arguments.
%
%      FLD_SOLVER('Property','Value',...) creates a new FLD_SOLVER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fld_solver_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fld_solver_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fld_solver

% Last Modified by GUIDE v2.5 16-Aug-2016 08:50:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @fld_solver_OpeningFcn, ...
    'gui_OutputFcn',  @fld_solver_OutputFcn, ...
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


% --- Executes just before fld_solver is made visible.
function fld_solver_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fld_solver (see VARARGIN)

% Choose default command line output for fld_solver
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fld_solver wait for user response (see UIRESUME)
% uiwait(handles.figure1);
m_init(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = fld_solver_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function menu_start_post_process_Callback(hObject, eventdata, handles)
% hObject    handle to menu_start_post_process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('clean up solver');
timer_update_time_used = getappdata(handles.figure1,'timer_update_time_used');
stop(timer_update_time_used);
delete(timer_update_time_used);

% --- Executes on selection change in list_log.
function list_log_Callback(hObject, eventdata, handles)
% hObject    handle to list_log (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns list_log contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list_log


% --- Executes during object creation, after setting all properties.
function list_log_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list_log (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function m_init(hObject, handles)
clc;
m_init_timer(handles);
m_init_queue(handles);

function m_log(msg, handles)
% First log to console
disp(msg);
str = get(handles.list_log,'String');
str{end + 1} = msg;
set(handles.list_log,'String',str);

function m_log_info(msg, handles)
% NOTE: using strcat('[INFO] ', msg) will loose the trailing space
m_log(strcat([' [INFO] ',msg]), handles)

function m_log_error(msg, handles)
m_log(strcat([' [ERROR] ',msg]), handles)

function m_init_timer(handles)
start_time = tic;
handles.start_time = start_time;

% timer to update GUI time
timer_update_time_used = timer('StartDelay', 1, 'Period', 1, ...
    'ExecutionMode', 'fixedDelay');
timer_update_time_used.TimerFcn = {@m_update_timer, handles};

setappdata(handles.figure1,'timer_update_time_used',timer_update_time_used);
start(timer_update_time_used);
m_log_info('timer started',handles);

function m_update_timer(obj, event, handles)
% disp(toc);
% TODO: should properly format time
set(handles.text_time_used, 'String', round(toc(handles.start_time)));

function m_init_queue(handles)
% TODO: in fact we should load unfinished jobs
setappdata(handles.figure1,'queue',{});
set(handles.table_queue,'Data',{});

% --------------------------------------------------------------------
function menu_file_Callback(hObject, eventdata, handles)
% hObject    handle to menu_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_file_open_Callback(hObject, eventdata, handles)
% hObject    handle to menu_file_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uigetfile('*.fldin','Select the mk-fld input file');
m_log_info('Opening file :',handles);
m_log_info(strcat([path file]),handles);
% Try parse the json file
% TODO: Add try catch for error handling
inputData = loadjson(strcat([path file]));
m_log_info('File parsed', handles);
% Add the file to Queue and Update the UI
q = getappdata(handles.figure1, 'queue');
q{end + 1} = inputData;
setappdata(handles.figure1, 'queue', q);
% disp(q);
% Update table_queue
tableData = get(handles.table_queue,'Data');
% TODO: add material name in table
% tableData{end + 1} = {
%   file, inputData.description, path, 0, 'debug'
% };

[row,~] = size(tableData);
tableData{row + 1, 1} = file;
tableData{row + 1, 2} = inputData.description;
tableData{row + 1, 3} = path;
% TODO: real file size
tableData{row + 1, 4} = '0KB';
tableData{row + 1, 5} = 'debug';
set(handles.table_queue, 'Data', tableData);
