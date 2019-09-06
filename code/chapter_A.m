% Edw upologizw ola osa zhtountai sto prwto meros ths anaforas
clear all;
close all;

%% Xrhsh sym gia na mporesoume na kanoume tis prakseis sto Matlab 

q1=sym('q1', 'real');
l1=sym('l1', 'real');

q2=sym('q2', 'real');
l2=sym('l2', 'real');

q3=sym('q3', 'real');
l3=sym('l3', 'real');

syms lvx lvy lvz; 

syms vvx vvy vvz; % dianusma taxuthtwn ar8rwsewn


%% eisagwgh pinakwn A01,A12,A23,A3E 

% h eisagwgh twn pinakwn egine xeirokinhta afou tous upologisa sto xarti

A01 = [cos(q1)  0	sin(q1)     0;
       sin(q1)  0	-cos(q1)    0;
       0        1	0           l1;
       0        0	0           1];
   
A(:,:,1) = A01;   

A12 = [cos(q2)  0       -sin(q2)  l2*cos(q2);
       sin(q2)	0       cos(q2)   l2*sin(q2);
       0        -1      0         0;
       0        0       0         1];
 
A(:,:,2) = A(:,:,1)*A12;

   
A23 = [cos(q3)  -sin(q3)    0       l3*cos(q3);
       sin(q3)  cos(q3)     0       l3*sin(q3);
       0        0           1       0;
       0        0           0       1];
   
A(:,:,3) = A(:,:,2)*A23;

% o A3E epeidh den exei metablhtes prepei na ton kanw na moiazei me tous
% allous pinakes gi auto bazw thn entolh sym(...) 

A3E = sym([0    0   -1  0;
       0    1   0   0;
       1    0   0   0;
       0    0   0   1]);

%upologismos toy AOE
A0E = A(:,:,3)*A3E;

%%

% apo ton orismo exw oti b kai r isoutai me(apo diafaneies): 
b = [0; 0; 1];
r = [0; 0; 0; 1];

% orismos pinakwn pou 8a xrhsimopoihsw kai 8a exoun mesa metablhtes 
bi = sym('a',[3 1]);
Helper = eye(4);
ri = sym('a',[3 1]);
matrix_R = eye(3);
Jacobian = sym('a',[6 3]);
% upologismos zhtoumenwn mege8wn
for i = 1:3
    bi(:, i)=matrix_R*b;
    temp_arr = A(:,:,3)*r - Helper*r;
    ri(:, i) = temp_arr(1:3);
    % cross is necessary to have the right result
    Jacobian(1:3,i) = cross(bi(:,i),ri(:,i));
    Jacobian(4:6,i) = bi(:, i);
    matrix_R = A(1:3, 1:3, i);
    Helper = A(:,:,i);
end

%% Find the det of the Jacobian 

Jacobian_1_3 = Jacobian(1:3, :);
%make the det of the jacobian have a more simple form
det_Jacobian = simplify(det(Jacobian_1_3));
%find the inverse of the Jacobian
Inv_Jacobian = inv(Jacobian_1_3);

%% Eu8u diaforiko montelo
p_der = Jacobian_1_3*[vvx; vvy; vvz];

p1_derivative = p_der(1);
p2_derivative = p_der(2);
p3_derivative = p_der(3);


pretty(p1_derivative);
pretty(p2_derivative);
pretty(p3_derivative);


%% Antistrofo diaforiko montelo
q_der = Inv_Jacobian*[lvx; lvy; lvz];

q1_derivative = q_der(1);
q2_derivative = q_der(2);
q3_derivative = q_der(3);

pretty(q1_derivative);
pretty(q2_derivative);
pretty(q3_derivative);

%% Singular Configurations
var = (det_Jacobian == 0);
singular_q1 = solve(var, q1);
singular_q2 = solve(var, q2);
singular_q3 = solve(var, q3);




