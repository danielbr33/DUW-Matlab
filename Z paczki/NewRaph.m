function Q_TEMP = NewRaph(Q_TEMP, ParyObrotowe, ParyPostepowe, WymObrotowe, WymPostepowe, T_TEMP)
    %Rozwi¹zanie uk³adu równañ metod¹ Newtona-Raphsona

    F = ones(length(Q_TEMP),1);
    EPS = 10e-9;
    IleIteracji = 1;
    MaxIteracji = 25;

    while(norm(F) > EPS && IleIteracji < MaxIteracji)
        F = Wiezy(Q_TEMP, ParyObrotowe, ParyPostepowe, WymObrotowe, WymPostepowe, T_TEMP);
        FQ = Jakobian(Q_TEMP, ParyObrotowe, ParyPostepowe, WymObrotowe, WymPostepowe);
        Q_TEMP = Q_TEMP - FQ\F;
        IleIteracji = IleIteracji + 1;
    end
    
    
    if(IleIteracji > MaxIteracji)
        disp('Nie uda³o siê uzyskaæ zbie¿noœci po za³o¿onej liczbie iteracji')
    end
end

