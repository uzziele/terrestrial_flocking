%%
clear all ;
close all ;

blue_ = [0,0.4470,0.7410] ;
red_ = [0.8500 0.3250 0.0980] ;
yellow_ = [0.9290 0.6940 0.1250 ] ;
green_ = [0.4660, 0.6740, 0.1880] ;
gray_ = [0.8000, 0.8000, 0.8000] ;

%% Initial State of the Robots
% Reference trajectory parameters
a = 0.15 ;
w = 0.1 ;
bias = 0.2 ;
% 
% Initial robot position - Robot 1
x01 = 0.2 ; %0.05 ;
y01 = 0.25 ; %0.40 ;
theta01 = 0 ;  

% Initial robot position - Robot 2
x02 = 0.07 ; %0.05 ;
y02 = 0.5; %0.40 ;
theta02 = pi/2 ;  

% Initial robot position - Robot 3
x03 = 0.05 ; %0.05 ;
y03 = 0.3; %0.40 ;
theta03 = pi/4 ;  

% Obstacle coordinates 
x_obs = 1.5 ;%1 ;% 0.6 ;%0.25 ; % 0.4 %0.15
y_obs = 1 ;% 0.6 ;%0.25 ; % 0.4 % 0.15
obsR = 0.15 ;% 0.1 ;

% Formation barycenter set point
x_star = 2.2 ; %0.45 ;
y_star =  1 ; %0.0 ;

%% Run simulation
% Run the model
t = sim('flockingModel', 300) ;
N = size(xy1) ;

% Final barycenter
xf = 1/3 * (xy1(N(1,1),1) + xy2(N(1,1),1) + xy3(N(1,1),1)) ;
yf = 1/3 * (xy1(N(1,1),2) + xy2(N(1,1),2) + xy3(N(1,1),2)) ;

inc = round(N(1,1)/10) ;

%% Plot MRS path
close all ;
figure(1) ;

p1 = plot(xy1(:,1), xy1(:,2), '-', 'LineWidth',1, 'Color', blue_) ;
hold on ;
plot(x01,y01, 'o', 'Color', blue_) ;
hold on ;
plot(xy1(N(1),1),xy1(N(1),2), 'o', 'Color', blue_) ;

hold on ;
p2 = plot(xy2(:,1), xy2(:,2), '-', 'LineWidth',1, 'Color', red_) ;
hold on ;
plot(x02,y02, 'o', 'Color', red_) ;
hold on ;
plot(xy2(N(1),1),xy2(N(1),2), 'o', 'Color', red_) ;

hold on ;
p3 = plot(xy3(:,1), xy3(:,2), '-', 'LineWidth',1, 'Color', green_) ;
hold on ;
plot(x03,y03, 'o', 'Color', green_) ;
hold on ;
plot(xy3(N(1),1),xy3(N(1),2),'o', 'Color', green_) ;

hold on ;
p5 = plot(x_star, y_star, 'o', 'Color', yellow_) ;

hold on ;
p4 = plot(xf, yf, 'x', 'Color', yellow_) ;

hold on ;
p6 = plot(x_obs, y_obs, 'o', 'Color', gray_) ;
set(p6, 'markerfacecolor', get(p6, 'color')) ;
circles(x_obs, y_obs, obsR, 'facecolor', gray_, 'edgecolor', gray_);

hold on ; 
line([x01, x02], [y01, y02], 'Color', 'black') ;
hold on ; 
line([x01, x03], [y01, y03], 'Color', 'black') ;
hold on ; 
line([x02, x03], [y02, y03], 'Color', 'black') ;

hold on ; 
line([xy1(N(1),1), xy2(N(1),1)], [xy1(N(1),2), xy2(N(1),2)], 'Color', 'black') ;
hold on ; 
line([xy1(N(1),1), xy3(N(1),1)], [xy1(N(1),2), xy3(N(1),2)], 'Color', 'black') ;
hold on ; 
line([xy2(N(1),1), xy3(N(1),1)], [xy2(N(1),2), xy3(N(1),2)], 'Color', 'black') ;

