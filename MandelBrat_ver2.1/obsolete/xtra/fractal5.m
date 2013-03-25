%Mandelbrot set
%author:Ankur Pawar
%this script takes about 2 seconds
%to complete the fractal.
%Remove the comment in line 62 to 63
%to save the fractal as a png file
   x  =  linspace(-1.5,1.5,2000);
   y  =  linspace(-1.5,1.5,2000);
len_x =  length(x);
len_y =  length(y);
 iter =  100;  %number of iterations
 xnew =  0; 
 ynew =  0;
    a =  0;    
    b =  0;
   xn =  0;   
   yn =  0;
rough =  0;
    c =  zeros(len_y,len_x);
 zval =  zeros(len_y,len_x);
h_msg =  msgbox(' Please Wait ',' ');

for n=1:len_y

    c(n,:)=y(n)+i*x(:);

end

tic
for m=1:len_x*len_y
     
     a = imag(c(m)); 
     b = real(c(m));
    xn = 0;   
    yn = 0;
     k = 0;
     while (k<=iter)&&((xn^2+yn^2)<4)
       xnew = xn^2 - yn^2 + a;
       ynew = 2*xn*yn + b;  
         xn = xnew;
         yn = ynew;
          k = k+1;
     end
    zval(m) = k;

end
toc
close(h_msg);
%you can also try any one of these colormaps
%cmap = flipud(colormap(cool(iter)));  
%cmap = flipud(colormap(copper(iter)));  
%cmap = flipud(colormap(hot(iter)));  
cmap = flipud(colormap(bone(iter)));  
%cmap = flipud(colormap(summer(iter))); 
%cmap = flipud(colormap(winter(iter)));  
%cmap = flipud(colormap(spring(iter)));  
%cmap = flipud(colormap(bone(iter)));    
colormap(cmap);
image(zval)
axis tight off

%clear x y c
%imwrite(zval,cmap ,'mandel123.png','png') ;



