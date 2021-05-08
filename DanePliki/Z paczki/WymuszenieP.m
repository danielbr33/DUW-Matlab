function [ x ] = WymuszenieP( indeks, pochodna, t,ParyPostepowe, WymPostepowe )
    %Zwraca dla danego czasu wartoœæ danej pochodnej wybranego wymuszenia
    %postêpowego
    
    
     L=sqrt((ParyPostepowe(indeks,10)-ParyPostepowe(indeks,12))^2+(ParyPostepowe(indeks,11)-ParyPostepowe(indeks,13))^2);
     A=WymPostepowe(indeks,3);
     OM=WymPostepowe(indeks,4);
     FI=WymPostepowe(indeks,5);

    if(pochodna == 0)
    
            x = L + A*sin(OM*t + FI);
            
       
    elseif(pochodna == 1)
        
             x = A*OM*cos(OM*t + FI);
               
    elseif(pochodna == 2)
             
             x = -A*OM*OM*sin(OM*t + FI);
                
 
    else
        disp('Zbyt du¿y b¹dŸ nieprawid³owy indeks pochodnej')
    end


