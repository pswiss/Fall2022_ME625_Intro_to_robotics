clc; clear all; close all
% Example: Forward Kinematics Using Twists
% Robot parameters
L1 = 0.55
L2 = 0.30
L3 = 0.06
W1 = 0.045

% Joint angles (initial)
theta = [0,0, 0, 0, 0, 0, 0]
n_joints = size(theta, 2)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Body Twist Method
% Find M
M07 = [ 1, 0, 0, 0;...
        0, 1, 0, 0;...
        0, 0, 1, L1+L2+L3;...
        0, 0, 0, 1]

% Find the body-frame twists. I personally find it most intuitive to split
% these into two separate varables, but maybe that won't be the case for
% you. Do whatever makes the most sense for your understanding of the
% material
omegas = [  0,0,1;...
            0,1,0;...
            0,0,1;...
            0,1,0;...
            0,0,1;...
            0,1,0;...
            0,0,1   ]

% For the body frame 
vels =  [   0,          0, 0;...
            L1+L2+L3,   0, 0;...
            0,          0, 0;...
            L2+L3,      0, W1;...
            0,          0, 0;...
            L3,         0, 0;...
            0,          0, 0]
        
% Assemble Body twists
B_list = [];
for ii = 1:n_joints
    B_list = [B_list, [omegas(ii,:)';vels(ii,:)']];
end
B_list
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
theta = [0,0, 0, 0, 0, 0, 0]
T_desired = [eye(3), [0.4,0,0]'; 0,0,0,1]
err_omg = 0.01
err_v = 0.001
max_iterations = 20

% Initialization
success = false
theta_list = theta
Vb = TToTwist(invertT(ForwardKinematics(M07,B_list,theta_list))*T_desired)

iterations = 0;
exit_condition = ((norm(Vb(1:3))<err_omg)&&(norm(Vb(4:6))<err_v))||(iterations>max_iterations);
% The main bulk of the algorithm is here

while ~exit_condition
    % TODO: Write a function to update the theta list. This will involve
    % making a function to find the jacobian
    theta_list = theta_list + pinv(makeBodyJacobian(B_list, theta_list))*Vb;
    iterations = iterations + 1;

    Vb = TToTwist(invertT(ForwardKinematics(M07,B_list,theta_list))*T_desired);

    exit_condition = ((norm(Vb(1:3))<err_omg)&&(norm(Vb(4:6))<err_v))||(iterations>max_iterations);
    [wrapToPi(theta_list(:,end)),theta_list(:,end)]
end

iterations
final_thetas = wrapToPi(theta_list(:,end))'

