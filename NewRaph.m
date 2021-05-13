function Q=NewRaph(Q,t, ParyObrotowe, ParyPostepowe, wymuszeniaParametry)
%nie jestem pewna, czy w niektórych funkcjach (nawiasach) nie powinno być
%duże Q zamiast małego q - w sensie konkretnie w pliku Jakobian.m

FI = ones(length(Q),1);
iter=1; %Licznik iteracji
while((norm(FI)>1e-10) && (iter<25))
    FI=Fi(Q, t, ParyObrotowe, ParyPostepowe, wymuszeniaParametry);
    FIq = Jakobian(Q, ParyObrotowe, ParyPostepowe, wymuszeniaParametry);
    Q=Q-FIq\FI;
    iter=iter+1;
end
if iter>=25
    disp("B�?ĄD: po 25 iteracjach N-R nie uzyskano zbieżności");
end