function [matrix] = Rot(alfa)
%funkcja liczaca macierz rotacji
matrix = [
    cos(alfa) -sin(alfa);
    +sin(alfa) cos(alfa)];
end