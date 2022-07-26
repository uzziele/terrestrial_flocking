%%
clear all ;
close all ;
%%
% Reference trajectory parameters
a = 0.15 ;
w = 0.1 ;
bias = 0.2 ;

% Initial robot position
x0 = 0.45 ; %0.05 ;
y0 = 0.5 ; %0.40 ;
theta0 = 0 ;  

% Obstacle coordinates 
x_obs = 0.20 ;%0.25 ; % 0.4 %0.15
y_obs = 0.2 ;%0.25 ; % 0.4 % 0.15

% Set point
x_star = 0.15 ;%0.45 ;
y_star =  0.00 ;%0.0 ;

%%
% do 3 turns
%t = sim('saturatedControlSim', 6*pi/w) ;
%t = sim('saturatedControlSim', 20) ;
t = sim('obstacleAvoidance', 20) ;
N = size(xy) ;

%%
close all ;
figure(1) ;
hold on ;
ax = gca ;
ax.ColorOrderIndex = 1 ;
%plot(xy_ref(:,1), xy_ref(:,2), xy(:,1), xy(:,2), '-') ;
plot(xy(:,1), xy(:,2), '-') ;
hold on ;
plot(x0,y0, 'o') ;
hold on ;
plot(x_obs, y_obs, 'o') ;
hold on ;
plot(x_star, y_star, 'o') ;
hold on ;
plot(xy(N(1),1),xy(N(1),2),'x') ;
hold on ;
rectangle('Position', [x_obs - 0.04, y_obs - 0.04 , 0.08, 0.08]);

legend('Trajectory', 'Initial position', 'Obstacle', 'SP', 'Final position') ;
axis square ;
grid on ;

% Posture 
figure() ;
subplot(3,1,1) ;
plot(t,xy(:,1)) ;
grid on ;
subplot(3,1,2) ;
plot(t,xy(:,2)) ; 
grid on ;
subplot(3,1,3) ;
plot(t, state.theta.Data(:,1)) ;
hold on ;
plot(t,theta_ref.Data(:,1)) ;

grid on ;

figure() ;
plot(t, phi_dot)
legend('left', 'right') ;
xlabel('Time [s]') ;
ylabel('Wheel velocity [rad/s]') ;
grid on ;

V = state.v_omega.Data(:,1) ;
omega = state.v_omega.Data(:,2) ;

figure() ;
subplot(2,2,1) ;
plot(t, r1.Data(:,1)) ;
ylabel('r1') ;
grid on ;
subplot(2,2,2) ;
plot(t, r2.Data(:,1)) ;
ylabel('r2') ;
grid on ;
subplot(2,2,3) ;
plot(t, V) ;
grid on ;
subplot(2,2,4) ;
plot(t, omega) ;
grid on ;

figure() ;
sgtitle('Control variables') ;
subplot(4,2,1) ;
plot(t, vs_omegas.Data(:,1)) ;
ylabel('V_s') ;
grid on ;
subplot(4,2,2) ;
plot(t, vs_omegas.Data(:,2)) ;
ylabel('\omega_s') ;
grid on ;
subplot(4,2,3) ;
plot(t, vc_omegac.Data(:,1)) ;
ylabel('V_c') ;
grid on ;
subplot(4,2,4) ;
plot(t, vc_omegac.Data(:,2)) ;
ylabel('\omega_c') ;
grid on ;
subplot(4,2,5) ;
plot(t, V) ;
ylabel('V_s + V_c') ;
grid on ;
subplot(4,2,6) ;
plot(t, omega) ;
ylabel('\omega_s + \omega_c') ;
grid on ;
subplot(4,2,7) ;
plot(t, Fl.Data(:,1)) ;
ylabel('F_l') ;
grid on ;
subplot(4,2,8) ;
plot(t, Fr.Data(:,1)) ;
ylabel('F_r') ;
grid on ;

figure() ;
sgtitle('Obstacle avoidance variables') ;
subplot(3,2,1) ;
plot(t, Fl.Data(:,1)) ;
ylabel('F_l') ;
grid on ;
subplot(3,2,2) ;
plot(t, Fr.Data(:,1)) ;
ylabel('F_r') ;
grid on ;
subplot(3,2,3) ;
plot(t, vc_omegac.Data(:,1)) ;
ylabel('V_c') ;
grid on ;
subplot(3,2,4) ;
plot(t, vc_omegac.Data(:,2)) ;
ylabel('\omega_c') ;
grid on ;
subplot(3,2,5:6) ;
plot(t, distanceToObject.Data(:,1)) ;
ylabel('Distance to obstacle [m]') ;
grid on ;