function varargout = debug_table(varargin)
% DEBUG_TABLE MATLAB code for debug_table.fig
%      DEBUG_TABLE, by itself, creates a new DEBUG_TABLE or raises the existing
%      singleton*.
%
%      H = DEBUG_TABLE returns the handle to a new DEBUG_TABLE or the handle to
%      the existing singleton*.
%
%      DEBUG_TABLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEBUG_TABLE.M with the given input arguments.
%
%      DEBUG_TABLE('Property','Value',...) creates a new DEBUG_TABLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before debug_table_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to debug_table_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help debug_table

% Last Modified by GUIDE v2.5 17-Sep-2012 01:17:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @debug_table_OpeningFcn, ...
                   'gui_OutputFcn',  @debug_table_OutputFcn, ...
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
end

function debug_table_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to debug_table (see VARARGIN)

% Choose default command line output for debug_table
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

end

function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
a=1;
end

function uitable1_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
a=1;
end

function varargout = debug_table_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end
