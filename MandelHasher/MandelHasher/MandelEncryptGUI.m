function varargout = MandelEncryptGUI(varargin)
% MANDELENCRYPTGUI M-file for MandelEncryptGUI.fig
%      MANDELENCRYPTGUI, by itself, creates a new MANDELENCRYPTGUI or raises the existing
%      singleton*.
%
%      H = MANDELENCRYPTGUI returns the handle to a new MANDELENCRYPTGUI or the handle to
%      the existing singleton*.
%
%      MANDELENCRYPTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MANDELENCRYPTGUI.M with the given input arguments.
%
%      MANDELENCRYPTGUI('Property','Value',...) creates a new MANDELENCRYPTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MandelEncryptGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MandelEncryptGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MandelEncryptGUI

% Last Modified by GUIDE v2.5 16-Apr-2011 11:22:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MandelEncryptGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @MandelEncryptGUI_OutputFcn, ...
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


% --- Executes just before MandelEncryptGUI is made visible.
function MandelEncryptGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MandelEncryptGUI (see VARARGIN)

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

% Choose default command line output for MandelEncryptGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MandelEncryptGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MandelEncryptGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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



function msgEdit_Callback(hObject, eventdata, handles)
% hObject    handle to msgEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of msgEdit as text
%        str2double(get(hObject,'String')) returns contents of msgEdit as a double

set(handles.encryptButton,'Enable','on');

% --- Executes during object creation, after setting all properties.
function msgEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to msgEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in encryptButton.
function encryptButton_Callback(hObject, eventdata, handles)
% hObject    handle to encryptButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

msgRaw = get(handles.msgEdit,'String');

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

% Hash it up
N = 2;          % Numerator of fcn to send msg into mset
numChars = str2double(get(handles.editNumChars,'String'));
msgRaw = get(handles.msgEdit,'String');
msgBlocks = str2blocks(msgRaw,numChars);
mHashPts = msg2mset(msgBlocks,N);
%for i = 1:length(mHashPts)
%    mHashes(i).sig = mandelfn(globProf.c,mHashPts(i),priDKey_B.c,priDKey_B.x);
    %mHashes(i).sig = mandelfn(mHashPts(i),pubEKey_A,priDKey_B.c,priDKey_B.x);
%end

fprintf('Message from Bill to Alice:\n---------------------------\n')
msgRaw
fprintf('msgBlocks:\n---------\n');
msgBlocks{:}
fprintf('mHashPts:\n---------\n');
mHashPts(:)

set(handles.saveButton,'Enable','on');
save ./MandelHasher/temp/etemp mHashPts numChars diffVal


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

load /MandelHasher/temp/etemp

saveName = get(handles.saveNameEdit,'String');
saveName = sprintf('./MandelHasher/msgForAlice/en%s', saveName);

save(saveName, 'mHashPts', 'diffVal', 'numChars');


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



function editNumChars_Callback(hObject, eventdata, handles)
% hObject    handle to editNumChars (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editNumChars as text
%        str2double(get(hObject,'String')) returns contents of editNumChars as a double


% --- Executes during object creation, after setting all properties.
function editNumChars_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editNumChars (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
