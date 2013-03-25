function pubKey = mandelfn(c,initZ,e,n)
% Function to compute public key ...

% Compute Mandelbrot function for given c in MSet
z=initZ;
for counter=1:n
  z=z*c^2*e; 
end

pubKey = z;

return;