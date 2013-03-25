function X = homoclinic(x,y,u)

X = [u*x + y - x^2; -x + u*y + 2*x^2];