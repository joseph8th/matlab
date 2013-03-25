% MandelHasher 
% by Joseph E. Edwards VIII, 2011
% University of New Mexico, Dept. of Mathematics (Independent Study)
% --------------------------------------------
% Simple chooser for my Matlab development environment for 
% Mandelbrot Set based Hash algorithm for data validation.
%
% NOTE: Due to limitations of Matlab, these models aren't very
% accurate, but intended only to develop the necessary algorithms 
% for later implementation (i.e. in Python or other).

clear all;

mPath = '/home/joseph/Programming/Matlab/indie/MandelHasher/MandelHasher';
addpath(genpath(mPath));

choice = 0;
choices = {'Gen Profiles w/MandelBrat',...
    'Be Bill! M-Hash a Message', 'Be Alice! J-Check a Message',...
    'Be Bill! Encrypt Message', 'Be Alice! Decrypt Message',...
     'QUIT IT!'};

while choice~=6
choice = menu('What To Do, What To Do?', choices);
switch choice
    case 1
        MandelBratGUI()
    case 2
        MandelHashItGUI()
    case 3
        JuliaCheckItGUI()
    case 4
        MandelEncryptGUI()
    case 5
        MandelDecryptGUI()
end
end