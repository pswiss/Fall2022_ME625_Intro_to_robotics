function drawPaths(robot_array, which_robots)
    % Function will draw the paths that the specified robots have taken
    for rr = which_robots
        hold on
        xx = robot_array(rr).position_history(:,1);
        yy = robot_array(rr).position_history(:,2);
        plot(xx,yy,'-','Color',robot_array(rr).out_color)
    end
    drawnow
end
