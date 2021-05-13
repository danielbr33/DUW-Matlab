function [Fi] = Gamma(czlon,Dane_PO,Dane_PP,Dane_PPD,t,dq)

    for i=1:size(Dane_PO,1)
        
        Fi((2*i-1):(2*i))=Gamma_obrotowa(czlon,Dane_PO(i,:),dq);
        
    end
    
    n=size(Fi,2);
    
    for i=1:size(Dane_PP,1)
        
        Fi((2*i-1+n):(2*i+n))=Gamma_postepowa(czlon,Dane_PP(i,:),dq);
        
    end
    
    n=size(Fi,2);
    
    for i=1:size(Dane_PPD,1)
        
        Fi(i+n)=Gamma_kierujaca(czlon,Dane_PPD(i,:),dq,t);
        
    end

end