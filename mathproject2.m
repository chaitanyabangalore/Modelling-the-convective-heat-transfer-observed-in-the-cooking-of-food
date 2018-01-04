%Analytical Methods Project 2

%Modelling and simulation of partial differential equations for convective
%heat transfer observed in cooking of potatoes

%Submitted by Chaitanya Bangalore, Pujitha Vasantha Gopal


clc; clear all;

m=2; %shape symmetry for spherical coordinates

%COOKED REGION

x1 = linspace(0,0.02,5); %radius range
t1 = linspace(0,200,20); %time range
sol1 = pdepe(m,@pdefun1,@icfun1,@bcfun1,x1,t1); %solving pde for cooked region
k1=0.062E+4; %thermal conductivity at final temperature(W/mK)
figure;
plot(x1,sol1(end,:)/k1);
xlabel('radius r in m');
ylabel('Temperature in K');
title('Cooked region Temperature against Time')

%UNCOOKED REGION

x2 = linspace(0,0.01,5); %half radius range
t2 = linspace(0,200,20); %time range
sol2 = pdepe(m,@pdefun2,@icfun2,@bcfun2,x2,t2); %solving pde for uncooked region
k2=0.166E+4; %thermal conductivity at interface temperature(W/mK)
figure;
plot(x2,sol2(end,:)/k2);
xlabel('radius r in m');
ylabel('Temperature in K');
title('Uncooked region Temperature against Time')

%COOKED REGION FUNCTIONS

function [c,f,s] = pdefun1(x1,t1,u,DuDx) %function of cooked region to pass to pdepe
c = 1;
f = DuDx;
s = 0;
end

function u0 = icfun1(t1) %initial conditions for cooked region 
u0 = 290; %at T=17degree celcius
end

function [pl1,ql1,pr1,qr1] = bcfun1(xl1,ul1,xr1,ur1,t1) %boundary condition for cooked region
h=1.95; %heat transfer coefficient W/m2K
ta1=290; %Initial temperature in kelvin
tb1=368; %final temperature in kelvin
pl1 = 0; 
ql1= 0;
pr1 = h*(ta1-tb1);
qr1 = 20;
end

%UNCOOKED REGION FUNCTIONS

function [c,f,s] = pdefun2(x2,t2,u,DuDx) %function of uncooked region to pass to pdepe
c = 1;
f = DuDx;
s = 0;
end

function u0 = icfun2(t2)
u0 = 290;
end

function [pl2,ql2,pr2,qr2] = bcfun2(xl2,ul2,xr2,ur2,t2) 
h=1.95; %heat transfer coefficient W/m2K
ta2=290; %initial temperature kelvin
tb2=338; %interfacial temperature kelvin
pl2 = 0; 
ql2= 0;
pr2 = h*(ta2-tb2);
qr2 =10 ;
end
