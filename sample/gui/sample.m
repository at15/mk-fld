function varargout = sample(varargin)
% SAMPLE MATLAB code for sample.fig
%      SAMPLE, by itself, creates a new SAMPLE or raises the existing
%      singleton*.
%
%      H = SAMPLE returns the handle to a new SAMPLE or the handle to
%      the existing singleton*.
%
%      SAMPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAMPLE.M with the given input arguments.
%
%      SAMPLE('Property','Value',...) creates a new SAMPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sample_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sample_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sample

% Last Modified by GUIDE v2.5 25-Jun-2016 17:28:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @sample_OpeningFcn, ...
    'gui_OutputFcn',  @sample_OutputFcn, ...
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


% --- Executes just before sample is made visible.
function sample_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sample (see VARARGIN)

% Choose default command line output for sample
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sample wait for user response (see UIRESUME)
% uiwait(handles.figure1);
clc;
% use timer to draw plot
t = timer;
t.StartDelay = 1;
t.TimerFcn = {@drawPlot, handles};
start(t)


% --- Outputs from this function are returned to the command line.
function varargout = sample_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% You MUST set GUI Command-line accessiblity to ON to allow timer callback
% to set axes.
% see https://cn.mathworks.com/matlabcentral/answers/102384-how-do-i-make-my-gui-plot-into-an-axes-within-the-gui-figure-rather-than-inside-of-a-new-figure-in-m
% By default, GUI's have their Handle Visibility set to Callback, so they won't be affected by commands from the MATLAB Command Window. There are 2 ways to work around this:
% 1. Setting the figure's and axes' HandleVisibility property to 'on'.
% 2. Setting the root's ShowHiddenHandles property to 'on'.
function drawPlot(obj, event, handles)
% disp(handles);
axes(handles.axes_main);
fplot(@(x) sin(x));
disp('plot drew');
