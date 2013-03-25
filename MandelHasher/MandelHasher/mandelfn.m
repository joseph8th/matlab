function [pubKey,allPts] = mandelfn(c,initZ,e,n)
% Function to compute public key ...

% Compute z's for given c in MSet
z(1)=initZ;
for i=1:n-1
  z(i+1)=z(i)*c^2*e; 
end

pubKey = z(n);
allPts = z;

if nargout==1
    clear allPts;
end

return;