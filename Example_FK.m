clc; clear all; close all
% Example: Forward Kinematics Using Twists
% Robot parameters
L1 = 0.55
L2 = 0.30
L3 = 0.06
W1 = 0.045

% Joint angles
thetas = [0, pi/4, 0, -pi/4, 0, -pi/2, 0]
n_joints = size(thetas, 2)


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

        %For the body frame 
vels =  [   0,          0, 0;...
            L1+L2+L3,   0, 0;...
            0,          0, 0;...
            L2+L3,      0, W1;...
            0,          0, 0;...
            L3,         0, 0;...
            0,          0, 0]


% Loop through the joints
T_final = M07
for ii = 1:n_joints
    fprintf("The twist for joint %d is:", ii)
    body_screw = [omegas(ii,:), vels(ii,:)]'
    
    % TODO: Create a function that converts screw and theta into T
    T_final = T_final*twist2T(body_screw, thetas(ii))
end

T_final


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Finding the location of a link
M04 = [eye(3), [W1, 0, L1]';0,0,0,1]
% TODO: Create a function that inverts a transformation matrix
M47 = invertT(M04)*M07
T_joint_to_ef = M47
for ii = 5:n_joints
    body_screw = [omegas(ii,:), vels(ii,:)]'
    T_joint_to_ef = T_joint_to_ef*twist2T(body_screw, thetas(ii))
end

T_joint_to_ef
T_joint = T_final*invertT(T_joint_to_ef)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REFERENCE OUTPUT SHOWN BELOW
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% L1 =
% 
%     0.5500
% 
% 
% L2 =
% 
%     0.3000
% 
% 
% L3 =
% 
%     0.0600
% 
% 
% W1 =
% 
%     0.0450
% 
% 
% thetas =
% 
%          0    0.7854         0   -0.7854         0   -1.5708         0
% 
% 
% n_joints =
% 
%      7
% 
% 
% M07 =
% 
%     1.0000         0         0         0
%          0    1.0000         0         0
%          0         0    1.0000    0.9100
%          0         0         0    1.0000
% 
% 
% omegas =
% 
%      0     0     1
%      0     1     0
%      0     0     1
%      0     1     0
%      0     0     1
%      0     1     0
%      0     0     1
% 
% 
% vels =
% 
%          0         0         0
%     0.9100         0         0
%          0         0         0
%     0.3600         0    0.0450
%          0         0         0
%     0.0600         0         0
%          0         0         0
% 
% 
% T_final =
% 
%     1.0000         0         0         0
%          0    1.0000         0         0
%          0         0    1.0000    0.9100
%          0         0         0    1.0000
% 
% The twist for joint 1 is:
% body_screw =
% 
%      0
%      0
%      1
%      0
%      0
%      0
% 
% 
% T_final =
% 
%     1.0000         0         0         0
%          0    1.0000         0         0
%          0         0    1.0000    0.9100
%          0         0         0    1.0000
% 
% The twist for joint 2 is:
% body_screw =
% 
%          0
%     1.0000
%          0
%     0.9100
%          0
%          0
% 
% 
% T_final =
% 
%     0.7071         0    0.7071    0.6435
%          0    1.0000         0         0
%    -0.7071         0    0.7071    0.6435
%          0         0         0    1.0000
% 
% The twist for joint 3 is:
% body_screw =
% 
%      0
%      0
%      1
%      0
%      0
%      0
% 
% 
% T_final =
% 
%     0.7071         0    0.7071    0.6435
%          0    1.0000         0         0
%    -0.7071         0    0.7071    0.6435
%          0         0         0    1.0000
% 
% The twist for joint 4 is:
% body_screw =
% 
%          0
%     1.0000
%          0
%     0.3600
%          0
%     0.0450
% 
% 
% T_final =
% 
%     1.0000         0         0    0.3757
%          0    1.0000         0         0
%          0         0    1.0000    0.7171
%          0         0         0    1.0000
% 
% The twist for joint 5 is:
% body_screw =
% 
%      0
%      0
%      1
%      0
%      0
%      0
% 
% 
% T_final =
% 
%     1.0000         0         0    0.3757
%          0    1.0000         0         0
%          0         0    1.0000    0.7171
%          0         0         0    1.0000
% 
% The twist for joint 6 is:
% body_screw =
% 
%          0
%     1.0000
%          0
%     0.0600
%          0
%          0
% 
% 
% T_final =
% 
%     0.0000         0   -1.0000    0.3157
%          0    1.0000         0         0
%     1.0000         0    0.0000    0.6571
%          0         0         0    1.0000
% 
% The twist for joint 7 is:
% body_screw =
% 
%      0
%      0
%      1
%      0
%      0
%      0
% 
% 
% T_final =
% 
%     0.0000         0   -1.0000    0.3157
%          0    1.0000         0         0
%     1.0000         0    0.0000    0.6571
%          0         0         0    1.0000
% 
% 
% T_final =
% 
%     0.0000         0   -1.0000    0.3157
%          0    1.0000         0         0
%     1.0000         0    0.0000    0.6571
%          0         0         0    1.0000
% 
% 
% M04 =
% 
%     1.0000         0         0    0.0450
%          0    1.0000         0         0
%          0         0    1.0000    0.5500
%          0         0         0    1.0000
% 
% 
% M47 =
% 
%     1.0000         0         0   -0.0450
%          0    1.0000         0         0
%          0         0    1.0000    0.3600
%          0         0         0    1.0000
% 
% 
% T_joint_to_ef =
% 
%     1.0000         0         0   -0.0450
%          0    1.0000         0         0
%          0         0    1.0000    0.3600
%          0         0         0    1.0000
% 
% 
% body_screw =
% 
%      0
%      0
%      1
%      0
%      0
%      0
% 
% 
% T_joint_to_ef =
% 
%     1.0000         0         0   -0.0450
%          0    1.0000         0         0
%          0         0    1.0000    0.3600
%          0         0         0    1.0000
% 
% 
% body_screw =
% 
%          0
%     1.0000
%          0
%     0.0600
%          0
%          0
% 
% 
% T_joint_to_ef =
% 
%     0.0000         0   -1.0000   -0.1050
%          0    1.0000         0         0
%     1.0000         0    0.0000    0.3000
%          0         0         0    1.0000
% 
% 
% body_screw =
% 
%      0
%      0
%      1
%      0
%      0
%      0
% 
% 
% T_joint_to_ef =
% 
%     0.0000         0   -1.0000   -0.1050
%          0    1.0000         0         0
%     1.0000         0    0.0000    0.3000
%          0         0         0    1.0000
% 
% 
% T_joint_to_ef =
% 
%     0.0000         0   -1.0000   -0.1050
%          0    1.0000         0         0
%     1.0000         0    0.0000    0.3000
%          0         0         0    1.0000
% 
% 
% T_joint =
% 
%     1.0000         0         0    0.4207
%          0    1.0000         0         0
%          0         0    1.0000    0.3571
%          0         0         0    1.0000
