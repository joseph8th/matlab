function varargout = MandelBratGUI(varargin)
% MANDELBRATGUI M-file for MandelBratGUI.fig
%   Version 3.0 for MandelHasher by Joseph Edwards, Apr. 2011, UNM-Albq.
%   
%      MANDELBRATGUI, by itself, creates a new MANDELBRATGUI or raises the existing
%      singleton*.
%
%      H = MANDELBRATGUI returns the handle to a new MANDELBRATGUI or the handle to
%      the existing singleton*.
%
%      MANDELBRATGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MANDELBRATGUI.M with the given input arguments.
%
%      MANDELBRATGUI('Property','Value',...) creates a new MANDELBRATGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MandelBratGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MandelBratGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MandelBratGUI

% Last Modified by GUIDE v2.5 09-Apr-2011 22:56:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MandelBratGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @MandelBratGUI_OutputFcn, ...
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


% --- Executes just before MandelBratGUI is made visible.
function MandelBratGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MandelBratGUI (see VARARGIN)

load /MandelHasher/default/profCdefault;
load /MandelHasher/default/limCdefault;
save ./MandelHasher/temp/limitsC limits;
save ./MandelHasher/temp/profileC x q steps funM plotOpt;

set(handles.MaxIter,'String',num2str(x));
set(handles.iterMult,'String',num2str(q));
set(handles.limLowR,'String',num2str(limits(1)));
set(handles.limLowI,'String',num2str(limits(3)));
set(handles.limHighR,'String',num2str(limits(2)));
set(handles.limHighI,'String',num2str(limits(4)));
set(handles.stepR,'String',num2str(steps(1)));
set(handles.stepI,'String',num2str(steps(2)));
set(handles.mFunOpt,'String',funM);
set(handles.plotMenu,'Value',plotOpt);

%set(handles.plotAxes,'XLim',[min(limits(1),limits(2)), max(limits(1),limits(2))]);
%set(handles.plotAxes,'YLim',[min(limits(3),limits(4)), max(limits(3),limits(4))]);

% Choose default command line output for MandelBratGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MandelBratGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MandelBratGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function MaxIter_Callback(hObject, eventdata, handles)
% hObject    handle to MaxIter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MaxIter as text
%        str2double(get(hObject,'String')) returns contents of MaxIter as a double
x = str2double(get(hObject,'string'));
if isnan(x)
  errordlg('You must enter a numeric value','Bad Input','modal')
  uicontrol(hObject)
 return
end

% --- Executes during object creation, after setting all properties.
function MaxIter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MaxIter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function iterMult_Callback(hObject, eventdata, handles)
% hObject    handle to iterMult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iterMult as text
%        str2double(get(hObject,'String')) returns contents of iterMult as a double
q = str2double(get(hObject,'string'));
if isnan(q)
  errordlg('You must enter a numeric value','Bad Input','modal')
  uicontrol(hObject)
 return
end


% --- Executes during object creation, after setting all properties.
function iterMult_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iterMult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function limLowR_Callback(hObject, eventdata, handles)
% hObject    handle to limLowR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of limLowR as text
%        str2double(get(hObject,'String')) returns contents of limLowR as a double
limits = str2double(get(hObject,'string'));
if isnan(limits)
  errordlg('You must enter a numeric value','Bad Input','modal')
  uicontrol(hObject)
 return
end
%save profileC limits(1);

% --- Executes during object creation, after setting all properties.
function limLowR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to limLowR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function limLowI_Callback(hObject, eventdata, handles)
% hObject    handle to limLowI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of limLowI as text
%        str2double(get(hObject,'String')) returns contents of limLowI as a double
limits = str2double(get(hObject,'string'));
if isnan(limits)
  errordlg('You must enter a numeric value','Bad Input','modal')
  uicontrol(hObject)
 return
end
%save profileC limits(3);


