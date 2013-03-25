function varargout = MandelHashItGUI(varargin)
% MANDELHASHITGUI M-file for MandelHashItGUI.fig
%      MANDELHASHITGUI, by itself, creates a new MANDELHASHITGUI or raises the existing
%      singleton*.
%
%      H = MANDELHASHITGUI returns the handle to a new MANDELHASHITGUI or the handle to
%      the existing singleton*.
%
%      MANDELHASHITGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MANDELHASHITGUI.M with the given input arguments.
%
%      MANDELHASHITGUI('Property','Value',...) creates a new MANDELHASHITGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MandelHashItGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MandelHashItGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MandelHashItGUI

% Last Modified by GUIDE v2.5 10-Apr-2011 02:20:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MandelHashItGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @MandelHashItGUI_OutputFcn, ...
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


% --- Executes just before MandelHashItGUI is made visible.
function MandelHashItGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MandelHashItGUI (see VARARGIN)

% Load up the drop-downs
profADir = dir('./MandelHasher/dataA/');
profA(1) = cellstr(get(handles.profAOpt,'String'));
for i = 3:length(profADir)
   profA(i-1) = cellstr(profADir(i).name);
end
set(handles.profAOpt,'String',profA);

profBDir = dir('./MandelHasher/dataB/');
profB(1) = cellstr(get(handles.profBOpt,'String'));
for i = 3:length(profBDir)
   profB(i-1) = cellstr(profBDir(i).name);
end
set(handles.profBOpt,'String',profB);

% Choose default command line output for MandelHashItGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MandelHashItGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MandelHashItGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in profAOpt.
function profAOpt_Callback(hObject, eventdata, handles)
% hObject    handle to profAOpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns profAOpt contents as cell array
%        contents{get(hObject,'Value')} returns selected item from profAOpt


% --- Executes during object creation, after setting all properties.
function profAOpt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to profAOpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function msgIn_Callback(hObject, eventdata, handles)
% hObject    handle to msgIn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of msgIn as text
%        str2double(get(hObject,'String')) returns contents of msgIn as a double

set(handles.hashitButton,'enable','on');

% --- Executes during object creation, after setting all properties.
function msgIn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to msgIn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in hashitButton.
function hashitButton_Callback(hObject, eventdata, handles)
% hObject    handle to hashitButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load /MandelHasher/temp/profM
%load /MandelHasher/data/pubKeysA

% Load Profiles
if get(handles.profAOpt,'Value')~=1
    profAOpts = get(handles.profAOpt,'String');
    fileName = profAOpts{get(handles.profAOpt,'Value')};
    fileName = cellstr(strcat('/MandelHasher/dataA/',fileName));
    load(char(fileName));
else
    load /MandelHasher/dataA/keysA
end

if get(handles.profBOpt,'Value')~=1
    profBOpts = get(handles.profBOpt,'String');
    fileName = profBOpts{get(handles.profBOpt,'Value')};
    fileName = cellstr(strcat('/MandelHasher/dataB/',fileName));
    load(char(fileName));
else
    load /MandelHasher/dataB/keysB
end

% Hash it up
N = 2;          % Numerator of fcn to send msg into mset
numChars = str2double(get(handles.editNumChars,'String'));
msgRaw = get(handles.msgIn,'String');
msgBlocks = str2blocks(msgRaw,numChars);
mHashPts = msg2mset(msgBlocks,N);
for i = 1:length(mHashPts)
    mHashes(i).sig = mandelfn(globProf.c,mHashPts(i),priDKey_B.c,priDKey_B.x);
    %mHashes(i).sig = mandelfn(mHashPts(i),pubEKey_A,priDKey_B.c,priDKey_B.x);
end

fprintf('Message from Bill to Alice:\n---------------------------\n')
msgRaw
fprintf('msgBlocks:\n---------\n');
msgBlocks{:}
fprintf('mHashPts:\n---------\n');
mHashPts(:)
fprintf('mHashes.sig:\n---------\n');
mHashes(:).sig

save ./MandelHasher/temp/hashTempB msgRaw mHashes numChars

%pubBhash(i) = mandelfn(profM(1).c,mHashPts(i),profM(3).c,profM(3).x);
%secValB = (mandelfn(profM(1).c,pubEKey_A,profM(3).c,profM(3).x));



function msgForAliceName_Callback(hObject, eventdata, handles)
% hObject    handle to msgForAliceName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of msgForAliceName as text
%        str2double(get(hObject,'String')) returns contents of msgForAliceName as a double

set(handles.saveMsgForAliceButton,'enable','on');

% --- Executes during object creation, after setting all properties.
function msgForAliceName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to msgForAliceName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in saveMsgForAliceButton.
function saveMsgForAliceButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveMsgForAliceButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load /MandelHasher/temp/hashTempB

saveName = get(handles.msgForAliceName,'String');
saveName = sprintf('./MandelHasher/msgForAlice/%s', saveName);

save(saveName, 'msgRaw', 'mHashes', 'numChars')



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


% --- Executes on selection change in profBOpt.
function profBOpt_Callback(hObject, eventdata, handles)
% hObject    handle to profBOpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns profBOpt contents as cell array
%        contents{get(hObject,'Value')} returns selected item from profBOpt


% --- Executes during object creation, after setting all properties.
function profBOpt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to profBOpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in matchButton.
function matchButton_Callback(hObject, eventdata, handles)
% hObject    handle to matchButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Load Profiles
if get(handles.profAOpt,'Value')~=1
    profAOpts = get(handles.profAOpt,'String');
    fileName = profAOpts{get(handles.profAOpt,'Value')};
    fileName = cellstr(strcat('/MandelHasher/dataA/',fileName));
    load(char(fileName));
else
    load /MandelHasher/dataA/keysA;
end
diffValA = diffVal;

if get(handles.profAOpt,'Value')~=1
    profBOpts = get(handles.profBOpt,'String');
    fileName = profBOpts{get(handles.profBOpt,'Value')};
    fileName = cellstr(strcat('/MandelHasher/dataB/',fileName));
    load(char(fileName));
else
    load /MandelHasher/dataB/keysB;
end
diffValB = diffVal;
diffChk(1) = abs((diffValA - diffValB)/diffValA);
diffChk(2) = abs((diffValA - diffValB)/diffValB);

if any(diffChk > 1E-14)
    matchVal = 'NOT';
else
    matchVal = 'MATCH';
end
set(handles.errConsole,'String',matchVal);
