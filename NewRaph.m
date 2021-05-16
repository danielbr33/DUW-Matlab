function Q=NewRaph(Q,t, ParyObrotowe, ParyPostepowe, wymuszeniaParametry)

FI = ones(length(Q),1);
iter=1; %Licznik iteracji
while((norm(FI)>1e-10) && (iter<25))
    FI=Fi(Q, t, ParyObrotowe, ParyPostepowe, wymuszeniaParametry);
    FIq = Jakobian(Q, ParyObrotowe, ParyPostepowe, wymuszeniaParametry);
    Q=Q-FIq\FI;
    iter=iter+1;
end
if iter>=25
    disp("BLAD: po 25 iteracjach N-R nie uzyskano zbieznosci");
end