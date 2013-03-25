function varargout = MandelDecryptGUI(varargin)
% MANDELDECRYPTGUI M-file for MandelDecryptGUI.fig
%      MANDELDECRYPTGUI, by itself, creates a new MANDELDECRYPTGUI or raises the existing
%      singleton*.
%
%      H = MANDELDECRYPTGUI returns the handle to a new MANDELDECRYPTGUI or the handle to
%      the existing singleton*.
%
%      MANDELDECRYPTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MANDELDECRYPTGUI.M with the given input arguments.
%
%      MANDELDECRYPTGUI('Property','Value',...) creates a new MANDELDECRYPTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MandelDecryptGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MandelDecryptGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MandelDecryptGUI

% Last Modified by GUIDE v2.5 16-Apr-2011 11:27:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MandelDecryptGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @MandelDecryptGUI_OutputFcn, ...
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


% --- Executes just before MandelDecryptGUI is made visible.
function MandelDecryptGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MandelDecryptGUI (see VARARGIN)

% Load up the drop-downs
profADir = dir('./MandelHasher/dataA/');
profA(1) = cellstr(get(handles.profAOpts,'String'));
for i = 3:length(profADir)
   profA(i-1) = cellstr(profADir(i).name);
end
set(handles.profAOpts,'String',profA);

profBDir = dir('./MandelHasher/dataB/');
profB(1) = cellstr(get(handles.profBOpts,'String'));
for i = 3:length(profBDir)
   profB(i-1) = cellstr(profBDir(i).name);
end
set(handles.profBOpts,'String',profB);

msgDir = dir('./MandelHasher/msgForAlice/');
for i = 3:length(msgDir)
   msgOpt(i-1) = cellstr(msgDir(i).name);
end
set(handles.msgOpts,'String',msgOpt);

% Choose default command line output for MandelDecryptGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MandelDecryptGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MandelDecryptGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes during object creation, after setting all properties.
function msgConsole_CreateFcn(hObject, eventdata, handles)
% hObject    handle to msgConsole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in loadButton.
function loadButton_Callback(hObject, eventdata, handles)
% hObject    handle to loadButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fileOpts = get(handles.msgOpts,'String');
fileName = fileOpts{get(handles.msgOpts,'Value')};
fileName = cellstr(strcat('./MandelHasher/msgForAlice/',fileName));
load(char(fileName));
%set(handles.msgConsole,'String',msgRaw);
mHashPts
numChars
diffVal

save ./MandelHasher/temp/dtemp mHashPts numChars diffVal

set(handles.decryptButton,'Enable','on');


% --- Executes on button press in decryptButton.
function decryptButton_Callback(hObject, eventdata, handles)
% hObject    handle to decryptButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load /MandelHasher/temp/dtemp

% Load Profiles
if get(handles.profAOpts,'Value')~=1
    profAOpt = get(handles.profAOpts,'String');
    fileName = profAOpt{get(handles.profAOpts,'Value')};
    fileName = cellstr(strcat('/MandelHasher/dataA/',fileName));
    load(char(fileName));
else
    load /MandelHasher/dataA/keysA
end

if get(handles.profBOpts,'Value')~=1
    profBOpt = get(handles.profBOpts,'String');
    fileName = profBOpt{get(handles.profBOpts,'Value')};
    fileName = cellstr(strcat('/MandelHasher/dataB/',fileName));
    load(char(fileName));
else
    load /MandelHasher/dataB/keysB
end

% Recover plaintext
N = 2;      % Numerator of fcn to recover msg from mset
msgBlocks = mset2msg(mHashPts,N);
fprintf('\n---------------\nmsgBlocks:\n------------------\n');
msgBlocks{:}
msgRaw = blocks2str(msgBlocks);
fprintf('\n---------------\nmsgRaw:\n------------------\n');
msgRaw

set(handles.msgConsole,'String',msgRaw);
set(handles.saveButton,'Enable','on');

save ./MandelHasher/temp/dtemp mHashPts numChars diffVal msgRaw


% --- Executes on selection change in profAOpts.
function profAOpts_Callback(hObject, eventdata, handles)
% hObject    handle to profAOpts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns profAOpts contents as cell array
%        contents{get(hObject,'Value')} returns selected item from profAOpts


% --- Executes during object creation, after setting all properties.
function profAOpts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to profAOpts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in profBOpts.
function profBOpts_Callback(hObject, eventdata, handles)
% hObject    handle to profBOpts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns profBOpts contents as cell array
%        contents{get(hObject,'Value')} returns selected item from profBOpts


% --- Executes during object creation, after setting all properties.
function profBOpts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to profBOpts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in msgOpts.
function msgOpts_Callback(hObject, eventdata, handles)
% hObject    handle to msgOpts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns msgOpts contents as cell array
%        contents{get(hObject,'Value')} returns selected item from msgOpts


% --- Executes during object creation, after setting all properties.
function msgOpts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to msgOpts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function saveNameEdit_Callback(hObject, eventdata, handles)
% hObject    handle to saveNameEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of saveNameEdit as text
%        str2double(get(hObject,'String')) returns contents of saveNameEdit as a double


% --- Executes during object creation, after setting all properties.
function saveNameEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to saveNameEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in saveButton.
function saveButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load /MandelHasher/temp/dtemp

saveName = get(handles.saveNameEdit,'String');
saveName = sprintf('./MandelHasher/msgFromBill/de%s', saveName);

save(saveName, 'msgRaw', 'diffVal', 'numChars');
