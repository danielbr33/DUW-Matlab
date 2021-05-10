function Q=NewRaph(Q,t,ParyObrotowe,ParyPostepowe)
%nie jestem pewna, czy w niektórych funkcjach (nawiasach) nie powinno byæ
%du¿e Q zamiast ma³ego q - w sensie konkretnie w pliku Jakobian.m

Q=q;
iter=1; %Licznik iteracji
while((norm(F)>1e-10)&(iter<25))
    F=Fi(Q,t,ParyObrotowe, ParyPostepowe);
    Fq=Jakobian(Q, ParyObrotowe, ParyPostepowe)
    Q=Q-Fq\F;
    iter=iter+1;
end
if iter>=25
    disp("B£¥D: po 25 iteracjach N-R nie uzyskano zbie¿noœci");
    Q=Q0;
end