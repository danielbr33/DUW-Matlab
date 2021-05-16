function [DQ] = Predkosci(Q, ParyObrotowe, ParyPostepowe, t, Fi_dt)

%nie wrzucam tutaj liczenia FT jak w paczce, bo chyba to zrobiles w Fi_dt
%jesli dobrze rozumiem (ale moge sie mylic)
Fq=Jakobian(Q, ParyObrotowe, ParyPostepowe);
DQ = -Fq \ Fi_dt(Q,t);

end
