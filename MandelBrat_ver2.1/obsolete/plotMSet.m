function plotMSet(plotVals)
% Function to plot Mandelbrot set 

figure(1);
colormap jet(256);
pcolor(plotVals.x,plotVals.y,log(double(plotVals.Zvalues)));
shading interp;
%h= uicontrol('Parent',gcf,'Interruptible','off',...
%'BusyAction','cancel','Units','points','BackgroundColor',[0.7 0.7 0.7], ...
%'Callback',['mSetsv(axis,' num2str(MaxIter) ',[' num2str(stepsR) ' ' num2str(stepsI) ']);'], ...
%'Position',[0 0 40 20],'Style','pushbutton','String','redo',...
%'Tag','redoitbutton');
zoom
hold on;      % JE
%  clear Z_n;    % JE chng fr Zvalues

return;