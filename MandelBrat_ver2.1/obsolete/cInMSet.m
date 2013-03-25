function [inMand, plotVals] = cInMSet(limits,MaxIter,steps)
% [cIn, Z_n] = msetgen(limits,maxIt,steps)

% Based on original program by Lucio Andrade (Feb 2002).
% All mods marked by Joseph Edwards, jee8th@unm.edu, UNM-Albq (Dec 2010),
% and used in this function to obtain c in Mandelbrot set, and visualize.
% Error-checking & non-vector method removed.


    lowerR=min(real(limits));   
    lowerI=min(imag(limits));
    higherR=max(real(limits));  
    higherI=max(imag(limits)); 
  
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

% Compute Mandelbrot set

z=initZ;
h_z=1:(stepsR*stepsI);
for counter=1:MaxIter
  z_nSub1(h_z) = z(h_z);
  z(h_z)=z(h_z).^2+c(h_z);
  h_z= h_z(find(abs(z(h_z))<2));
  Zvalues(h_z)=Zvalues(h_z)+1;      
end
%JE: Get all cIn and Z_n in Mset
h_zIn = h_z(find(Zvalues(h_z)==MaxIter+1));
inMand.cInM = c(h_zIn);
inMand.zInM = z(h_zIn);
inMand.ZnSub1 = z_nSub1(h_zIn);

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