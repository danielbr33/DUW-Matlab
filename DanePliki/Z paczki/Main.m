function [T,Q, DQ, DDQ] = Main(DT,T_MAX)
    
    %Pobranie danych z plików txt
    [Czlony, ParyObrotowe, ParyPostepowe, WymObrotowe, WymPostepowe] = Dane();
    
    % Przybli¿enie startowe  
    Q_TEMP = Czlony;
    DQ_TEMP = zeros(length(Q_TEMP),1); 
    DDQ_TEMP = zeros(length(Q_TEMP),1);  
    
    %Wyznaczenie liczby wyników i zadeklarowanie licznika 
    IleIteracji = 1;
    Size = T_MAX/DT + 1;
    
    %Zadeklarowanie rozmiaru macierzy i wektorów gromadz¹cych wyniki
    T = zeros(1, Size);
    Q = zeros(length(Q_TEMP), Size);
    DQ = zeros(length(Q_TEMP), Size);
    DDQ = zeros(length(Q_TEMP), Size);

    %Rozwi¹zywanie zadañ kinematyki w kolejnych chwilach T_TEMP
    for T_TEMP = 0:DT:T_MAX
        Q_TEMP=Q_TEMP+DQ_TEMP*DT+0.5*DDQ_TEMP*DT*DT;
        
        %Rozwi¹zanie zadania o po³o¿enie
        Q_TEMP=NewRaph(Q_TEMP, ParyObrotowe, ParyPostepowe, WymObrotowe, WymPostepowe, T_TEMP); 
        
        %Rozwi¹zanie zadania o prêdkoœci
        DQ_TEMP=Predkosc(Q_TEMP, ParyObrotowe, ParyPostepowe, WymObrotowe, WymPostepowe,T_TEMP); 
        
        %Rozwi¹zanie zadania o przyœpieszenia 
        DDQ_TEMP=Przyspieszenie(DQ_TEMP,Q_TEMP, ParyObrotowe, ParyPostepowe, WymObrotowe, WymPostepowe,T_TEMP);

        %Zapisane wyników do macierzy i wektorów gromadz¹cych
        T(1,IleIteracji) = T_TEMP; 
        Q(:,IleIteracji) = Q_TEMP;
        DQ(:,IleIteracji) = DQ_TEMP;
        DDQ(:,IleIteracji) = DDQ_TEMP;
    
        IleIteracji = IleIteracji + 1;
    end
