function [parametryFunkcji] = WczytajWymuszenia()
%w tej funkcji wczytujemy dane z pliku - poznajemy parametry L, a, omega oraz fi
temp = fopen('DanePliki/Wymuszenia.txt', 'r');
number = str2num(fgetl(temp));
for i=1:number
     dane = str2num(fgetl(temp));
     czlon1 = dane(1);
     czlon2 = dane(2);
     L = (dane(3)-dane(5))^2+(dane(4)-dane(6))^2;
     L = sqrt(L);
     
     a = dane(7);
     w = dane(8);
     fi = dane(9);
     [Q, UkladyWspolrzednych, ParyObrotowe, ParyPostepowe] = ReadStartData;
     punktA = [dane(3)  dane(4)]';
     punktB = [dane(5)  dane(6)]';
     uklad1 = UkladyWspolrzednych(czlon1,1:2)';
     uklad2 = UkladyWspolrzednych(czlon2,1:2)';
     sb = punktB - uklad2;
     sa = punktA - uklad1;
     sa = sa'; sb =sb';
     
     kat = atan2(dane(6)-dane(4), dane(5)-dane(3));  % do okreslenie przemieszczenia w ukladzie c4 i c6 
     parametryFunkcji(i,:) = [czlon1 czlon2 L, a, w, fi, kat, sa, sb];
end
fclose(temp);
end