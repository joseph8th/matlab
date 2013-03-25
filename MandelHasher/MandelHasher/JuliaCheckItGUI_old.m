function varargout = JuliaCheckItGUI(varargin)
% JuliaCheckItGUI M-file for JuliaCheckItGUI.fig
%      JuliaCheckItGUI, by itself, creates a new JuliaCheckItGUI or raises the existing
%      singleton*.
%
%      H = JuliaCheckItGUI returns the handle to a new JuliaCheckItGUI or the handle to
%      the existing singleton*.
%
%      JuliaCheckItGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in JuliaCheckItGUI.M with the given input arguments.
%
%      JuliaCheckItGUI('Property','Value',...) creates a new JuliaCheckItGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before JuliaCheckItGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to JuliaCheckItGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help JuliaCheckItGUI

% Last Modified by GUIDE v2.5 10-Apr-2011 02:54:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @JuliaCheckItGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @JuliaCheckItGUI_OutputFcn, ...
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


% --- Executes just before JuliaCheckItGUI is made visible.
function JuliaCheckItGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to JuliaCheckItGUI (see VARARGIN)

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

msgDir = dir('./MandelHasher/msgForAlice/');
for i = 1:length(msgDir)
   msgOpt(i) = cellstr(msgDir(i).name);
end
set(handles.msgOpts,'String',msgOpt);

% Choose default command line output for JuliaCheckItGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes JuliaCheckItGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = JuliaCheckItGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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



% --- Executes on button press in loadMsgButton.
function loadMsgButton_Callback(hObject, eventdata, handles)
% hObject    handle to loadMsgButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fileOpts = get(handles.msgOpts,'String');
fileName = fileOpts{get(handles.msgOpts,'Value')};
fileName = cellstr(strcat('./MandelHasher/msgForAlice/',fileName));
load(char(fileName));
set(handles.msgConsole,'String',msgRaw);
mHashes(:).sig
numChars

save ./MandelHasher/temp/msgTemp

set(handles.reHashItButton,'Enable','on');



% --- Executes on button press in reHashItButton.
function reHashItButton_Callback(hObject, eventdata, handles)
% hObject    handle to reHashItButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load /MandelHasher/temp/profM
load /MandelHasher/temp/msgTemp

% Load Profiles
if get(handles.profAOpt,'Value')~=1
    profAOpts = get(handles.profAOpt,'String');
    fileName = profAOpts{get(handles.profAOpt,'Value')};
    fileName = cellstr(strcat('/MandelHasher/dataA/',fileName));
    load(char(fileName));
else
    load /MandelHasher/dataA/keysA
end

if get(handles.profAOpt,'Value')~=1
    profBOpts = get(handles.profBOpt,'String');
    fileName = profBOpts{get(handles.profBOpt,'Value')};
    fileName = cellstr(strcat('/MandelHasher/dataB/',fileName));
    load(char(fileName));
else
    load /MandelHasher/dataB/keysB
end

% Re-hash it up from A's POV
msgBlocksChk = str2blocks(msgRaw,numChars);
mHashPtsChk = msg2mset(msgBlocksChk);
for i = 1:length(mHashPtsChk)
    mHashesChk(i).sig = mandelfn(globProf.c,mHashPtsChk(i),priDKey_A.c,priDKey_A.x);
    mHashesChk(i).sec = mandelfn(globProf.c,mHashes(i).sig,priDKey_A.c,priDKey_A.x);
end

fprintf('Message from B to A (Alice HashChk):\n---------------------------\n')
msgRaw
fprintf('mHashes.sig:\n---------\n');
mHashes(:).sig
fprintf('\n-----------------\nAlice Re-Hash:\n---------------------------\n')
fprintf('msgBlocks:\n---------\n');
msgBlocksChk{:}
fprintf('mHashPts:\n---------\n');
mHashPtsChk(:)
fprintf('mHashesChk.sig:\n---------\n');
mHashesChk(:).sig
fprintf('mHashes.sec:\n---------\n');
mHashesChk(:).sec

save ./MandelHasher/temp/hashTempA mHashesChk 
save ./MandelHasher/temp/hashTempB globProf priDKey_B

set(handles.checkitButton,'Enable','on');



% --- Executes on button press in checkitButton.
function checkitButton_Callback(hObject, eventdata, handles)
% hObject    handle to checkitButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%load /MandelHasher/temp/profM
load /MandelHasher/temp/msgTemp
load /MandelHasher/temp/hashTempA
load /MandelHasher/temp/hashTempB
maxMoE = 1E-32;

% Alice sends Bill her mHashesChk.sig
% Bill Makes secHashes from Alice sigHashes & sends them back to Alice
for i = 1:length(mHashes)
    mHashes(i).sec = mandelfn(globProf.c,mHashesChk(i).sig,priDKey_B.c,priDKey_B.x);
    errMargin(i) = abs(mHashesChk(i).sec - mHashes(i).sec);
end

% Then Bill sends Alice his secHashes & Alice checks against hers
if any(errMargin > maxMoE)
    set(handles.checkConsole,'String','INVALID');
else
    set(handles.checkConsole,'String','VALID');
    set(handles.saveMsgFromBillButton,'Enable','on');
end

fprintf('\n----------------\nMargins of Error per Hash\n');
errMargin(:)

save ./MandelHasher/temp/msgTemp msgRaw mHashes numChars



function checkConsole_Callback(hObject, eventdata, handles)
% hObject    handle to checkConsole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of checkConsole as text
%        str2double(get(hObject,'String')) returns contents of checkConsole as a double


% --- Executes during object creation, after setting all properties.
function checkConsole_CreateFcn(hObject, eventdata, handles)
% hObject    handle to checkConsole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function msgConsole_Callback(hObject, eventdata, handles)
% hObject    handle to msgConsole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of msgConsole as text
%        str2double(get(hObject,'String')) returns contents of msgConsole as a double


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



function saveMsgFromBillName_Callback(hObject, eventdata, handles)
% hObject    handle to saveMsgFromBillName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of saveMsgFromBillName as text
%        str2double(get(hObject,'String')) returns contents of saveMsgFromBillName as a double


% --- Executes during object creation, after setting all properties.
function saveMsgFromBillName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to saveMsgFromBillName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in saveMsgFromBillButton.
function saveMsgFromBillButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveMsgFromBillButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load /MandelHasher/temp/msgTemp
load /MandelHasher/temp/hashTempA
fileName = get(handles.saveMsgFromBillName,'String');
fileName = strcat('./MandelHasher/msgFromBill/',fileName);
save(fileName)


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
