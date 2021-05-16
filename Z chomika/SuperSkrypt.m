%% 
% Utworzenie pustej struktury do przechowywania wiêzów w postaci ogónej
Wiezy = struct('typ',{},... % dopisanych czy kinematyczny
    'klasa',{},... % para postepowa czy obrotowa (innych na razie nie ma)
    'bodyi',{},... % numer pierwszego ciala
    'bodyj',{},... % numer drugiego ciala
    'sA',{},... % wektor sA w i-tym ukladzie
    'sB',{},... % wektor sB w j-tym ukladzie
    'phi0',{},... % kat phi0 (jezeli para obrotowa - nie uzywamy)
    'perp',{},... % wersor prostopadly osi ruch (jezeli para obrotowa - nie uzywamy)
    'fodt',{},... % funkcja od czasu dla wiezow dopisanych
    'dotfodt',{},... % pochodna funkcji od czasu dla wiezow dopisanych
    'ddotfodt',{}) % druga pochodna funkcji od czasu dla wiezow dopisanych


% Wczytanie wiêzów opisuj¹cych mechanizm
input_wiezy;
% Inicjalizacja zmiennej do wyznaczania liczby równañ wiêzów 
rows = 0;

%% PAUSE


for l=1:length(Wiezy)
    if(lower(Wiezy(l).typ(1)) == 'd')
        if(lower(Wiezy(l).klasa(1)) == 'o')
            rows = rows + 1;
        elseif(lower(Wiezy(l).klasa(1)) == 'p')
            rows = rows + 1;
        else
            error(['Blednie podana klasa dla wiezu nr ', num2str(l)]);
        end
    elseif(lower(Wiezy(l).typ(1)) == 'k')
        if(lower(Wiezy(l).klasa(1)) == 'o')
            rows = rows + 2;
        elseif(lower(Wiezy(l).klasa(1)) == 'p')
            rows = rows + 2;
        else
            error(['Blednie podana klasa dla wiezu nr ', num2str(l)]);
        end
    else
        error(['Blednie podany typ dla wiezu nr ', num2str(l)]);
    end
end

%% PAUSE

[T,Q,DQ,D2Q]=Mechanizm(Wiezy, rows);






    