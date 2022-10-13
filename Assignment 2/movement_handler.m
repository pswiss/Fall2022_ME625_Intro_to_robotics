function movement_handler(robot_array, dt, robot_radius)
    % Loop through all robots and update their positions. Robots will
    % always turn. However, if robot forward motion would end up moving
    % into another robot, forward motion is skipped
    n_robots = length(robot_array);

    robot_positions = [];
    for ii = 1:n_robots
        robot_positions = [robot_positions; robot_array(ii).position];
    end

    for rr = 1:n_robots
        % Spin
        robot_array(rr).orientation = ...
            wrapToPi(robot_array(rr).orientation + dt*robot_array(rr).out_spin);
        
        % Figure out if we can move
        desired_next_position = robot_array(rr).position + ...
                 robot_array(rr).out_drive*...
                 [cos(robot_array(rr).orientation), sin(robot_array(rr).orientation)];
        deltas = robot_positions - desired_next_position;
        deltas(rr,:) = [];
        distances = vecnorm(deltas');
        
        % Move
        if(sum(distances<(2*robot_radius))==0)
            robot_array(rr).position = desired_next_position;
        end
        robot_positions(rr,:) = robot_array(rr).position;

        robot_array(rr).updatePoseHistory;

    end
end
