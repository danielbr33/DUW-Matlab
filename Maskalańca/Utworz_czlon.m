function [czlon] = Utworz_czlon(xc0,n,xs0) % Tworzy strukure czlonu z danymi z wektorow

    czlon.xc=[xc0 0]; %Zakladamy na poczatku, ze uklad lokalny czlonu nie jest odwrocony
    
    for i=1:n
       
        czlon.xs(i,1)=xs0((2*i-1))-xc0(1);
        czlon.xs(i,2)=xs0((2*i))-xc0(2);
        
    end

end

