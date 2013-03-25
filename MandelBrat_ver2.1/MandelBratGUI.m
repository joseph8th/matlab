function varargout = MandelBratGUI(varargin)
% MANDELBRATGUI M-file for MandelBratGUI.fig
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

% Last Modified by GUIDE v2.5 05-Jan-2011 20:02:21

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

load ./default/profCdefault;
load ./default/limCdefault;
save ./temp/limitsC limits;
save ./temp/profileC x q steps funM plotOpt;

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

load ./temp/profileC;
load ./temp/limitsC;

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

save ./temp/profileC x q steps funM plotOpt;

% Generate global M-set profileC with plot data...
[inMand,plotVals] = cInMfunSet(limits,x,steps);
%[profM,plotVals] = genMProfiles('profileC','limitsC');
save ./temp/profM inMand plotVals;

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
    save ./temp/limitsC limits;
    


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

save ./temp/limitsC limits;
save ./temp/profileC x q steps funM plotOpt;


% --- Executes on button press in defaultButton.
function defaultButton_Callback(hObject, eventdata, handles)
% hObject    handle to defaultButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load ./default/profCdefault;
load ./default/limCdefault;
save ./temp/limitsC limits;
save ./temp/profileC x q steps funM plotOpt;

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



% --- Executes on button press in newPtButton.
function newPtButton_Callback(hObject, eventdata, handles)
% hObject    handle to newPtButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load ./temp/profM;
profM = genMProfiles('./temp/profileC','./temp/limitsC');
randPtsOut(1) = {['x = ',num2str(profM(1).x),'; c = ', num2str(profM(1).c)]};
randPtsOut(2) = {['n = ',num2str(profM(2).x),'; e = ', num2str(profM(2).c)]};
randPtsOut(3) = {['k = ',num2str(profM(2).x),'; d = ', num2str(profM(3).c)]};
set(handles.randPtsText,'String',randPtsOut);
set(handles.genPubKeyButton,'Enable','on');
set(handles.plotRandButton,'Enable','on');
save ./temp/profM inMand plotVals profM;


% --- Executes on button press in plotRandButton.
function plotRandButton_Callback(hObject, eventdata, handles)
% hObject    handle to plotRandButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load ./temp/profM;
load ./temp/profileC;
load ./temp/limitsC;
plotOpt = get(handles.plotMenu,'Value');
if plotOpt>=2
    %Z's & C's
    C = [profM(1).c,profM(2).c,profM(3).c];
    Z = [profM(1).zx,profM(2).zx,profM(3).zx]; 
    ZSub1 = [profM(1).zxSub1,profM(2).zxSub1,profM(3).zxSub1];
    
    % Reset limits on zoom
%    zoomH = zoom;
 %   set(zoomH,'ActionPostCallback',@mypostcallback);
  %  set(zoomH,'Enable','on');
    % Plot Mandelbrot set
    colormap jet(256);
    pcolor(handles.plotAxes, plotVals.x,plotVals.y,log(double(plotVals.Zvalues)));
    shading interp;
    hold on  
    
    switch plotOpt
        case 2
            return;            
        case 3
            plot(handles.plotAxes,real(profM(1).cIn),imag(profM(1).cIn),'k.') 
            plot(handles.plotAxes,real(C),imag(C),'-ro')
        case 4
            plot(handles.plotAxes,real(profM(2).Zx),imag(profM(2).Zx),'g.')
            plot(handles.plotAxes,real(profM(3).Zx),imag(profM(3).Zx),'b.')
            plot(handles.plotAxes,real(Z),imag(Z),'-wx')
            plot(handles.plotAxes,real(ZSub1),imag(ZSub1),'-yx')
        case 5
            plot(handles.plotAxes,real(profM(1).cIn),imag(profM(1).cIn),'ko') 
            plot(handles.plotAxes,real(C),imag(C),'-wx')
        case 6
            plot(handles.plotAxes,real(profM(1).cIn),imag(profM(1).cIn),'k.')
            plot(handles.plotAxes,real(profM(2).Zx),imag(profM(2).Zx),'g.')
            plot(handles.plotAxes,real(profM(3).Zx),imag(profM(3).Zx),'b.') 
            plot(handles.plotAxes,real(C),imag(C),'-ro')
            plot(handles.plotAxes,real(Z),imag(Z),'-wx')
            plot(handles.plotAxes,real(ZSub1),imag(ZSub1),'-yx')
        case 7
            plot(handles.plotAxes,real(profM(1).ZxSub1),imag(profM(1).ZxSub1),'bo')
            plot(handles.plotAxes,real(ZSub1),imag(ZSub1),'-yx')
        case 8
            plot(handles.plotAxes,real(profM(1).ZxSub1),imag(profM(1).ZxSub1),'yo')
            plot(handles.plotAxes,real(profM(1).cIn),imag(profM(1).cIn),'k.')
            plot(handles.plotAxes,real(profM(2).Zx),imag(profM(2).Zx),'g.')
            plot(handles.plotAxes,real(profM(3).Zx),imag(profM(3).Zx),'b.') 
            plot(handles.plotAxes,real(C),imag(C),'-ro')
            plot(handles.plotAxes,real(Z),imag(Z),'-wx')
            plot(handles.plotAxes,real(ZSub1),imag(ZSub1),'-yx')
    end
    
    hold off
end



% --- Executes on button press in genPubKeyButton.
function genPubKeyButton_Callback(hObject, eventdata, handles)
% hObject    handle to genPubKeyButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load ./temp/profM;
initZ = profM(1).c;
%funM = inline('z*c*e','z','c','e');
pubEKey_A = mandelfn(profM(1).c,initZ,profM(2).c,profM(2).x);
pubDKey_B = mandelfn(profM(1).c,initZ,profM(3).c,profM(3).x);
save ./data/pubKeys pubEKey_A pubDKey_B;

consoleOut(1) = {['pubEKey_A = ', num2str(pubEKey_A)]};
consoleOut(2) = {['pubDKey_B = ', num2str(pubDKey_B)]};
set(handles.consoleText,'String',consoleOut);
consoleIn = consoleOut;
save ./temp/consoleLog consoleIn;

set(handles.swapButton,'Enable','on');


% --- Executes on button press in swapButton.
function swapButton_Callback(hObject, eventdata, handles)
% hObject    handle to swapButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%funJ = inline('z*e','z','e');
load ./temp/profM;
load ./data/pubKeys;
secValA = (mandelfn(profM(1).c,pubDKey_B,profM(2).c,profM(2).x));
secValB = (mandelfn(profM(1).c,pubEKey_A,profM(3).c,profM(3).x));
diffVal = secValA - secValB;
save ./data/pubKeys pubEKey_A pubDKey_B secValA secValB diffVal;

load ./temp/consoleLog;
consLength = length(consoleIn);
consoleOut(1:consLength) = [consoleIn];
consoleOut(consLength+1) = {['secValA = ', num2str(secValA)]};
consoleOut(consLength+2) = {['secValB = ', num2str(secValB)]};
consoleOut(consLength+3) = {['diffVal = ', num2str(diffVal)]};
if diffVal==0
    consoleOut(consLength+4) = {'Exact Match!'};
else
    consoleOut(consLength+4) = {'Not a Match!'};
end
set(handles.consoleText,'String',consoleOut);
consoleIn = consoleOut;
save ./temp/consoleLog consoleIn;


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


% --- Executes on button press in compareButton.
function compareButton_Callback(hObject, eventdata, handles)
% hObject    handle to compareButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
