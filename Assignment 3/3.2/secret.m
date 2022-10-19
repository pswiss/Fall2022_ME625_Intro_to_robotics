clc; clear all; close all;
load command_drive.mat
% You found the secret code that perturbs the commands to give the
% "Ground truth" data. As well as to generate measurement data
mu_dist = 0;
mu_heading = 0;
sigma_dist = 25;
sigma_heading = pi/30;

dt = 0.1;
rng(847)
ground_truth_position = zeros(length(commanded_spins),2);
ground_truth_orientation = zeros(length(commanded_spins),1);

landmarks = [0, -500; 0,-1000; 0,-1500; 0,-2000; 0,-2500; 1000 , -500; 1000 ,-1000; 1000 ,-1500; 1000 ,-2000; 1000 ,-2500];
fov = pi/3;
p_view_scale = 0.30;

meas = [];

t = 0;

for ii = 2:length(commanded_spins)
    ground_truth_orientation(ii) = ground_truth_orientation(ii-1) + (commanded_spins(ii)+pi/180+(pi/30*(rand-0.5)))*dt;
    ground_truth_position(ii,:) =  ground_truth_position(ii-1,:) + ...
        (-0.005 + 0.05*(2*rand-1) + commanded_drives(ii))*[cos(ground_truth_orientation(ii)), sin(ground_truth_orientation(ii))];
    
    t = t+dt;
    gto = wrapToPi(ground_truth_orientation(ii));
    gtp = ground_truth_position(ii,:);
    
    dist_from_landmarks = sqrt(sum((landmarks - gtp).^2, 2));
    vector_to_landmarks = (landmarks - gtp)./dist_from_landmarks;
    angle_to_landmarks = -wrapToPi(atan2(vector_to_landmarks(:,1),vector_to_landmarks(:,2))-pi/2);
    heading_to_landmarks = wrapToPi(gto - angle_to_landmarks);

    % Corrupt with measurement noise
    dist_from_landmarks = dist_from_landmarks + mu_dist + sigma_dist*randn(10,1);
    heading_to_landmarks = heading_to_landmarks + mu_heading + sigma_heading*randn(10,1);
    
    for(jj = 1:length(landmarks))
        p_add = (1/(dist_from_landmarks(jj)))^(p_view_scale);
        if(rand< p_add)
            if(abs(heading_to_landmarks(jj))<fov)
                meas = [meas; t, jj, dist_from_landmarks(jj), heading_to_landmarks(jj)];
            end
        end
    end
    
end
save ground_truth meas ground_truth_position ground_truth_orientation
