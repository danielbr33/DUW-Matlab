function Q=NewRaph(Q,t,F, Fq)
%nie jestem pewna, czy w niektórych funkcjach (nawiasach) nie powinno być
%duże Q zamiast małego q - w sensie konkretnie w pliku Jakobian.m

iter=1; %Licznik iteracji
while((norm(F)>1e-10)&(iter<25))
   Q=Q-Fq\F;
    iter=iter+1;
end
if iter>=25
    disp("B�?ĄD: po 25 iteracjach N-R nie uzyskano zbieżności");
end
