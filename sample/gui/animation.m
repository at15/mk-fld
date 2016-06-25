function varargout = animation(varargin)
% ANIMATION MATLAB code for animation.fig
%      ANIMATION, by itself, creates a new ANIMATION or raises the existing
%      singleton*.
%
%      H = ANIMATION returns the handle to a new ANIMATION or the handle to
%      the existing singleton*.
%
%      ANIMATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANIMATION.M with the given input arguments.
%
%      ANIMATION('Property','Value',...) creates a new ANIMATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before animation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to animation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help animation

% Last Modified by GUIDE v2.5 25-Jun-2016 19:43:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @animation_OpeningFcn, ...
                   'gui_OutputFcn',  @animation_OutputFcn, ...
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


% --- Executes just before animation is made visible.
function animation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to animation (see VARARGIN)

% Choose default command line output for animation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes animation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = animation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_draw.
function btn_draw_Callback(hObject, eventdata, handles)
% hObject    handle to btn_draw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes_draw);
for k = 1:16
	plot(fft(eye(k+16)))
	axis([-1 1 -1 1])
	M(k) = getframe;
end
% keep the data to global GUI handles
handles.M = M;
guidata(hObject,handles);


% --- Executes on button press in bnt_play.
function bnt_play_Callback(hObject, eventdata, handles)
% hObject    handle to bnt_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes_play);
% TODO: check if M is emtpy
axis([-1 1 -1 1]);
movie(handles.M);


% --- Executes on slider movement.
function slider_frame_Callback(hObject, eventdata, handles)
% hObject    handle to slider_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
axes(handles.axes_play);
axis([-1 1 -1 1]);
v = get(hObject,'Value');
i = round(v);
imshow(handles.M(i).cdata);


% --- Executes during object creation, after setting all properties.
function slider_frame_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
