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

% Last Modified by GUIDE v2.5 01-Jul-2016 16:23:23

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
m_init(hObject, handles);



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


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp(' [INFO] Clean up timers');
timer_update_time_used = getappdata(handles.figure1,'timer_update_time_used');
stop(timer_update_time_used);
delete(timer_update_time_used);

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
% Init the log listbox
set(handles.list_log,'String',{' [INFO] mk-fld GUI initialized'});
m_init_timer(hObject, handles);
m_get_materials(handles);
handles.selected_material = 'dummy';
guidata(hObject, handles);

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

function m_init_timer(hObject, handles)
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

function m_get_materials(handles)
try
    m_log_info('Fetching materials', handles);
    url = 'http://localhost:8000/materials';
    materials = urlread(url);
    % TODO: put materials on list box
    materials = loadjson(materials);
    m_log_info('Got materials', handles);
    % disp(materials);
    set(handles.list_materials, 'String', materials);
catch ex
    m_log_error(ex.message, handles);
    % disp(ex.message);
end

function m_get_material_detail(material, handles)
m_log_info(material, handles);
try
    m_log_info('Fetching material detail', handles);
    url = strcat('http://localhost:8000/materials/', material);
    materialData = urlread(url);
    materialData = loadjson(materialData);
    set(handles.label_material, 'String', materialData.name);
    disp(materialData);
    % Show material data in table
    disp(materialData.r);
    % NOTE: jsonlab can not parse numeric key value
    data = {'name', materialData.name;
        'r0', materialData.r.zero;
        'r45', materialData.r.forty;
        'r90', materialData.r.nighty};
    set(handles.table_material, 'Data', data);
    % NOTE: in order to fix the following, value must be set to 1
    % Warning: 'popupmenu' control requires that 'Value' be an integer within String range
    % Control will not be rendered until all of its parameter values are valid
    set(handles.select_hardening, 'Value', 1);
    set(handles.select_hardening, 'String', materialData.hardening);
    set(handles.select_yield, 'Value', 1);
    set(handles.select_yield, 'String', materialData.yield);
    setappdata(handles.figure1,'current_material', materialData);
catch ex
    m_log_error(ex.message, handles);
end

% --- Executes on selection change in list_materials.
function list_materials_Callback(hObject, eventdata, handles)
% hObject    handle to list_materials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns list_materials contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list_materials

index_selected = get(hObject,'Value');
list = get(hObject,'String');
material = list{index_selected};
if strcmp(handles.selected_material, material)
    m_log_info('Already selected, ignore', handles);
    return;
end
handles.selected_material = material;
guidata(hObject, handles);
m_get_material_detail(material, handles);


% --- Executes during object creation, after setting all properties.
function list_materials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list_materials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_materials_refresh.
function btn_materials_refresh_Callback(hObject, eventdata, handles)
% hObject    handle to btn_materials_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

m_get_materials(handles)


% --- Executes on selection change in select_hardening.
function select_hardening_Callback(hObject, eventdata, handles)
% hObject    handle to select_hardening (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns select_hardening contents as cell array
%        contents{get(hObject,'Value')} returns selected item from select_hardening
currentMaterial = getappdata(handles.figure1,'current_material');
index_selected = get(hObject,'Value');
list = get(hObject,'String');
selectedHardening = list{index_selected};
% disp(currentMaterial);
disp(selectedHardening);
disp(currentMaterial.(selectedHardening));


% --- Executes during object creation, after setting all properties.
function select_hardening_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select_hardening (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in select_yield.
function select_yield_Callback(hObject, eventdata, handles)
% hObject    handle to select_yield (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns select_yield contents as cell array
%        contents{get(hObject,'Value')} returns selected item from select_yield
disp(get(hObject,'Value'));

% --- Executes during object creation, after setting all properties.
function select_yield_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select_yield (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
