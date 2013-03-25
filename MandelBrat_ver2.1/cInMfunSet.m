function [inMand, plotVals] = cInMfunSet(limits,MaxIter,steps)
% [cIn, Z_n] = msetgen(limits,maxIt,steps)

% Based on original program by Lucio Andrade (Feb 2002).
% All mods marked by Joseph Edwards, jee8th@unm.edu, UNM-Albq (Dec 2010),
% and used in this function to obtain c in Mandelbrot set, and visualize.
% Error-checking & non-vector method removed.

if exist('limits')~=1
    lowerR=-2;   lowerI=-1.25;
    higherR=1;   higherI=1.25;
elseif numel(limits)==0
    lowerR=-2;   lowerI=-1.25;
    higherR=1;   higherI=1.25;
elseif  numel(limits)==2
    lowerR=min(real(limits));   
    lowerI=min(imag(limits));
    higherR=max(real(limits));  
    higherI=max(imag(limits)); 
elseif numel(limits)==4
    lowerR=limits(1);    lowerI=limits(3);
    higherR=limits(2);   higherI=limits(4); 
else error('Wrong input for ''limits'''); end
  
if exist('steps')~=1     
    stepsR=300; stepsI=400;  
elseif numel(steps) == 2 
    stepsR=steps(1); stepsI=steps(2);
elseif numel(steps) == 1 
    stepsR=steps(1); stepsI=steps(1);
else error('Wrong input for ''steps'''); end

%compute other constants  
  Rwidth=higherR-lowerR;    
  Iwidth=higherI-lowerI;
  slR=Rwidth/(stepsR-1);
  slI=Iwidth/(stepsI-1);

% Initialize
 
[x,y]=meshgrid([0:stepsR-1]*slR+lowerR,[0:stepsI-1]*slI+lowerI);
  Zvalues=ones(size(x));
  initZ=zeros(size(x));
  c=(x + 1i*y);
  
tic

% Compute Mandelbrot function set
% Fcn def. Z(n) = c*f(Z(n-1)) --> z = z*c^2

z=initZ;
h_z=1:(stepsR*stepsI);
for counter=1:MaxIter
  zxSub1(h_z) = z(h_z);
  %z(h_z)=c(h_z).*(z(h_z).^2 + c(h_z));  
  z(h_z)=z(h_z).^2+c(h_z);
  h_z= h_z(find(abs(z(h_z))<2));
  Zvalues(h_z)=Zvalues(h_z)+1;      
end
%JE: Get all cIn and Z_n in Mset
h_zIn = h_z(find(Zvalues(h_z)==MaxIter+1));
inMand.x = MaxIter;
inMand.cIn = c(h_zIn);
inMand.Zx = z(h_zIn);
inMand.ZxSub1 = zxSub1(h_zIn);

%JE Mod: rm non-vector method

disp(['Elapsed time: ' num2str(toc)])

plotVals.x = x;
plotVals.y = y;
plotVals.Zvalues = Zvalues;

if nargout==1
    clear plotVals;
elseif nargout==0
    error('Nargout error.');
end

return;