function czlon=NewRaph(czlon,Dane_PO,Dane_PP,Dane_PPD,t)
% q=NewRaph(q0,t)
%	Rozwiązanie układu równań metodą Newtona-Raphsona.
% Wejście:
%	q0 - przybliżenie startowe,
%	t - chwila, dla której poszukiwane jest rozwiązanie.
% Wyjście:
%	q - uzyskane rozwiązanie.
%
% Układ równań musi być wpisany w pliku Wiezy.m.
% Macierz Jacobiego układu równań musi być wpisana w pliku Jakobian.m.

q=Readq(czlon);
F=RHS(czlon,Dane_PO,Dane_PP,Dane_PPD,t);
iter=1; % Licznik iteracji

while ( (norm(F)>1e-10) && (iter < 25) ) 
    
F=RHS(czlon,Dane_PO,Dane_PP,Dane_PPD,t);
F=F';
Fq=Jakobian(czlon,Dane_PO,Dane_PP,Dane_PPD,t,F);
dq=-Fq\F;	% Fq\F jest równoważne inv(Fq)*F, ale mniej kosztowne numerycznie 
q=q+dq;
iter=iter+1;
czlon=Writeq(czlon,q);
%disp(norm(F));

end

if iter >= 25
disp('BŁĄD: Po 25 iteracjach Newtona-Raphsona nie uzyskano zbieżności ');

czlon=Writeq(czlon,q);


end
