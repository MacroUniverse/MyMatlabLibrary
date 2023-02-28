function varargout = code(varargin)
% CODE MATLAB code for code.fig
%      CODE, by itself, creates a new CODE or raises the existing
%      singleton*.
%
%      H = CODE returns the handle to a new CODE or the handle to
%      the existing singleton*.
%
%      CODE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CODE.M with the given input arguments.
%
%      CODE('Property','Value',...) creates a new CODE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before code_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to code_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help code

% Last Modified by GUIDE v2.5 23-May-2013 13:53:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @code_OpeningFcn, ...
                   'gui_OutputFcn',  @code_OutputFcn, ...
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


% --- Executes just before code is made visible.
function code_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to code (see VARARGIN)

% Choose default command line output for code
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes code wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = code_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
S0=get(handles.edit1,'String'); %提取table1中的信息
S=S0;
%+1替换
mark1=('0'<=S&S<='8'); mark2=(S=='9');
S(mark1)=S(mark1)+1; S(mark2)='0'; 
mark1=('a'<=S&S<='y'); mark2=(S=='z');
S(mark1)=S(mark1)+1; S(mark2)='a';
mark1=('A'<=S&S<='Y'); mark2=(S=='Z');
S(mark1)=S(mark1)+1; S(mark2)='A';

%核对检查(-1替换)
S1=S;
mark1=('1'<=S1&S1<='9'); mark2=(S1=='0');
S1(mark1)=S1(mark1)-1; S1(mark2)='9'; 
mark1=('b'<=S1&S1<='z'); mark2=(S1=='a');
S1(mark1)=S1(mark1)-1; S1(mark2)='z';
mark1=('B'<=S1&S1<='Z'); mark2=(S1=='A');
S1(mark1)=S1(mark1)-1; S1(mark2)='Z';

if strcmp(S0,S1)
    set(handles.edit2,'String',S);
else
    set(handles.edit2,'String','error'); 
end
guidata(hObject, handles);

% handles    structure with handles and user data (see GUIDATA)



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
S0=get(handles.edit1,'String'); %提取table1中的信息

%-1替换
S1=S0;
mark1=('1'<=S1&S1<='9'); mark2=(S1=='0');
S1(mark1)=S1(mark1)-1; S1(mark2)='9'; 
mark1=('b'<=S1&S1<='z'); mark2=(S1=='a');
S1(mark1)=S1(mark1)-1; S1(mark2)='z';
mark1=('B'<=S1&S1<='Z'); mark2=(S1=='A');
S1(mark1)=S1(mark1)-1; S1(mark2)='Z';


%核对检查(+1替换)
S=S1;
mark1=('0'<=S&S<='8'); mark2=(S=='9');
S(mark1)=S(mark1)+1; S(mark2)='0'; 
mark1=('a'<=S&S<='y'); mark2=(S=='z');
S(mark1)=S(mark1)+1; S(mark2)='a';
mark1=('A'<=S&S<='Y'); mark2=(S=='Z');
S(mark1)=S(mark1)+1; S(mark2)='A';

if strcmp(S0,S)
    set(handles.edit2,'String',S1);
else
    set(handles.edit2,'String','error'); 
end
guidata(hObject, handles);
