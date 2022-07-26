function d = distanceToObs(Pi, Pc, R)

    Pobs = Pc + (Pi - Pc) * (R /norm(Pi - Pc)) ;
    
    d = norm(Pi - Pobs) ;

end