for i=1:4
    
    hold on ; 
    line([xy1(inc*i,1), xy2(inc*i,1)], [xy1(inc*i,2), xy2(inc*i,2)], 'Color', 'black') ;
    hold on ; 
    plot(xy1(inc*i,1), xy1(inc*i,2), 'o', 'Color', blue_) ;    
    hold on ; 
    line([xy1(inc*i,1), xy3(inc*i,1)], [xy1(inc*i,2), xy3(inc*i,2)], 'Color', 'black') ;
    hold on ;
    plot(xy2(inc*i,1), xy2(inc*i,2), 'o', 'Color', red_) ;
    hold on ; 
    line([xy2(inc*i,1), xy3(inc*i,1)], [xy2(inc*i,2), xy3(inc*i,2)], 'Color', 'black') ;  
    hold on ;
    plot(xy3(inc*i,1), xy3(inc*i,2), 'o', 'Color', green_) ;
end

xlim([0,2.5]) ;
ylim([0,2]) ;

legend([p1 p2 p3 p4 p5 p6],'Path robot 1', 'Path robot 2', 'Path robot 3', 'Formation SP', 'Final barycenter', 'Obstacle' , 'Location', 'southeast', 'interpreter', 'latex') ;
xlabel('{$x$ [m]}','interpreter', 'latex', 'FontSize', 14) ;
ylabel('{$y$ [m]}','interpreter', 'latex', 'FontSize', 14) ;

grid on ;

%% Plotting interdistances

d12 = zeros(N(1),1) ;
d13 = zeros(N(1),1) ;
d23 = zeros(N(1),1) ;

for i=1:N(1)
    d12(i,1) = norm(xy1(i,:) - xy2(i,:)) ;
    d13(i,1) = norm(xy1(i,:) - xy3(i,:)) ;
    d23(i,1) = norm(xy2(i,:) - xy3(i,:)) ;
end

figure(2) ;
subplot(2,1,1) ;
plot(t, d12, 'LineWidth',1, 'Color', blue_) ;
hold on;
plot(t, d13, 'LineWidth',1, 'Color', red_) ;
hold on ;
plot(t, d23, 'LineWidth',1, 'Color', green_) ;
grid on ; 
legend('{$d_{12}$}','{$d_{13}$}','{$d_{23}$}','interpreter', 'latex', 'FontSize', 12);
%legend('d12', 'd13', 'd23') ;
xlabel('time [s]', 'interpreter', 'latex', 'FontSize', 14) ;
ylabel('interdistance [m]', 'interpreter', 'latex', 'FontSize', 14) ;

%xlim([0, 150]) ;
%ylim([0.2, 0.65]) ;

%% Distance to obstacle 

dobsR1 = zeros(N(1),1) ;
dobsR2 = zeros(N(1),1) ;
dobsR3 = zeros(N(1),1) ;

for i=1:N(1,1)
   
    dobsR1(i) = distanceToObs(xy1(i,:), [x_obs, y_obs], obsR) ;
    dobsR2(i) = distanceToObs(xy2(i,:), [x_obs, y_obs], obsR) ;
    dobsR3(i) = distanceToObs(xy3(i,:), [x_obs, y_obs], obsR) ;
    
end

subplot(2,1,2) ;
plot(t, dobsR1, 'LineWidth',1, 'Color', blue_) ;
hold on;
plot(t, dobsR2, 'LineWidth',1, 'Color', red_) ;
hold on ;
plot(t, dobsR3, 'LineWidth',1, 'Color', green_) ;
grid on ; 
legend('{$d_{R1}$}','{$d_{R2}$}','{$d_{R3}$}','interpreter', 'latex', 'FontSize', 12);
xlabel('time [s]', 'interpreter', 'latex', 'FontSize', 14) ;
ylabel('{$d_{Ri}$} [m]', 'interpreter', 'latex', 'FontSize', 14) ;

%% Control signal extraction

v1 = state1.v_omega.Data(:,1) ;
v2 = state2.v_omega.Data(:,1) ;
v3 = state3.v_omega.Data(:,1) ;
omega1 = state1.v_omega.Data(:,2) ;
omega2 =  state2.v_omega.Data(:,2) ;
omega3 =  state3.v_omega.Data(:,2) ;
