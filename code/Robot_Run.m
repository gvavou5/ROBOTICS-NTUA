% deutero meros eksamhniais ergasias
clear all;
close all;

% i use a robotic toolbox so i have to insert it to the Matlab to create
% the robot. The following command does this. because of it this code runs
% only if you have this toolbox
addpath(genpath('./robot'));

% orizw ta mhkh twn sundesmwn opws egw 8elw sumfwna me thn ekfwnhsh ths
% askhshs
aksonas(1) = 16.0; aksonas(2) = 22.0;  aksonas(3) = 16.0;

%xrhsimopoiw mia etoimh sunarthsh apo to toolbox gia na kataferw na ftiaksw
%ta links 
L(1) = Link([0 aksonas(1) 0 pi/2]);L(2) = Link([0 0 aksonas(2) -pi/2]);
L(3) = Link([0 0 aksonas(3) 0]);L(4) = Link([0 0 0 0]);L(4).offset = -pi/2;
L(5) = Link([0 0 0 -pi/2]);
myRobot = SerialLink(L, 'name', 'Robotic Manipulator with 3 rotational DOF');

%Orismoi mege8wn
R = 14;       %aktina
duration = 10.0;%h kinhsh diarkei 10 sec
der_t = 0.01; 
time = 0:der_t:duration;  
% returns linearly spaced points.
space_tf = linspace(0,2*pi,size(time,2)); 
%epipedo z 
z_axe = ones(1,size(time,2)); 
z_axe = z_axe*22;   %orismos epipedou z gia to robot moy
%orismos tou kentroy tou robot
x_axe = R*cos(space_tf)+5;    
y_axe= R*sin(space_tf)+5;

%same as the sample.script
var1  = acos((x_axe.^2 + y_axe.^2 + (z_axe-aksonas(1)).^2 - aksonas(2)^2 - aksonas(3)^2)/(2*aksonas(2)*aksonas(3)));
var2  = asin((z_axe-aksonas(1))./(aksonas(2)+aksonas(3)*cos(var1)));
flag  = size(time,2);
Index = aksonas(3)*sin(var1)./(aksonas(2)*cos(var2) + aksonas(3)*cos(var2).*cos(var1));
var3  = atan((y_axe-Index.*x_axe)./(y_axe+Index.*x_axe)); var4  = pi + var3;
for i=1:flag
    [X1, Y1, Z1] = LocDet( var3(i), var2(i), var1(i), aksonas(1), aksonas(2), aksonas(3) );
    [X2, Y2, Z2] = LocDet( var4(i), var2(i), var1(i), aksonas(1), aksonas(2), aksonas(3) );
    if (x_axe(i) - X1)^2 + (y_axe(i) - Y1)^2 + (z_axe(i) - Z1)^2 >= (x_axe(i) - X2)^2 + (y_axe(i) - Y2)^2 + (z_axe(i) - Z2)^2
                q1(i) = var4(i);
    else
                q1(i) = var3(i);
    end
end
% See the robot's motion
figure();
q_robot_view = zeros(size(time,2),5);
q_robot_view(:,1) = q1';
q_robot_view(:,2) = var2';
q_robot_view(:,3) = var1';
%3d plot
plot3(x_axe,y_axe,z_axe);
myRobot.plot(q_robot_view);
%create all the other plots
plot_maker(x_axe,y_axe,z_axe,der_t,q1,var2,var1);



