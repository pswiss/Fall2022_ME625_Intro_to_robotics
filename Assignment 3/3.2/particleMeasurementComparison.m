function probabilities = particleMeasurementComparison(particle_poses, meas, landmark_location)
    % Determine the probability of a particle being positioned correctly
    % given the measurements and the known landmark locations
    
    % Prep and pre-allocation
    num_particles = length(particle_poses);
    errs = zeros(num_particles,2); % position, heading
    
    % Loop through all particles and check the errors
    for(ii = 1:num_particles)
        [errs(ii,1),errs(ii,2)] = error_of_pose(particle_poses(ii,1:2), particle_poses(ii,3), meas, landmark_location);
    end
    
    % Statistical properties
    mu_dist = 0;
    mu_heading = 0;
    sigma_dist = 25;
    sigma_heading = pi/30;
    
    % Calculate the probabilities given the erros and the known statistical
    % properties of the measurements
    range_probabilities = normpdf(errs(:,1),mu_dist, sigma_dist);
    heading_probabilities = normpdf(errs(:,2),mu_heading, sigma_heading);
    
    % Probabilists will HATE this, but I like to (essentially) normalize my
    % probabilities from disparate sources to prevent any one factor
    % dominating the answer. This also prevents driving probabilities down
    % to below the resolution of a floating point number.
    range_probabilities = range_probabilities / max(range_probabilities);
    heading_probabilities = heading_probabilities / max(heading_probabilities);
    
    % Synthesize the final probability
    probabilities = range_probabilities.* heading_probabilities;
end

