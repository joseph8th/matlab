function [profM,plotVals] = genMset(profileIn,limitsIn)

load(profileIn); 
load(limitsIn);
    
% LOOP to ensure that c,e,d are different
c=complex(0,0); e=c; d=c;
while (c==e) | (c==d)

    % Get random shared public c from cInMSet()    
    [inMand,plotVals] = cInMfunSet(limits,x,steps);
    profM(1) = randPtsInM(inMand);
    c = profM(1).c;

    % Get rand private max iters: n~=k s.t. n>x for A, k>x for B
    n=0; k=0;
    while n==k
        N = (x+1:q*(x+1));
        R = mod( ceil(length(N)*rand(1,2)), length(N) ) + 1;
        n=N(R(1)); 
        k=N(R(2));
    end

 % PRIVATE DATA SIMULATION SECTION ...
    while e==d
        % Get private e for Alice from cInMSet() 
        %load profileA;
        
        inMand = cInMfunSet(limits,n,steps);
        profM(2) = randPtsInM(inMand);
        e = profM(2).c;

        % Get private d for Bob from cInMSet() 
        %load profileB;
        
        inMand = cInMfunSet(limits,k,steps);
        profM(3) = randPtsInM(inMand);
        d = profM(3).c;
    end
end