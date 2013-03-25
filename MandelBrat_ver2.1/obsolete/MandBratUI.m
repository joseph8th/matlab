% Mandel/Julia key-exchange simulator
% By Joseph Edwards, UNM-Albq.

% NOTE: to simulate correctly, MUST separate routines for C,A,B
% TO-DO LIST: subroutine to make sure c,e,d are not equal

clear; clc; close all;

plotOpt = menu('Plot Options', 'No Plot','MSet Only',...
    'cIn & C', 'All Z', 'MSet & C', 'C & Z', 'Z_(n-1)', 'All');
x = input('Enter Public MaxIter: x = ');
q = input('Enter Factor (q) for Range (q*x) of Private MaxIter: q = ');

% LOOP to ensure that c,e,d are different
c=complex(0,0); e=c; d=c;
while (c==e) || (c==d)

    % Get random shared public c from cInMSet()
    fprintf('\nPublic Data (C):\n----------------\n');
    load profileC; 
    fprintf('Limits = [%g, %g],[%g, %g]\n', ...
        real(limits(1)), real(limits(2)), imag(limits(1)), imag(limits(2)));
    fprintf('Steps = [%.0f, %.0f]\n\n', steps);
    
    [inMand,plotVals] = cInMfunSet(limits,x,steps);
    profM(1) = randPtsInM(inMand);
    
    % Break profM.C out for BkW compat:
    cIn=profM(1).cIn; c=profM(1).c; 
    Z_x=profM(1).Zx; z_x=profM(1).zx; 
    Z_xSub1=profM(1).ZxSub1; z_xSub1=profM(1).zxSub1;
    
    fprintf('c = %s\n\n',num2str(c));

    % Get rand private max iters: n~=k s.t. n>x for A, k>x for B
    n=0; k=0;
    while n==k
        N = (x+1:q*(x+1));
        R = mod( ceil(length(N)*rand(1,2)), length(N) ) + 1;
        n=N(R(1)); 
        k=N(R(2));
    end

 % PRIVATE DATA SIMULATION SECTION ...
    fprintf('Private Data (A & B):\n---------------------\n');
    fprintf(' n=%.0f, k=%.0f\n---------------------\n\n', n, k);
    while e==d
        % Get private e for Alice from cInMSet() 
        %load profileA;
        
        inMand = cInMfunSet(limits,n,steps);
        profM(2) = randPtsInM(inMand);
    
        % Break profM.A out for BkW compat:
        e=profM(2).c; 
        Z_n=profM(2).Zx; z_n=profM(2).zx; 
        Z_nSub1=profM(2).ZxSub1; z_nSub1=profM(2).zxSub1;
                
        fprintf('e = %s\n\n', num2str(e));

        % Get private d for Bob from cInMSet() 
        %load profileB;
        
        inMand = cInMfunSet(limits,k,steps);
        profM(3) = randPtsInM(inMand);
    
        % Break profM.B out for BkW compat:
        d=profM(3).c; 
        Z_k=profM(3).Zx; z_k=profM(3).zx; 
        Z_kSub1=profM(3).ZxSub1; z_kSub1=profM(3).zxSub1;
                
        fprintf('d = %s\n\n',num2str(d));
    end
end

% VISUALIZE [0=No, 1=M, 2=cIn&C, 3=Z, 4=1&2, 5=2&3, 6=All]
if plotOpt~=1
   vizMfun(plotOpt,plotVals,profM);
end

% COMPUTE PUBLIC KEYS for A & B ...

keyOpt = menu('Compute Public Encrypt/Decrypt\nKeys for A and B?', 'Yes', 'No');
if keyOpt == 2
    return;
end

priEKey_A = [e,n]; 
priDKey_B = [d,k];

initZ = c;
%funM = inline('z*c*e','z','c','e');
pubEKey_A = mandelfn(c,initZ,e,n);
pubDKey_B = mandelfn(c,initZ,d,k);

fprintf('Public Key Exchange\n-------------------\n');
fprintf('\nPublic E Key for A: pubEKey_A = %s', num2str(pubEKey_A));
fprintf('\nPublic D Key for B: pubDKey_B = %s', num2str(pubDKey_B));

% Exchange keys and compare notes...
keyOpt = menu('Should A and B exchange keys?', 'Yes', 'No');
if keyOpt == 2
    fprintf('\n\nExit successful...\n\n');
    return;
end

%funJ = inline('z*e','z','e');
secValA = (mandelfn(c,pubDKey_B,e,n));
secValB = (mandelfn(c,pubEKey_A,d,k));
diffVal = secValA - secValB;

fprintf('\n\nCompare Secret Values\n---------------------\n');
fprintf('\nsecValA = %1.32g\n        + %1.32g',real(secValA),imag(secValA));
fprintf('\nsecValB = %1.32g\n        + %1.32g',real(secValB),imag(secValB));
fprintf('\n----------------\ndiffVal = %1.32g\n        + %1.32g',...
    real(diffVal),imag(diffVal));
if diffVal==0
    fprintf('\n\nCompare: Exact Match!');
else
    fprintf('\n\nCompare: Failed.');
end
    
fprintf('\n\nExit successful...\n\n');
return;