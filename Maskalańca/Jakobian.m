function [J1] = Jakobian(czlon,Dane_PO,Dane_PP,Dane_PPD,t,Fi)

    J=zeros(length(Fi),3*(length(czlon)-1));
    
    for k=1:size(Dane_PO,1)
        
        if (Dane_PO(k,1)~=1)
            
            pom=Jakobian_obrotowy(czlon,Dane_PO(k,:));
            i=Dane_PO(k,1);
            j=Dane_PO(k,2);
            J((2*k-1):(2*k),(3*i-5):(3*i-3))=pom(:,1:3);
            J((2*k-1):(2*k),(3*j-5):(3*j-3))=pom(:,4:6);
            
        else
            
            pom=Jakobian_obrotowy(czlon,Dane_PO(k,:));
            j=Dane_PO(k,2);
            J((2*k-1):(2*k),(3*j-5):(3*j-3))=pom(:,4:6);
            
        end
        
    end
    
    n=2*size(Dane_PO,1);
    
    for k=1:size(Dane_PP,1)
        
        pom=Jakobian_postepowy(czlon,Dane_PP(k,:));
        i=Dane_PP(k,1);
        j=Dane_PP(k,2);
        J((2*k-1+n):(2*k+n),(3*i-5):(3*i-3))=pom(:,1:3);
        J((2*k-1+n):(2*k+n),(3*j-5):(3*j-3))=pom(:,4:6);
        
    end
    
    n=n+2*size(Dane_PPD,1);
    
    for k=1:size(Dane_PPD,1)
        
        pom=Jakobian_postepowy_D(czlon,Dane_PPD(k,:));
        i=Dane_PPD(k,1);
        j=Dane_PPD(k,2);
        J((k+n),(3*i-5):(3*i-3))=pom(:,1:3);
        J((k+n),(3*j-5):(3*j-3))=pom(:,4:6);
        
    end
    
    J1=J;
    
end

