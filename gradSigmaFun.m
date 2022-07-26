function grad = gradSigmaFun(Z, epsilon)

    grad = Z ./ (1 + epsilon*sigmaNormFun(Z,epsilon)) ;
    
end