function [position_guess, orientation_guess] = particleCollapseToPose(particle_poses)
    % Basically, where are the particles "saying" that the robot is?
    
    % Simplest method: Just take the averages
    x = mean(particle_poses(:,1));
    y = mean(particle_poses(:,2));
    position_guess = [x, y];
    
    % Note: this is a *terrible* way to average orientations. For example,
    % -175 degrees and +175 degrees will average to zero, rather than to
    % 180 degrees
    orientation_guess = mean(particle_poses(:,3));
end

