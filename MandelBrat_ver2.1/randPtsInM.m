function profM = randPtsInM(inMand)
% Fn to find nonzero points in mandelfn, returns random point
% & corr. z_n in mandelfn.

not0 = find(nonzeros(inMand.cIn));
lengthIn = length(not0);
fprintf('cIn pool for profM.c: %.0f\n', lengthIn);
R = 0;
while R==0
    R = mod(floor(lengthIn*rand(1)),lengthIn);    % needs work
end
profM.x = inMand.x;
profM.cIn = inMand.cIn(not0);
profM.c = profM.cIn(R);
profM.Zx = inMand.Zx(not0);
profM.zx = profM.Zx(R);
profM.ZxSub1 = inMand.ZxSub1(not0);
profM.zxSub1 = profM.ZxSub1(R);

return;