function rho = bumpFcn(s,h)

    if s >= 0 
        if s < h
            rho = 1 ;
        elseif s < 1
            rho = 0.5 * (1 + cos(pi*((s-h)/(1-h)))) ;
        else 
            rho = 0 ;
        end
    else 
        rho = 0 ;
    end

end