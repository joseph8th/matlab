function logmapplot(r, x0, orbLen)

close all;

% Compute recursively (for plot)
x = x0;
X = zeros(1,orbLen);
X_n = zeros(1,orbLen);
for i = 1:orbLen
    X(i) = x;
    X_n(i) = logmap(r, x);
    x = X_n(i);
end;

% Compute exactly (for plot)
X_ex = 0:0.01:1;
Y_ex = r*X_ex.*(1-X_ex);

% Compute Liapunov exponent:
% 1st dispense w/transient dynamics..
x = rand(1);
for i = 1:300
    x_n = logmap(r, x);
    x = x_n;
end;
% ...then get long orbit for limit est...
lam = 0;
for i = 1:10000
    lam = lam + log(abs(r - 2*r*x));
    x_n = logmap(r, x);
    x = x_n;
end;
lam = lam/10000;

% Plotting stuff below...
figure
subplot(3,1,1:2)
hold on

% Plot y=x & x*
line([0 1], [0 1])
if r ~= 0
    if 1-1/r > 0
        plot(1-1/r, 1-1/r, 'ko')
    end;
end;
% Plot exact fcn
plot(X_ex, Y_ex,'--r')
% Plot recursive map
plot(X,X_n,'bx')
% Plot cobwebs
y = 0;
for i = 1:orbLen
    line([X(i) X(i)], [y X_n(i)])
    line([X(i) X_n(i)], [X_n(i) X_n(i)])
    y = X_n(i);
end;

title(['x_{n+1}=x_{n}r(1-x_{n}); r=',...
    num2str(r), ', Liapunov= ', num2str(lam)])
hold off

subplot(3,1,3)
% Plot histogram of recur-map
hist(X)