function varargout = list_log(varargin)
% LIST_LOG MATLAB code for list_log.fig
%      LIST_LOG, by itself, creates a new LIST_LOG or raises the existing
%      singleton*.
%
%      H = LIST_LOG returns the handle to a new LIST_LOG or the handle to
%      the existing singleton*.
%
%      LIST_LOG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LIST_LOG.M with the given input arguments.
%
%      LIST_LOG('Property','Value',...) creates a new LIST_LOG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before list_log_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to list_log_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help list_log

% Last Modified by GUIDE v2.5 28-Jun-2016 14:08:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @list_log_OpeningFcn, ...
                   'gui_OutputFcn',  @list_log_OutputFcn, ...
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


% --- Executes just before list_log is made visible.
function list_log_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to list_log (see VARARGIN)

% Choose default command line output for list_log
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes list_log wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Set the value as cell array
set(handles.list_log,'String',{'init'});


% --- Outputs from this function are returned to the command line.
function varargout = list_log_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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


% --- Executes on button press in btn_add.
function btn_add_Callback(hObject, eventdata, handles)
% hObject    handle to btn_add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(handles.list_log,'String');
str{end + 1} = 'aaa';
set(handles.list_log,'String',str);