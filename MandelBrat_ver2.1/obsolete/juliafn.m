function secVal = juliafn(c,initZ,priKey)
% Function to compute public key ...

e = priKey(1);
n = priKey(2);

% Compute Julia function for given c in MSet
z=initZ;
for counter=1:n
  z=z*e;
end

secVal = z;

return;