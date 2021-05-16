function [ x ] = Wymuszenie( indeks, pochodna, t,ParyPostepowe, WymPostepowe )
    %Zwraca dla danego czasu wartość danej pochodnej wybranego wymuszenia
    %postępowego
    
     a = (ParyPostepowe(indeks).L_i - ParyPostepowe(indeks).L_j);
     L = norm(a);
%      
     L1=sqrt((ParyPostepowe(indeks).L_i(1)-ParyPostepowe(indeks).L_j(1))^2+(ParyPostepowe(indeks).L_i(2)-ParyPostepowe(indeks).L_j(2))^2);
    
     %L = ParyPostepowe(ineks
     A=WymPostepowe(indeks,2);
     OM=WymPostepowe(indeks,3);
     FI=WymPostepowe(indeks,4);

    if(pochodna == 0)
    
            x = L + A*sin(OM*t + FI);
            
       
    elseif(pochodna == 1)
        
             x = A*OM*cos(OM*t + FI);
               
    elseif(pochodna == 2)
             
             x = -A*OM*OM*sin(OM*t + FI);
                
 
    else
        disp('Zbyt duży bądź nieprawidłowy indeks pochodnej')
    end


