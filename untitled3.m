function varargout = untitled3(varargin)
% UNTITLED3 MATLAB code for untitled3.fig
%      UNTITLED3, by itself, creates a new UNTITLED3 or raises the existing
%      singleton*.
%
%      H = UNTITLED3 returns the handle to a new UNTITLED3 or the handle to
%      the existing singleton*.
%
%      UNTITLED3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED3.M with the given input arguments.
%
%      UNTITLED3('Property','Value',...) creates a new UNTITLED3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled3

% Last Modified by GUIDE v2.5 20-Jul-2013 20:43:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled3_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled3_OutputFcn, ...
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


% --- Executes just before untitled3 is made visible.
function untitled3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled3 (see VARARGIN)

% Choose default command line output for untitled3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fileName,pathName] = uigetfile('*.avi','Select an avi file');
location = [pathName, fileName];
%disp(location);

pb3 = handles.pushbutton3;
axes2 = handles.axes2;
m = mmreader(location);

set(pb3, 'enable', 'on');
setappdata(pb3, 'pause', 0);
setappdata(axes2, 'index', 1);
setappdata(axes2, 'numFrame', m.NumberOfFrames);
setappdata(axes2, 'frames', read(m));

play(handles);

guidata(hObject, handles);
%movie(handles.axes2, mov, 1, 30, [0 0 500 500]);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if getappdata(hObject, 'pause') == 0
    set (hObject, 'String', 'Continue');
    setappdata(hObject, 'pause', 1);
else
    set (hObject, 'String', 'Pause');
    setappdata(hObject, 'pause', 0);
    play(handles);
end

function play(handles)

axes2 = handles.axes2;
axes(axes2);

index = getappdata(axes2, 'index');
numFrame = getappdata(axes2, 'numFrame');
frames = getappdata(axes2, 'frames');
pb3 = handles.pushbutton3;

for k = index : numFrame
    if getappdata(pb3, 'pause') == 0
        %v = get(handles.slider1, 'Value');
        set(handles.slider1, 'Value', k / numFrame);
        setappdata(axes2, 'index', k);
        imshow(frames(:, :, :, k));
        pause(0.05);
    else
        break;
    end
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value = get(hObject, 'Value');
disp(eventdata);
numFrame = getappdata(handles.axes2, 'numFrame');

flag = 0;
if getappdata(handles.pushbutton3, 'pause') == 0 
    pushbutton3_Callback(handles.pushbutton3, 0, handles);
    flag = 1;
end

%pause(1);

disp(getappdata(handles.axes2, 'index'));
setappdata(handles.axes2, 'index', round(value * numFrame));
disp(getappdata(handles.axes2, 'index'));


if flag == 1
    pushbutton3_Callback(handles.pushbutton3, 0, handles);
end
%setappdata(handles.pushbutton3, 'pause', 0);
play(handles);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
