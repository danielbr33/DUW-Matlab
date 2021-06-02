function [Masy, Bezwladnosci, M] = WczytajMasyBezwladnosci()

fid = fopen('DanePliki/MasyBezwladnosci.txt', 'r');
number = str2num(fgetl(fid));
Masy = zeros(number,1);
Bezwladnosci = zeros(number,1);
M = zeros(3*number, 3*number);
temp_diag = zeros(3*number, 1);

while ~feof(fid)
    temp = str2num(fgetl(fid));
    Masy(temp(1)) = temp(2);
    Bezwladnosci(temp(1)) = temp(3);
    temp_diag(temp(1)*3-2:temp(1)*3)=[temp(2) temp(2) temp(3)]';
end
M = diag(temp_diag);

fclose(fid);