function sigmaNorm = sigmaNormFun(Z, epsilon)

    sigmaNorm = 1 / epsilon * (sqrt(1 + (epsilon*norm(Z)^2)) - 1) ;
    
end