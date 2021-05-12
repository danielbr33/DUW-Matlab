function [x] = LiczWymuszenia(Q, t, rzadPochodnej, numerWymuszenia)
    parametryFunkcji = WczytajWymuszenia;
    czlon1 = parametryFunkcji(numerWymuszenia, 1);
    czlon2 = parametryFunkcji(numerWymuszenia, 2);
    L = parametryFunkcji(numerWymuszenia, 3);
    a = parametryFunkcji(numerWymuszenia, 4);
    w = parametryFunkcji(numerWymuszenia, 5);
    fi = parametryFunkcji(numerWymuszenia, 6);
    kat = parametryFunkcji(numerWymuszenia, 7);
    if rzadPochodnej == 0
        a = L + a*sin(w*t+fi);
        x(1) = a*cos(kat);
        x(2) = a*sin(kat);
    elseif rzadPochodnej == 1
        a = w*a*cos(w*t+fi);
        x(1) = a*cos(kat);
        x(2) = a*sin(kat);
    elseif rzadPochodnej == 2
        a = -w*w*a*sin(w*t+fi);
        x(1) = a*cos(kat);
        x(2) = a*sin(kat);
    end
end