% --- Executes during object creation, after setting all properties.
function limLowI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to limLowI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function limHighR_Callback(hObject, eventdata, handles)
% hObject    handle to limHighR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of limHighR as text
%        str2double(get(hObject,'String')) returns contents of limHighR as a double
limits = str2double(get(hObject,'string'));
if isnan(limits)
  errordlg('You must enter a numeric value','Bad Input','modal')
  uicontrol(hObject)
 return
end
%save profileC limits(2);

% --- Executes during object creation, after setting all properties.
function limHighR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to limHighR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function limHighI_Callback(hObject, eventdata, handles)
% hObject    handle to limHighI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of limHighI as text
%        str2double(get(hObject,'String')) returns contents of limHighI as a double
limits = str2double(get(hObject,'string'));
if isnan(limits)
  errordlg('You must enter a numeric value','Bad Input','modal')
  uicontrol(hObject)
 return
end
%save profileC limits(4);

% --- Executes during object creation, after setting all properties.
function limHighI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to limHighI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stepR_Callback(hObject, eventdata, handles)
% hObject    handle to stepR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stepR as text
%        str2double(get(hObject,'String')) returns contents of stepR as a double
steps = str2double(get(hObject,'string'));
if isnan(steps)
  errordlg('You must enter a numeric value','Bad Input','modal')
  uicontrol(hObject)
 return
end

% --- Executes during object creation, after setting all properties.
function stepR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stepR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stepI_Callback(hObject, eventdata, handles)
% hObject    handle to stepI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stepI as text
%        str2double(get(hObject,'String')) returns contents of stepI as a double
steps = str2double(get(hObject,'string'));
if isnan(steps)
  errordlg('You must enter a numeric value','Bad Input','modal')
  uicontrol(hObject)
 return
end

% --- Executes during object creation, after setting all properties.
function stepI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stepI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in plotMenu.
function plotMenu_Callback(hObject, eventdata, handles)
% hObject    handle to plotMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns plotMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plotMenu
%plotOpt = get(hObject,'Value');

% --- Executes during object creation, after setting all properties.
function plotMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plotMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in plotButton.
function plotButton_Callback(hObject, eventdata, handles)
% hObject    handle to plotButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load /MandelHasher/temp/profileC;
load /MandelHasher/temp/limitsC;

set(handles.limLowR,'String',num2str(limits(1)));
set(handles.limLowI,'String',num2str(limits(3)));
set(handles.limHighR,'String',num2str(limits(2)));
set(handles.limHighI,'String',num2str(limits(4)));

x = str2double(get(handles.MaxIter,'String'));
q = str2double(get(handles.iterMult,'String'));
steps(1) = str2double(get(handles.stepR,'String'));    
steps(2) = str2double(get(handles.stepI,'String'));
funMOpt = get(handles.mFunOpt,'String');
plotOpt = get(handles.plotMenu,'Value');

save ./MandelHasher/temp/profileC x q steps funM plotOpt;

fprintf('\n\n========================================\nMandelBrat Session\n');
fprintf('-----------------------\n');

% Generate global M-set profileC with plot data...
[inMand,plotVals] = cInMfunSet(limits,x,steps);
%[profM,plotVals] = genMProfiles('profileC','limitsC');
save ./MandelHasher/temp/profM inMand plotVals;

%Turn buttons on & set field vals...
set(handles.newPtButton,'Enable','on');

% PLOT M-SET w/Zoom-->Limits ...
% Reset limits on zoom
zoomH = zoom;
set(zoomH,'ActionPostCallback',@mypostcallback);
set(zoomH,'Enable','on');
% Plot Mandelbrot set
colormap jet(256);
pcolor(handles.plotAxes, plotVals.x,plotVals.y,log(double(plotVals.Zvalues)));
shading interp;
hold on  


% Zoom postcallback reset limits
function mypostcallback(obj,evd)
    newLimR = get(evd.Axes,'XLim');
    newLimI = get(evd.Axes,'YLim');
    limits = [newLimR, newLimI];
    save ./MandelHasher/temp/limitsC limits;
    


% --- Executes on button press in saveButton.
function saveButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

