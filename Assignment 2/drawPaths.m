function newPath = drawPaths(paths, robot_array, which_robots, color, suppress_draw);
    % Function will draw the paths that the specified robots have taken
    new_positions = [];
    for rr = which_robots
        new_positions = [new_positions; robot_array(rr).position];
    end

    newPath = [paths, new_positions];
    if(~suppress_draw)
        ii = 1;
        num_paths = length(which_robots);
        if(size(newPath,2)>10)
            for rr = which_robots
                xx = newPath(ii,1:2:end);
                yy = newPath(ii,2:2:end);
                hold on
                plot(xx,yy,'-', 'Color', color)
            end
        end
        drawnow
    end
end
