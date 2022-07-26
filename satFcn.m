function satX = satFcn(X, xmin, xmax)

    x1 = X(1,1) ;
    x2 = X(2,1) ;
    
    if x1 <= xmin
        x1 = xmin ;
    elseif x1 < xmax 
        ;
    else 
        x1 = xmax ;
    end
    
    if x2 <= xmin
        x2 = xmin ;
    elseif x2 < xmax 
        ;
    else 
        x2 = xmax ;
    end
    
    satX = [x1 ; x2] ;    

end