x = str2double(get(handles.MaxIter,'String'));
q = str2double(get(handles.iterMult,'String'));
limits(1) = str2double(get(handles.limLowR,'String'));   
limits(3) = str2double(get(handles.limLowI,'String'));
limits(2) = str2double(get(handles.limHighR,'String'));   
limits(4) = str2double(get(handles.limHighI,'String'));
steps(1) = str2double(get(handles.stepR,'String'));    
steps(2) = str2double(get(handles.stepI,'String'));
funM = get(handles.mFunOpt,'String');
plotOpt = get(handles.plotMenu,'Value');

set(handles.plotAxes,'XLim',[min(limits(1),limits(2)), max(limits(1),limits(2))]);
set(handles.plotAxes,'YLim',[min(limits(3),limits(4)), max(limits(3),limits(4))]);

save ./MandelHasher/temp/limitsC limits;
save ./MandelHasher/temp/profileC x q steps funM plotOpt;

consoleText = 'DFT SAVED';
set(handles.consoleText,'String',consoleText);


% --- Executes on button press in defaultButton.
function defaultButton_Callback(hObject, eventdata, handles)
% hObject    handle to defaultButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load /MandelHasher/default/profCdefault;
load /MandelHasher/default/limCdefault;
save ./MandelHasher/temp/limitsC limits;
save ./MandelHasher/temp/profileC x q steps funM plotOpt;

set(handles.MaxIter,'String',num2str(x));
set(handles.iterMult,'String',num2str(q));
set(handles.limLowR,'String',num2str(limits(1)));
set(handles.limLowI,'String',num2str(limits(3)));
set(handles.limHighR,'String',num2str(limits(2)));
set(handles.limHighI,'String',num2str(limits(4)));
set(handles.stepR,'String',num2str(steps(1)));
set(handles.stepI,'String',num2str(steps(2)));
set(handles.mFunOpt,'String',funM);
set(handles.plotMenu,'Value',plotOpt);

set(handles.plotAxes,'XLim',[min(limits(1),limits(2)), max(limits(1),limits(2))]);
set(handles.plotAxes,'YLim',[min(limits(3),limits(4)), max(limits(3),limits(4))]);

consoleText = 'DFT LOADED';
set(handles.consoleText,'String',consoleText);

% --- Executes on button press in newPtButton.
function newPtButton_Callback(hObject, eventdata, handles)
% hObject    handle to newPtButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load /MandelHasher/temp/profM;
profM = genMProfiles('/MandelHasher/temp/profileC','/MandelHasher/temp/limitsC');
randPtsOut(1) = {['x = ',num2str(profM(1).x),'; c = ', num2str(profM(1).c)]};
randPtsOut(2) = {['n = ',num2str(profM(2).x),'; e = ', num2str(profM(2).c)]};
randPtsOut(3) = {['k = ',num2str(profM(3).x),'; d = ', num2str(profM(3).c)]};

fprintf('-----------------------\n');
fprintf('%s\n',randPtsOut{:});

set(handles.genPubKeyButton,'Enable','on');
save ./MandelHasher/temp/profM inMand plotVals profM;

consoleText = 'PRIKEYS DONE';
set(handles.consoleText,'String',consoleText);


% --- Executes on button press in genPubKeyButton.
function genPubKeyButton_Callback(hObject, eventdata, handles)
% hObject    handle to genPubKeyButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load /MandelHasher/temp/profM;
initZ = profM(1).c;
%funM = inline('z*c*e','z','c','e');
pubEKey_A = mandelfn(profM(1).c,initZ,profM(2).c,profM(2).x);
pubEKey_B = mandelfn(profM(1).c,initZ,profM(3).c,profM(3).x);
save ./MandelHasher/data/pubKeys pubEKey_A pubEKey_B;

consoleOut(1) = {['pubEKey_A = ', num2str(pubEKey_A)]};
consoleOut(2) = {['pubEKey_B = ', num2str(pubEKey_B)]};

fprintf('-----------------------\n');
fprintf('%s\n',consoleOut{:});

