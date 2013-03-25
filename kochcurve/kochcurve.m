function kochcurve(X, Y)
% Function to plot koch snowflake...
% Joseph Edwards, M412, UNM, Sp12, Hwk6

close all

figure
h = plot(nan,nan);
axis equal off
for j = 1:numel(X)
    set(h, 'xdata',X{j}, 'ydata',Y{j})
    pause(1)
end