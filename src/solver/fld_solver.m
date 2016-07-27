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

% Last Modified by GUIDE v2.5 25-Jun-2016 22:23:11

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

function update_timer(obj, event, handles)
% disp(toc);
% TODO: should properly format time
set(handles.text_time_used, 'String', round(toc(handles.start_time)));


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('clean up solver');
