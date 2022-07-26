xc = 5 ;
yc = 5 ;
R = 2 ;

xr = 1.5 ;
yr = 9 ;

Xc = [xc ; yc] ;
Xr = [xr ; yr] ;

P = Xc + (Xr - Xc) * R /norm(Xr - Xc) ;

figure() ;
plot(P(1,1), P(2,1), 'x') ;
hold on ;
plot(xr, yr, 'o') ;
hold on ;
viscircles([xc, yc], R, 'LineWidth', 1) ;
xlim([0,10]) ;
ylim([0,10]) ;

