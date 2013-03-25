% Mandel/Julia key-exchange simulator
% By Joseph Edwards, UNM-Albq.

% NOTE: to simulate correctly, MUST separate routines for C,A,B
% TO-DO LIST: subroutine to make sure c,e,d are not equal

clear; clc; close all;

% UI to edit profileC
uiOpt = menu('Edit Profile and Plot Options?', 'Yes','No');  
if uiOpt==1
    pause on
    guiM = MandelBratGUI;
    disp('Press any key to continue...')
    pause
    pause off
end

load profileC; 
    


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