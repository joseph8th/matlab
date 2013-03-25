%Julia set
%author:Ankur Pawar
%this script takes about 2 second
%to complete the fractal.
%Remove the comment in line 72 to 77
%to save the fractal as a png file


xres = 2000;%x resolution
yres = 2000;%y resolution
x = linspace(-1.5,1.5,xres);
y = linspace(-1.5,1.5,yres);
c = zeros(length(y),length(x));
xn= 0;
yn= 0;
xnew = 0;
ynew = 0;
lenx  = length(x);
leny  = length(y);
zval  = zeros(lenx,leny);
%array containing iterations for each julia set
iter_arr=[50 200 100 50  100 100 200 100 50 ...
          100 100 200 100 200 200 200];
%list of 16 constants for 16 different julia set
liststr={'-0.7500-0.3500i';'-0.4000+0.6000i';
         '+0.2850+0.0100i';'+0.4500+0.1428i';
         '-0.7017+0.3842i';'-0.8350-0.2321i';
         '-0.8000+0.1560i';'-0.2365-0.6721i';
         '+0.2311+0.6068i';'-0.7322-0.2628i';
         '-0.79543+0.17308i';'-0.51251+0.52129i';
         '-0.81000-0.17950i';'0.36237+0.32i';
         '-0.4959345-0.52287731i';
         '-0.4942345+0.52287731i'};
[s,v] = listdlg('PromptString','Select any one',...
                'SelectionMode','single',...
                'ListString',liststr);
if v==1                
   an=liststr{s};
   a = real(str2num(an));
   b = imag(str2num(an));
   
   h_msg = msgbox(' Please Wait ',' ');
   iter  = iter_arr(s);
   for n=1:leny

       c(n,:)=y(n)+i*x(:);

   end                 

   tic %timer on

   for n = 1:lenx*leny
    
       k  = 1;
       xn = real(c(n));
       yn = imag(c(n));
       while ((k < iter) &&((xn*xn + yn*yn)<4))
              xnew = xn*xn-yn*yn + a;
              ynew = 2*xn*yn + b;
                xn = xnew;
                yn = ynew;
                 k = k+1;
       end
       zval(n)= k;
    
   end
toc  %timer off
close(h_msg);
%you can also try any one of these colormaps
%cmap = flipud(colormap(hsv(iter)));  
%cmap = flipud(colormap(bone(iter)));  
%cmap = flipud(colormap(hot(iter)));  
%cmap = flipud(colormap(gray(iter)));  
%cmap = flipud(colormap(bone(iter)));  
%cmap = flipud(colormap(summer(iter))); 
%cmap = flipud(colormap(pink(iter)));  
%cmap = fliplr(colormap(copper(iter)));  
cmap = flipud(fliplr(bone(iter)));    
zval = zval';
colormap(cmap);
image(x,y,zval);
axis tight off
%clear x y c
%imwrite(zval,cmap,['julia' an '.png'],'png','source','Computer generated');
end
