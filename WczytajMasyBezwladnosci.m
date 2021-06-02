function [Masy, Bezwladnosci] = WczytajMasyBezwladnosci()

fid = fopen('DanePliki/MasyBezwladnosci.txt', 'r');
number = str2num(fgetl(fid));
Masy = zeros(number,1);
Bezwladnosci = zeros(number,1);

while ~feof(fid)
    temp = str2num(fgetl(fid));
    Masy(temp(1)) = temp(2);
    Bezwladnosci(temp(1)) = temp(3);
end

fclose(fid);