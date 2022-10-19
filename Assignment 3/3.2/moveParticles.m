function particle_poses = moveParticles(particle_poses,commanded_drives, commanded_spins, dt)
    % This function moves all of the particles at once given the drive and
    % spin commands.
    
    % First, break apart the poses into positions and orientations
    orientations = particle_poses(:,3);
    positions = particle_poses(:,1:2);
    
    % Update the orientations. Note that because of how these operations
    % work, we're working on *all* the orientations at once
    orientations = wrapToPi(orientations + commanded_spins*dt);
    
    % We then update all of the positions
    positions = positions + commanded_drives*[cos(orientations),sin(orientations)];

    % Re-assemble the poses. This code could be rewritten in fewer lines,
    % but it's clearer like this what's going on.
    particle_poses = [positions, orientations];
end