function communication_handler(robot_array, max_comm_dist)
    n_robots = length(robot_array);
    for(ii = 1:n_robots)
        robot_array(ii).clearCommIn();
    end

    % Take Every robot and compare it to the other robots
    for(r1 = 1:(n_robots-1))
        for(r2 = (r1+1):n_robots)
            % Get the vector of communication
            comm_vector = (robot_array(r2).position - robot_array(r1).position);

            % Only complete the transmission if within some distance
            distance = norm(comm_vector);
            if(distance<max_comm_dist)
%                 distance
                angle_comm = atan2(comm_vector(2),comm_vector(1) );
                % Communication format: [distance, heading, message
                % (whatever length might be used)
                m2 = robot_array(r2).comm_out;
                m2.addDistanceInfo(distance, wrapToPi(angle_comm-robot_array(r1).orientation));
                robot_array(r1).loadCommIn(m2);
                
                m1 = robot_array(r1).comm_out;
                m1.addDistanceInfo(distance, wrapToPi(angle_comm + pi-robot_array(r2).orientation));
                robot_array(r2).loadCommIn(m1);
            end
        end
    end
end