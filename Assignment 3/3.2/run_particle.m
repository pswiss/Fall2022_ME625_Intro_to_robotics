%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assignment 3.2: Implementing a particle filter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear all; close all;

% Load in data ------------------------------------------------------------
landmarks = [0, -500; 0,-1000; 0,-1500; 0,-2000; 0,-2500; 1000 , -500; 1000 ,-1000; 1000 ,-1500; 1000 ,-2000; 1000 ,-2500];
load command_drive.mat
load ground_truth.mat
dt = 0.1;
measurement_array = meas;
rng(53705); % Keeps everything consistent
figure

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOU WILL BE MODIFYING THIS (3.4, 3.5)
% Configuration -----------------------------------------------------------
num_particles = 50;
keep_ratio = 0.9;
keep_per_meas = floor(num_particles*keep_ratio);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOU MAY BE MODIFYING THIS (Extra credit)
% Initialize particles
range_of_placement = [2000,0,2000,0];
% Initialize the poses as a bunch of random numbers
particle_poses = 2*rand(num_particles,3)-1;
% Scale and shift the starting locations and orientations
particle_poses(:,1) = particle_poses(:,1)*range_of_placement(1)+range_of_placement(2); 
particle_poses(:,2) = -1*particle_poses(:,2)*range_of_placement(3)+range_of_placement(4);
particle_poses(:,3) = (particle_poses(:,3)*2-1)*pi;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Add some initialization code here for your evaluation functions

% Main Loop ---------------------------------------------------------------
index = 0;
% Loop through all time
for(t = 0:dt:250) 
    % Basically, if we're out of measurements we don't need to do anything
    if(~isempty(measurement_array))
        % Increment the index 
        index = index + 1;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % YOU WILL BE MODIFYING THIS FUNCTION (3.6)
        % Move all the particles according to the drive commands
        particle_poses = moveParticles(particle_poses,commanded_drives(index), commanded_spins(index), dt);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Basically, sometimes we have multiple measurements at the same
        % time step, so we want to loop through all of them. These
        % measurements are purged after use, so the first row of the
        % measurement array 
        while(measurement_array(1,1)<=t)
            %--------------------------------------------------------------
            % Extract the current measurement
            measurement_at_this_time = measurement_array(1,:);
            % Purge the current measurement from the measurement array
            measurement_array(1,:) = [];
            
            % Each measurement is to a landmark. Get the position of that
            % landmark
            landmark_position = landmarks(measurement_at_this_time(2),:);
            
            % Basically, the code breaks if we don't have this. "break"
            % here means "break out of the loop"
            if(isempty(measurement_array))
                break
            end
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % THIS IS WHERE YOU WOULD BE ADDING CODE TO SKIP MEASUREMENTS
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %--------------------------------------------------------------
            % Calculate the probabilities of each particle
            probabilities = particleMeasurementComparison(particle_poses, measurement_at_this_time, landmark_position);
            
            %--------------------------------------------------------------
            % make new particle list based on sampling from all particles
            % using low-variance sampling
            
            % Initialize space for the new particles
            new_particle_list = zeros(num_particles, 3);
            
            % This is somewhat arbitrary, but it harshly penalizes
            % low-probability particles
            weights = probabilities.^2;
            
            % Loop through and add keep_per_meas number of particles from
            % the last batch. This is the low-variance sampling bit.
            % Essentially, stack everything on that line with widths based
            % on the weight, pick a point on that line, and that point will
            % correspond to a given particle
            for(ii = 1:keep_per_meas)
                total_weights = sum(weights);
                target = rand*total_weights;
                sample_index = 1;
                while(sum(weights(1:sample_index)) < target)
                    sample_index = sample_index + 1;
                end
                new_particle_list(ii,:) = particle_poses(sample_index,:);
                particle_poses(sample_index,:) = [];
                weights(sample_index) = [];
            end
            
            % Now generate new particles
            for(ii = (1+keep_per_meas):num_particles)
                % Get new sampled positions
               spread = 1.0;
                new_position = [spread*std(new_particle_list(1:keep_per_meas,1))*randn + mean(new_particle_list(1:keep_per_meas,1)),...
                    spread*std(new_particle_list(1:keep_per_meas,2))*randn + mean(new_particle_list(1:keep_per_meas,2))];
                new_orientation = (2*rand-1)*pi;
                new_particle_list(ii,:) = [new_position, new_orientation];
            end
            
            % Assign the new list to the particle poses
            particle_poses = new_particle_list;
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % YOU MAY BE MODIFYING THIS FUNCTION (Extra Credit)
        % Get the estimated  ----------------------------------------------
        [particle_est_position, particle_est_orientation] = particleCollapseToPose(particle_poses);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % This is just drawing stuff --------------------------------------
        clearDisplay();
        hold on
        drawRobotMotion(commanded_drives, commanded_spins, dt,'-r');
        plot(ground_truth_position(:,1), ground_truth_position(:,2),'-','Color',[0, 0.5, 0],'LineWidth',3);
        plot(particle_poses(:,1),particle_poses(:,2),'ob');
        plot(ground_truth_position(index,1), ground_truth_position(index,2),'og','MarkerFaceColor',[0,0.8,0]);
        plot(particle_est_position(1), particle_est_position(2), 'o','Color',[0.9, 0.9, 0],'LineWidth',2)
        daspect([1,1,1]);
        xlim([-1500,1500]);
        ylim([-2000,1000]);
        drawnow
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot your evaluation functions here