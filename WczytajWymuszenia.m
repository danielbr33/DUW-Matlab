function [parametryFunkcji] = WczytajWymuszenia()
temp = fopen('DanePliki/Wymuszenia.txt', 'r');
number = str2num(fgetl(temp));
for i=1:number
     dane = str2num(fgetl(temp));
     czlon1 = dane(1);
     czlon2 = dane(2);
     L = (dane(3)-dane(5))^2+(dane(4)-dane(6))^2;
     L = sqrt(L);
     a = L/3;
     w = dane(8);
     fi = dane(9);
     kat = atan(dane(10));  % do okreslenie przemieszczenia w ukladzie c4 i c6 
     parametryFunkcji(i,:) = [czlon1 czlon2 L, a, w, fi, kat];
end