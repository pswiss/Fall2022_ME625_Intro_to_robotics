function drawPaths(robot_array, which_robots, optional_specified_color)
    % Function will draw the paths that the specified robots have taken
    if(nargin == 3)
        use_specified_color = true;
    else
        use_specified_color = false;
    end

    for rr = which_robots
        hold on
        xx = robot_array(rr).position_history(:,1);
        yy = robot_array(rr).position_history(:,2);
        if(use_specified_color)
            cc = optional_specified_color;
        else
            cc = robot_array(rr).out_color;
        end
        plot(xx,yy,'-','Color',cc)
    end
    drawnow
end
