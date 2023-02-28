function varargout = debug_edit(varargin)
% DEBUG_EDIT MATLAB code for debug_edit.fig
%      DEBUG_EDIT, by itself, creates a new DEBUG_EDIT or raises the existing
%      singleton*.
%
%      H = DEBUG_EDIT returns the handle to a new DEBUG_EDIT or the handle to
%      the existing singleton*.
%
%      DEBUG_EDIT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEBUG_EDIT.M with the given input arguments.
%
%      DEBUG_EDIT('Property','Value',...) creates a new DEBUG_EDIT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before debug_edit_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to debug_edit_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help debug_edit

% Last Modified by GUIDE v2.5 17-Sep-2012 01:47:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @debug_edit_OpeningFcn, ...
                   'gui_OutputFcn',  @debug_edit_OutputFcn, ...
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
end

function debug_edit_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to debug_edit (see VARARGIN)

set(handles.edit1,'String','');%文本类型实验

% Choose default command line output for debug_edit
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes debug_edit wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

function edit1_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
s=get(hObject,'String');
end





function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function varargout = debug_edit_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

end
