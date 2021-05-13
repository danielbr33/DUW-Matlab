function [Fi] = RHS(czlon,Dane_PO,Dane_PP,Dane_PPD,t)

    for i=1:size(Dane_PO,1)
        
        Fi((2*i-1):(2*i))=Para_obrotowa(czlon,Dane_PO(i,1),Dane_PO(i,2),Dane_PO(i,3),Dane_PO(i,4));
        
    end
    
    n=size(Fi,2);
    
    for i=1:size(Dane_PP,1)
        
        Fi((2*i-1+n):(2*i+n))=Para_postepowa(czlon,Dane_PP(i,1),Dane_PP(i,2),Dane_PP(i,3),Dane_PP(i,4));
        
    end
    
    n=size(Fi,2);
    
    for i=1:size(Dane_PPD,1)
        
        Fi(i+n)=Para_postepowa_D(czlon,Dane_PPD(i,1),Dane_PPD(i,2),Dane_PPD(i,3),Dane_PPD(i,4),t,i);
        
    end

end

