function [DDQ] = Przyspieszenia(DQ,Q,ParyObrotowe,ParyPostepowe,t)

    temp = fopen('DanePliki/UkladyWspolrzednych.txt', 'r');
    ncz = str2num(fgetl(temp)); 
    fclose(temp);
    
    temp = fopen('DanePliki/ParyObrotowe.txt', 'r');
    nobr = str2num(fgetl(temp));
    fclose(temp);
    
    temp = fopen('DanePliki/ParyPostepowe.txt', 'r');
    npos = str2num(fgetl(temp));
    fclose(temp);
    
    temp = fopen('DanePliki/Wymuszenia.txt', 'r');
    nwym = str2num(fgetl(temp));
    fclose(temp);
 
    G=zeros(2*(nobr+npos)+nwym,3*ncz);      %deklaracja rozm macierzy
 
    for i=1:(2*(nobr+npos)+nwym)
        G(i)=Gamma(Q,DQ);     %nie mam pomysłu jak zrobić tak, żeby program sam ogarnął o którą parę konkretnie chodzi - linijka do korekty
        i=i+1;
    end

    FQ = Jakobian(Q,ParyObrotowe,ParyPostepowe);
    DDQ = FQ\G;
end