%set(handles.consoleText,'String',consoleOut);
consoleIn = consoleOut;
save ./MandelHasher/temp/consoleLog consoleIn;

set(handles.swapButton,'Enable','on');
set(handles.saveProfilesButton,'Enable','on');
set(handles.saveProfAButton,'Enable','on');
set(handles.saveProfBButton,'Enable','on');

consoleText = 'PUBKEYS DONE';
set(handles.consoleText,'String',consoleText);


% --- Executes on button press in swapButton.
function swapButton_Callback(hObject, eventdata, handles)
% hObject    handle to swapButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%funJ = inline('z*e','z','e');
moe = 1E-14;
load /MandelHasher/temp/profM;
load /MandelHasher/data/pubKeys;
[secValA,swapTraceA] = (mandelfn(profM(1).c,pubEKey_B,profM(2).c,profM(2).x));
[secValB,swapTraceB] = (mandelfn(profM(1).c,pubEKey_A,profM(3).c,profM(3).x));
diffVals(1) = abs((secValA - secValB)/secValA);
diffVals(2) = abs((secValA - secValB)/secValB);
save ./MandelHasher/data/pubKeys pubEKey_A pubEKey_B secValA swapTraceA secValB swapTraceB diffVals;

load /MandelHasher/temp/consoleLog;
consLength = length(consoleIn);
consoleOut(1:consLength) = [consoleIn];
consoleOut(consLength+1) = {['secValA = ', num2str(secValA)]};
consoleOut(consLength+2) = {['secValB = ', num2str(secValB)]};
consoleOut(consLength+3) = {['diffValA = ', num2str(diffVals(1))]};
consoleOut(consLength+4) = {['diffValB = ', num2str(diffVals(2))]};
if any(diffVals>moe)
    consoleOut(consLength+5) = {'Not even close.'};
    consoleText = 'INVALID';
    set(handles.consoleText,'String',consoleText);
else
    consoleOut(consLength+5) = {'Close enough for Matlab!'};
    consoleText = 'VALID';
    set(handles.consoleText,'String',consoleText);
end

fprintf('-----------------------\n');
fprintf('%s\n',consoleOut{:});

%set(handles.consoleText,'String',consoleOut);
consoleIn = consoleOut;
save ./MandelHasher/temp/consoleLog consoleIn;

set(handles.plotRandButton,'Enable','on');


% --- Executes on button press in plotRandButton.
function plotRandButton_Callback(hObject, eventdata, handles)
% hObject    handle to plotRandButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load /MandelHasher/temp/profM;
load /MandelHasher/temp/profileC;
load /MandelHasher/temp/limitsC;
load /MandelHasher/data/pubKeys;

plotOpt = get(handles.plotMenu,'Value');

C = [profM(1).c,profM(2).c,profM(3).c];
SV = [secValA, secValB];
swapTrace = [swapTraceA,swapTraceB]
Z = [profM(1).zx,profM(2).zx,profM(3).zx]; 
ZSub1 = [profM(1).zxSub1,profM(2).zxSub1,profM(3).zxSub1];

colormap jet(256);
pcolor(handles.plotAxes, plotVals.x,plotVals.y,log(double(plotVals.Zvalues)));
shading interp;
hold on  

