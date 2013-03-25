function [X, Y] = kochfun(n, x_in, y_in)
% Recursive function to compute Koch curves per side

X_gen = [0; 1/3; 1/2; 2/3; 1];
Y_gen = [0; 0; sqrt(3)/6; 0; 0];

X{1} = x_in;
Y{1} = y_in;

for i = 1:n
    for j = 1:numel(X{i})-1
        theta = atan2((Y{i}(j+1) - Y{i}(j)), (X{i}(j+1) - X{i}(j)));
        dist = sqrt((Y{i}(j+1) - Y{i}(j))^2 + (X{i}(j+1) - X{i}(j))^2);
        tmp = [dist*X_gen(:), dist*Y_gen(:), ones(numel(X_gen),1)]*...
            [cos(theta), sin(theta), 0;
            -sin(theta), cos(theta) 0; 
            X{i}(j), Y{i}(j), 1];
        X{i+1}((j-1)*5 + 1:j*5) = tmp(:,1);
        Y{i+1}((j-1)*5 + 1:j*5) = tmp(:,2);
    end
    X{i+1}(6:5:end) = [];
    Y{i+1}(6:5:end) = [];
end
