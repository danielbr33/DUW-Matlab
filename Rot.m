function [matrix] = Rot(alfa)
matrix = [
    cos(alfa) sin(alfa);
    -sin(alfa) cos(alfa)];
end