switch plotOpt
    case 1
        plot(handles.plotAxes,real(C),imag(C),'-ro')  
        plot(handles.plotAxes,real(SV),imag(SV),'-yx')
    case 2
        plot(handles.plotAxes,real(C),imag(C),'-ro')  
        plot(handles.plotAxes,real(SV),imag(SV),'-yx')
        plot(handles.plotAxes,real(swapTrace),imag(swapTrace),'-w.')
    case 3
        plot(handles.plotAxes,real(profM(1).cIn),imag(profM(1).cIn),'k.') 
        plot(handles.plotAxes,real(C),imag(C),'-ro')
    case 4
        plot(handles.plotAxes,real(profM(2).Zx),imag(profM(2).Zx),'g.')
        plot(handles.plotAxes,real(profM(3).Zx),imag(profM(3).Zx),'b.')
        plot(handles.plotAxes,real(Z),imag(Z),'-wx')
        plot(handles.plotAxes,real(ZSub1),imag(ZSub1),'-yx')
    case 5
        plot(handles.plotAxes,real(profM(1).ZxSub1),imag(profM(1).ZxSub1),'bo')
        plot(handles.plotAxes,real(ZSub1),imag(ZSub1),'-yx')
    case 6
        plot(handles.plotAxes,real(profM(1).ZxSub1),imag(profM(1).ZxSub1),'yo')
        plot(handles.plotAxes,real(profM(1).cIn),imag(profM(1).cIn),'k.')
        plot(handles.plotAxes,real(profM(2).Zx),imag(profM(2).Zx),'g.')
        plot(handles.plotAxes,real(profM(3).Zx),imag(profM(3).Zx),'b.') 
        plot(handles.plotAxes,real(C),imag(C),'-ro')
        plot(handles.plotAxes,real(Z),imag(Z),'-wx')
        plot(handles.plotAxes,real(ZSub1),imag(ZSub1),'-yx')
end

hold off


function consoleText_Callback(hObject, eventdata, handles)
% hObject    handle to consoleText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of consoleText as text
%        str2double(get(hObject,'String')) returns contents of consoleText as a double


% --- Executes during object creation, after setting all properties.
function consoleText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to consoleText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in mFunOpt.
function mFunOpt_Callback(hObject, eventdata, handles)
% hObject    handle to mFunOpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns mFunOpt contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mFunOpt


% --- Executes during object creation, after setting all properties.
function mFunOpt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mFunOpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in swapPlotOpt.
function swapPlotOpt_Callback(hObject, eventdata, handles)
% hObject    handle to swapPlotOpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of swapPlotOpt


% --- Executes during object creation, after setting all properties.
function swapPlotOpt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to swapPlotOpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function profAName_Callback(hObject, eventdata, handles)
% hObject    handle to profAName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of profAName as text
%        str2double(get(hObject,'String')) returns contents of profAName as a double


% --- Executes during object creation, after setting all properties.
function profAName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to profAName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in saveProfAButton.
function saveProfAButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveProfAButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load /MandelHasher/temp/profM;
load /MandelHasher/data/pubKeys;
globProf = profM(1);
priDKey_A = profM(2);
fileName = strcat('./MandelHasher/dataA/',get(handles.profAName,'String'));
diffVal = diffVals(1);
save(fileName, 'globProf', 'priDKey_A', 'pubEKey_A', 'diffVal');

consoleText = 'PROFILE A SAVED';
set(handles.consoleText,'String',consoleText);


function profBName_Callback(hObject, eventdata, handles)
% hObject    handle to profBName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of profBName as text
%        str2double(get(hObject,'String')) returns contents of profBName as a double


% --- Executes during object creation, after setting all properties.
function profBName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to profBName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in saveProfBButton.
function saveProfBButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveProfBButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load /MandelHasher/temp/profM;
load /MandelHasher/data/pubKeys;
globProf = profM(1);
priDKey_B = profM(3);
fileName = strcat('./MandelHasher/dataB/',get(handles.profBName,'String'));
diffVal = diffVals(2);
save(fileName, 'globProf', 'priDKey_B', 'pubEKey_B', 'diffVal');

consoleText = 'PROFILE B SAVED';
set(handles.consoleText,'String',consoleText);


% --- Executes on button press in saveProfilesButton.
function saveProfilesButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveProfilesButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load /MandelHasher/temp/profM;
load /MandelHasher/data/pubKeys;
globProf = profM(1);
priDKey_A = profM(2);
priDKey_B = profM(3);
diffVal = diffVals(1);
save ./MandelHasher/dataA/keysA globProf priDKey_A pubEKey_A diffVal;
diffVal = diffVals(2);
save ./MandelHasher/dataB/keysB globProf priDKey_B pubEKey_B diffVal;

consoleText = 'SAVED';
set(handles.consoleText,'String',consoleText);
